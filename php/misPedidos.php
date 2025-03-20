    <!--------------------------                           PHP                            --------------------------------->
    <?php
   

    require('general.php');

    //Conexión a la BBDD
    $cadena_conexion = "mysql:dbname=libreria;host=127.0.0.1";
    $usuario = "root";
    $bd = new PDO($cadena_conexion, $usuario);
    $bd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_SILENT);

    //Redirigido
    if (isset($_SESSION['usuario'])) {
        $idUsu = $_SESSION['usuario']['IdUsuario'];
    } else if (!isset($_SESSION['usuario'])) {
        header("location: login.php?redirigido=true");
    }

    
///////          POST/COOKIE DEVOLUCION          ////////

//Declaramos el nombre y valor de la cookie
$nombreCookieDevoluciones = "devoluciones_" . $_SESSION['usuario']['IdUsuario'];
$devolucionesActuales = isset($_COOKIE[$nombreCookieDevoluciones]) ? unserialize($_COOKIE[$nombreCookieDevoluciones]) : array();

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["id_devolucion_pedido"])) {
    //Arrays que contendran las id y cantidad de lo libros devueltos de ese post
    $idLibros = array();
    $cantidadesDev = array();

    //Se ejecuta si minimo un checkbox de un libro esta selecionado
    if (isset($_POST['idLibro'])) {
        
        /*Se enlaza el id del libro con su cantidad correspondiente, para 
        no aplastarse y enlazar bien los valores entre si*/
        foreach ($_POST['idLibro'] as $index => $idLibro) {
                // Cojemos la cantidad y la juntamos con el id del libro
                $cantidadDev = $_POST['cantidadDev'][$index];

                // Se almacena el id del libro y la cantidad devuelta en sus arrays
                $idLibros[] = $idLibro;
                $cantidadesDev[] = $cantidadDev; 
            }    
        
        $id_devolucion_pedido = $_POST["id_devolucion_pedido"];

        //Consulta BD - para obtener la fecha del pedido
        $stmt = $bd->prepare("SELECT p.Fecha
                           FROM pedido p, usuario u
                           WHERE u.IdUsuario = :idUsuario AND p.IdPedido = :idPedido");

        $stmt->bindParam(':idUsuario', $idUsu);
        $stmt->bindParam(':idPedido', $id_devolucion_pedido);
        $stmt->execute();
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        //Declaramos las variables con la fecha actual y la del pedido
        $fecha_actual = new DateTime();
        $fecha_pedido = new DateTime($row['Fecha']);

        //Restamos ambas fechas y obtenemos los dias de diferencia
        $diferencia = $fecha_actual->diff($fecha_pedido);
        $diferencia_en_dias = intval($diferencia->days);//lo pasamos a int 

        //Si la diferencia de dias es = ó menor de 40 se ejecuta
        if ($diferencia_en_dias <= 40) {
          
            //Comprobamos si en la cookie existe
            $devolucionExistente = false;
             foreach ($devolucionesActuales as $devolucion) {
                //Se cumple si el id del pedido posteado y de la cookie es igual
                 if ($devolucion['idPedido'] == $id_devolucion_pedido ) {
                     $devolucionExistente = true;
                     break;
                 }        
             }

            //Se ejecuta si se cumple el if anterior
            if ($devolucionExistente) {
                echo '<script>
                            Swal.fire({
                                icon: "error",
                                title: "Ya has realizado una devolucion de este pedido",
                                showConfirmButton: false,
                                timer: 2000
                            });
                        </script>';
            
            } else {
                ///////  Se inicia la transacción   //////
                $bd-> beginTransaction();

                //Valores predeterminados
                 $contador = 1;
                $dineroReembolsado = 0;
                
                //Se selecciona los idLibro
                foreach ($idLibros as $index => $idLibro) {

                    //Por la cantidad de libros en la cookie el contador aumenta
                    foreach ($devolucionesActuales as $devolucion) {
                        $contador++;
                    }

                    //Declaramos la cantidad a devolver enlazada a su id libro
                    $cantidadDev = $cantidadesDev[$index];
                   
                    //Al titulo del array se le añade el contador para evitar aplastar valores
                    $titulo = $id_devolucion_pedido . $contador;

                    //Insercion de datos
                    $devolucionesActuales[$titulo] = array(
                        'idPedido' => $id_devolucion_pedido,
                        'idLibro' => $idLibro,
                        'cantidadDev' => $cantidadDev
                    );

                    //Para que el contador vuelva a 1 y no incremente tan drasticamente
                    $contador = 1;

                    //Consulta BD - del precio del libro
                    $consulta = $bd->prepare("SELECT Precio
                                                FROM libro 
                                                WHERE IdLibro = ?");
                    $consulta->execute([$idLibro]);
                    $precio = $consulta->fetch(PDO::FETCH_ASSOC);

                    //Calculo del precio del libro x su cantidad y la suma de este al dinero reembolsado
                    $precio_LibroCantidad = $precio['Precio'] * $cantidadDev;
                    $dineroReembolsado += $precio_LibroCantidad;

                    //Actualizacion del 'stock' del libro
                    $upt= "UPDATE libro SET Stock = Stock + :cantidadDev/2 WHERE IdLibro = :idLibro";  
                    $resultUpdate = $bd->prepare($upt);
                    $resultUpdate->execute(array(':idLibro' => $idLibro,':cantidadDev'=> $cantidadDev));

                    //Si se genera algun error se revierte la transación
                    if(!$resultUpdate->execute(array(':idLibro' => $idLibro,':cantidadDev'=> $cantidadDev))){
                        $err = TRUE;
                    }
                    
                }

                
                //Actualizacion del 'saldo' del usuario
                $upt= "UPDATE usuario SET Saldo = Saldo + :dineroReembolsado/2 WHERE IdUsuario = :usuario";
                $resultUpdate = $bd->prepare($upt);
                $resultUpdate->execute(array(':usuario' => $idUsu,':dineroReembolsado'=> $dineroReembolsado));

                //Si se genera algun error se revierte la transación                   
                if(!$resultUpdate->execute(array(':usuario' => $idUsu,':dineroReembolsado'=> $dineroReembolsado))){
                    $err = TRUE;
                }

                /*Se cataloga el pedido como reembolsado (de 0 a 1, siendo 0=no reembolsado y 1=reembolsado)
                 en la tabla pedido*/
                $upt2 = "UPDATE pedido SET Reembolso = 1 WHERE IdPedido = :idPedido";
                $resultUpdate2 = $bd->prepare($upt2);
                $resultUpdate2->execute(array(':idPedido'=> $id_devolucion_pedido));
                
                //Si se genera algun error se revierte la transación                   
                if(!$resultUpdate2->execute(array(':idPedido'=> $id_devolucion_pedido))){
                    $err = TRUE;
                }
                
                // Actualizamos la cookie de devoluciones
                setcookie($nombreCookieDevoluciones, serialize($devolucionesActuales), time() + (86400 * 365 * 10));
                echo '<script>
                            Swal.fire({
                                icon: "success",
                                title: "Se ha realizado la devolucion",
                                showConfirmButton: false,
                                timer: 1000
                            });
                        </script>'; 
                
                //Si no se a dado ningun error=true la transaccion se realiza correctamente
                if(isset($err)){
                    $bd->rollback();
                }else{
                    $bd->commit();
                }
            }
            
        }else{
            //Mensaje error por pasarse de la fecha (40 dias desde la compra)
            echo '<script>
                    Swal.fire({
                        icon: "error",
                        title: "No es posible, te has pasado de la fecha de devolución",
                        showConfirmButton: false,
                        timer: 2000
                            });
                </script>';                       
        } 
    
    }else{
        //Mensaje error por no selecionar ningun checkbox
        echo '<script>
            Swal.fire({
                icon: "warning",
                title: "No se han seleccionado ningún producto",
                showConfirmButton: false,
                timer: 2000
                });
            </script>';
    }
}

    ?>

    <!--------------------------                           HTML                            --------------------------------->
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/misPedidos.css">
        <title>Mis pedidos</title>
    </head>

    <body>
        <!--------------------         CUERPO PRINCIPAL         ----------------------->
        <main>
            <!------     Pedidos realizados      ------>
            <h1>Mis pedidos</h1>

<?php
    //Consulta BD - de los pedido realizados y sus datos
    $ins = $bd->query( "SELECT DISTINCT p.IdPedido, p.Fecha, p.PrecioTotal
                                    FROM pedido p
                                    JOIN Usuario u ON p.Usuario = u.IdUsuario
                                    JOIN pedidolibro pl ON p.IdPedido = pl.Pedido
                                    JOIN libro l ON pl.Libro = l.IdLibro
                                    WHERE u.IdUsuario = '$idUsu';");
    $misPedidos = $ins->fetchAll(PDO::FETCH_ASSOC);

    //Si hay pedidos se ejecutara
    if(!empty($misPedidos)){ 
        // Obtener los pedidos en orden inverso
        $misPedidosInversos = array_reverse($misPedidos);

        ////Imprimimos los valores de cada pedido
        foreach ($misPedidosInversos as $pedido) {
            $idPedido = $pedido['IdPedido']; 
            $fechaPedido = $pedido['Fecha'];
            $fechaPedidoInvertida = date("d-m-Y", strtotime($fechaPedido));
            $precioTotal = $pedido['PrecioTotal']; 
            

            echo '<div class="pedidos">
            <div class="primera_barra">
                <ul>
                    <li>Id del pedido: <b>' . $idPedido . '</b></li>
                    <li>Fecha de realización: <b>' . $fechaPedidoInvertida . '</b></li>
                    <li>Coste: <b>' . $precioTotal . ' €</b></li>';
            
            // Botón de mas informacion del pedido
            echo '<li><button type="button" class="botonInfo' . $idPedido . ' btninform" onclick="mostrarInfo(' . $idPedido . ')">+Info</button></li>
            </ul>
            </div>';
            
            // Div de la información de los libros del pedido
            echo '<div class="infoPed' . $idPedido . ' informacion" style="display: none;">
            <form action="' . htmlspecialchars($_SERVER["PHP_SELF"]) . '" method="POST">';
            
            //Consulta BD - para la informacion de los libros y su cantidad pedido
            $productos = $bd->query( "SELECT l.IdLibro, l.Imagen, l.Nombre, l.Formato, pl.Unidades
                                        FROM libro l
                                        JOIN pedidolibro pl ON l.IdLibro = pl.Libro
                                        JOIN pedido p ON p.IdPedido = pl.Pedido
                                        JOIN usuario u ON p.Usuario = u.IdUsuario
                                        WHERE u.IdUsuario = '$idUsu' 
                                        AND p.IdPedido = '$idPedido';");

            //Impresion de la informacion
            foreach ($productos as $producto) {
                echo '<div >
                <input type="checkbox" name="idLibro[]" value="' . $producto['IdLibro'] . '" class="idLibro">
                <a href="libro.php?id=' . $producto['IdLibro'] . '">
                <img src="' . $producto['Imagen'] . '">
                    <ul>
                        <li>' . $producto['Nombre'] . '</li>
                        <li>' . $producto['Formato'] . '</li>
                        <li>Cantidad: ' . $producto['Unidades'] . '</li>
                    </ul>
                </a>
                <p class="pCantidad" ><input type="number" class="cantidadDev" name="cantidadDev[]" value="1" min="1" max="'.$producto['Unidades'].'"></p></div>';           
            }
 
            //Boton para devolver 
            echo '<button type="submit" name="id_devolucion_pedido" value="' . $idPedido . '" class="btn_devolver">Devolver</button>';
           
            //Comprobacion de si existe el idPedido con uno de la cookie 
            $devolucionExistente = false;
            foreach ($devolucionesActuales as $devolucion) {
                if ($devolucion['idPedido'] == $idPedido) {
                    $devolucionExistente = true;
                    break;
                }
            }

            //Si se cumple el if anterior seimprime este enlace que al pulsar te redirige a tu pedido devuelto
            if ($devolucionExistente) {
                 echo '<a href="#' . $idPedido . '"><p class="infoInteres">En proceso de reembolso</p></a>';
            }
            echo '</form>';
            echo '</div>';
            echo '</div>';
            }
    }else{
        //Si no hay pedidos saldra el siguiente mensaje
    echo '<h3 class="advertencia">No se han realizado pedidos </h3>';
} 
            ?>


<!--------     Pedidos devueltos    -------->
<h3>Pedidos devueltos</h3>
<?php
//Variables
$pedidosImpresos = array(); 
$devolucionesActuales = array_reverse($devolucionesActuales);

//Impresion de la cookie de lospedidos devueltos
foreach ($devolucionesActuales as $devolucion) {
    $pedDevuelto = $devolucion['idPedido'];

    /* Verificar si el pedido ya ha sido impreso, ya que
     sino se imprimiria tantas veces como libros devueltos hubiera*/
    if (!in_array($pedDevuelto, $pedidosImpresos)) {
        //Consulta BD - para selecionar los idpedido de la tabla
        $stmt = $bd->prepare("SELECT DISTINCT p.IdPedido 
                                    FROM pedido p
                                    JOIN Usuario u ON p.Usuario = u.IdUsuario
                                    JOIN pedidolibro pl ON p.IdPedido = pl.Pedido
                                    WHERE u.IdUsuario = :idUsu AND p.IdPedido = :pedDevuelto");
        $stmt->bindParam(':idUsu', $idUsu);
        $stmt->bindParam(':pedDevuelto', $pedDevuelto);
        $stmt->execute();
        $misPedidosDev = $stmt->fetchAll(PDO::FETCH_ASSOC);

        //Impresion de cada pedido
        foreach ($misPedidosDev as $pedido) {
            
            // Imprime los datos solo si no ha sido impreso previamente
            if (!in_array($pedido['IdPedido'], $pedidosImpresos)) {
                echo '<div class="pedidos devueltos" id="'.$pedido['IdPedido'].'">';
                echo '<div class="primera_barra">';
                echo '<ul>';
                echo '<li>Id del pedido: <b>' . $pedido['IdPedido'] . '</b></li>';
                echo '</ul>';
                echo '</div>';
                echo '<div class="infoPedDev' . $idPedido . ' informacion devInfi">';
                
                echo '<div>';

                // En este array se registran los libros ya impresos en este pedido
                $librosImpresosPedido = array();

                //Obtencion de los id de los libros devueltos de ese pedido
                foreach ($devolucionesActuales as $dev) {
                    $idLibrodev= $dev['idLibro'];

                    // Verificar si el libro ya ha sido impreso
                    if (!in_array($idLibrodev, $librosImpresosPedido) && $dev['idPedido'] == $pedido['IdPedido']) {
                        $productos = $bd->prepare("SELECT l.IdLibro, l.Imagen, l.Nombre, l.Formato
                                                        FROM libro l
                                                        JOIN pedidolibro pl ON l.IdLibro = pl.Libro
                                                        WHERE pl.Libro = :idLibroDev AND pl.Pedido = :idPedido");

                        // Vincula los parámetros
                        $productos->bindParam(':idLibroDev', $idLibrodev);
                        $productos->bindParam(':idPedido', $pedido['IdPedido']);
                        $productos->execute();

                        //Datos del libro
                        foreach ($productos as $producto) {
                            echo '
                            <a href="libro.php?id=' . $producto['IdLibro'] . '" class="listaDev">
                                <img src="' . $producto['Imagen'] . '">
                                <ul>
                                    <li>' . $producto['Nombre'] . '</li>
                                    <li>' . $producto['Formato'] . '</li>
                                </ul>
                            </a> '; 

                            // Agrega el id del libro al array de los libros impresos de este pedido
                            $librosImpresosPedido[] = $idLibrodev;
                        }
                    }
                }
                echo '</div>';

                //Obtencion de las cantidades de los libros devueltos de ese pedido
                echo '<div>';
                foreach ($devolucionesActuales as $dev) {
                    $pedDevuelto = $dev['cantidadDev'];
                        //Verifica si el id de la cookie y del pedido actual son el mismo y imprime las cantidades devueltas
                        if ($dev['idPedido'] == $pedido['IdPedido']) {
                            echo '<p class="cantDev">Cantidad devuelta: ' . $dev['cantidadDev'] . '</p>';
                        }
                }
                echo '</div>';

                echo '</div>';
                    

                echo '</div>'; 
                echo '</div>';

                // Registra el pedido como impreso para no volver a imprimirse
                $pedidosImpresos[] = $pedido['IdPedido'];
            }
        }
    }
}

if (empty($pedidosImpresos)) {
    //Mensaje en el caso de no haberse realizado ningun reembolso
    echo '<h3 class="advertencia">No se han realizado reembolsos </h3>';
}
?>

<!--------    Politicas de devolucion      -------->
<div class="politicaDev">
    <h3>Política de devolución</h3>
    <p>Aceptamos devoluciones dentro de los siguientes <b>40 días</b> a la fecha de compra de 
        los productos en <b>buenas condiciones</b></p>
</div>
        </main>
    </body>

    </html>

    <!--------------------------                           JAVASCRIPT                            --------------------------------->
    <script>
    
    //VISUALIZACION INFO PEDIDO
    function mostrarInfo(idPedido) {
        var infoDiv = document.querySelector(".infoPed" + idPedido);
        var btnInfo = document.querySelector(".botonInfo" + idPedido);
        if (infoDiv.style.display === "none") {
            infoDiv.style.display = "block";
            btnInfo.style.backgroundColor = "#c0c0c2";
            btnInfo.style.color = "black";
        } else {
            infoDiv.style.display = "none";
            btnInfo.style.backgroundColor = "#48474d";
            btnInfo.style.color = "#f0ebeb";
        }
    }
    
</script>
   
