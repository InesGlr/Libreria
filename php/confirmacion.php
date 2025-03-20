    <!--------------------------                           PHP                            --------------------------------->
    <?php
    require('general.php');

    //Conexión a la BBDD
    $cadena_conexion = "mysql:dbname=libreria;host=127.0.0.1";
    $usuario = "root";
    $bd = new PDO($cadena_conexion, $usuario);
    $bd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_SILENT);

    //datos del usuario
    $idusuario = $_SESSION["usuario"]["IdUsuario"];
    $consulta_usuario = $bd->prepare("SELECT * FROM usuario WHERE IdUsuario = ?");
    $consulta_usuario->execute([$idusuario]);
    $resulUd = $consulta_usuario->fetch(PDO::FETCH_ASSOC);


/////////////////////////////                         CORREO                            ////////////////////////////////
    use PHPMailer\PHPMailer\PHPMailer;
    require "C:/xampp/htdocs/Tema 3/vendor/autoload.php";   //Cambiar la ruta en caso de error
    
    //Funcion del correo
    function enviarCorreo($receptor, $asunto, $contenido_correo){
        $mail = new PHPMailer();
        $mail->IsSMTP();
        $mail->SMTPDebug = 0;
        $mail->SMTPAuth = true;
        $mail->SMTPSecure = "tls";
        $mail->Host = "smtp.gmail.com";
        $mail->Port = 587;

        //Emisor
        $mail->Username = "desplieguea@gmail.com";
        $mail->Password = "dads inqo jzfo wnnp";
        $mail->setFrom("desplieguea@gmail.com", $asunto);

        //Contenido y receptor
        $mail->Subject = $asunto;
        $mail->MsgHTML($contenido_correo);
        $mail->addAddress($receptor);
        $result = $mail->send();
        
        if (!$result) {
            echo "Error" . $mail->ErrorInfo . "";
        } 
    };
?>

    <!--------------------------                           HTML                            --------------------------------->
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Confirmación pedido</title>
        <link rel="stylesheet" href="../css/confirmacion.css">
    </head>

    <body>
        <!--------------------         CUERPO PRINCIPAL         ----------------------->
        <main>
        <p class='estilo-parrafo'><b>Resumen del pedido: </b> </p>
       
    <?php

    //GET proveniente de carrito.php
    if ($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET["comprar"])) {
        $precioFinal = $_GET["precioFinal"];
    } 
    
    //Cumplimiento de que hay una 'session usuario' y no esta vacia
    if (isset($_SESSION['usuario']) && !empty($_SESSION['usuario'])) {
        $precioFinal = 0;


        ////////////                 VALORES COOKIE CARRITO                  ////////////////////

    //Nombre de la cookie 
        $nombreCookieCarrito = "carrito_" . $_SESSION['usuario']['IdUsuario'];
    // Obtener el valor actual del carrito desde la cookie
        $carritoActual = isset($_COOKIE[$nombreCookieCarrito]) ? unserialize($_COOKIE[$nombreCookieCarrito]) : array();
    
    //Comprobacion de que la cookie esta vacia
        if (empty($carritoActual)) {
            echo "<p>El carrito estaba vacío</p>";
        }else {
            //Impresion empezando desde el ultimo libro añadido
            $carritoInvertido = array_reverse($carritoActual);
            
            //Establecemos cada libro
            foreach ($carritoInvertido as $producto) {
                if (isset($producto['id']) && isset($producto['cantidad'])) {
                    $idLibro = $producto['id'];
                    $cantidad = $producto['cantidad'];
            
                    //consulta BD - Datos del libro
                    $resul = $bd->query("
                        SELECT *
                        FROM libro l
                        WHERE IdLibro = '$idLibro'");
                    
                    //Impresion de los datos del libro en cuestion
                    foreach($resul as $dato){
                        echo '<div class="caja-img">';
                            echo '<img src= "'.$dato['Imagen'].'">';
                        echo '</div>'; 
                        echo '<div class="info">';  
                            echo "<li><b>{$dato['Nombre']}</b></li>";
                            echo "<li>{$dato['Precio']}€</li>";
                            echo "<li >{$dato['Formato']}</li>";
                            echo "<li>{$dato['Tipo']}</li></a>";
            
                        //calculo total unidades x libro:
                        $precioUdLibro = $cantidad * $dato['Precio'];
                            echo "<li>Cantidad: {$cantidad}</li>";
                            echo "<li class='precio formato'>Total: {$precioUdLibro}€</li>";
                        echo '</div>'; 

                        // añadido al precio final
                        $precioFinal += $precioUdLibro;
                    }                    
                }else{
                    echo "error con los id y cant <br>";
                }
            }
                        
                            
            /////////      Comprobacion de la existencia de una 'direccion' enlazada al usuario     ////////
                        
            $idusuario = $_SESSION["usuario"]["IdUsuario"];

            //Consulta BD - datos de una direccion que este relacionado con el usuario 
            $resulDird = $bd->query("SELECT d.* 
                FROM direccion d, usuario u 
                WHERE d.IdDireccion = u.Direccion AND u.IdUsuario = '$idusuario'");
            $resulDir = $resulDird->fetch();

            //Impresion de la direccion o del mensaje de error
            if ($resulDird && $resulDird->rowCount() === 0) {
                echo '<ul class="lista-direccion">
                        <p class="estilo-parrafo"><b>Dirección de envío:</b></p>
                        <li><h3 class="advertencia">No hay una dirección principal</h3></li>
                    </ul>';
            }else{                                                    
                echo '<ul class="lista-direccion">
                        <p class="estilo-parrafo"><b>Dirección de envío:</b></p>
                        <li>' . "Remitente " . $resulDir["NombreRemitente"] . " " . $resulDir["ApellidosRemitente"] . '</li>
                        <li>' . "Calle " . $resulDir["Calle"] . ", nº " . $resulDir["Numero"] . '</li>';
                
                //Si existe un valor 'Piso' lo imprime
                if ($resulDir['Piso'] !== '') {
                    echo '<li>' . "piso " . $resulDir["Piso"] . '</li>';
                    }
                    echo '<li>' . $resulDir["Provincia"] . ", " . $resulDir["Ciudad"] . " " . $resulDir["CP"] . '</li> 
                        <li>' . $resulDir["Pais"] . '</li>
                    </ul>';
            }
            
            //Consulta BD - datos del correo que este relacionado con el usuario 
            $idCorreo = isset($_SESSION["usuario"]["Correo"]) ? $_SESSION["usuario"]["Correo"] : null ;
            $resulCorr = $bd->query("SELECT Correo
                FROM usuario
                WHERE IdUsuario = $idusuario");
            $resulCor = $resulCorr->fetch();

            //Impresion del correo o del mensaje de error
            if (isset($resulCor["Correo"]) && $resulCor["Correo"] == "") {   
                echo '<ul class="lista-correo">';
                echo '<p class="estilo-parrafo"><b>Correo electrónico:</b></p>';
                echo '<li><h3 class="advertencia">No hay correo</h3></li>';
                echo '</ul>';
                } else{                                                    
                    echo '<ul class="lista-correo">';
                    echo '<p class="estilo-parrafo"><b>Correo electrónico:</b></p>';
                    echo '<li>' . "<i><strong> " . $resulCor["Correo"] . '</strong></i></li>';
                    echo '</ul>';
                }
        }
    } 
?>

<!------------            Formulario con boton para confirmar la compra              ---------------->
<form action="<?php htmlspecialchars($_SERVER["PHP_SELF"]) ?>" method="POST">
    
<?php
    //Redirigido si '$precioFinal' no es mayor que 0, ya que no hay libros ni motivo de hacer un pedido
    if($precioFinal>0){
        echo '<div class = "prueba">
        <h2 class="estilo-parrafo"><b>Total: ' . $precioFinal . ' €</b></h2>
            <input type="hidden" name="precioFinal" value="' . $precioFinal . '">
            <input type="submit" class="boton-comprar" name="confirmarPedido" value="Confirmar pedido">
            </div>';       
    }else {
        header("Location: carrito.php?redirigido=true");
    }
    ?>
                
            </form>
        </main>
    </body>
</html>
<?php

////////////////////////////////                   POST CONFIRMACION PEDIDO                              //////////////////////////////////

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["confirmarPedido"]) && isset($_POST["precioFinal"]) ) {
    //Datos para la tabla 'pedido' .- parte 1/2
    $fecha = date("Y-m-d");
    $usuario = $_SESSION['usuario']['IdUsuario'];
    $precioFinal = floatval($_POST["precioFinal"]);

    //Comprobacion de si el saldo es = ó mayor que el precio, que hay una direccion y un correo enlazada con el usuario
   if ($resulUd['Saldo'] >= $precioFinal && !empty($resulUd['Direccion']) && !empty($resulUd['Correo'])) { 
    

    //////////           INICIO DE LA TRANSACCIÓN              ///////////    
    $bd-> beginTransaction();
    
        //Inserción de los datos en la tabla 'pedido'  .- parte 2/2
        $sql = "INSERT INTO pedido (Fecha, Usuario, PrecioTotal) VALUES (:fecha, :usuario, :precioFinal)";
        $resultInsert = $bd->prepare($sql);

        //Si se ejecuta bien la inserción seleciona el 'id' del pedido
        if ($resultInsert->execute(array(':fecha' => $fecha, ':usuario' => $usuario, ':precioFinal' => $precioFinal))) {
            $idPedido = $bd->lastInsertId();
        } else {
            print_r($resultInsert->errorInfo());
            $err = TRUE;
        }

        // Actualización del 'saldo' de la tabla usuario
        $upt= "UPDATE usuario SET Saldo = Saldo - :precioFinal WHERE IdUsuario = :usuario";
        $resultUpdate = $bd->prepare($upt);

        //Si NO se ejecuta bien se dara $err= true y se cancela la transaccion
        if($resultUpdate->execute(array(':usuario' => $usuario,':precioFinal'=> $precioFinal))){
            echo "saldo actualizado";
        }else{
            print_r($resultUpdate->errorInfo());
            $err = TRUE;
        }

        //Inserción de los datos de los id de los libros y cantidades a la tabla 'pedidolibro'
        foreach ($carritoInvertido as $producto) {
            if (isset($producto['id']) && isset($producto['cantidad'])) {
                $idLibro = $producto['id'];
                $cantidad = $producto['cantidad']; 
            }
                $sql = "INSERT INTO pedidolibro (Pedido, Libro, Unidades) VALUES (:idPedido, :idLibro, :cantidad)";
                $resultInsert = $bd->prepare($sql);
        
                //Si NO se ejecuta bien se dara $err= true y se cancela la transaccion
            if ($resultInsert->execute(array(':idPedido' => $idPedido, ':idLibro' => $idLibro, ':cantidad' => $cantidad))) {
                echo " insertado tabla pedidolibro";
            } else {
                print_r($resultInsert->errorInfo());
                $err = TRUE;
            }

            //Actualización del 'stock' de la tabla libro
            $upt= "UPDATE libro SET Stock = Stock - :cantidad WHERE IdLibro = :id";
            $resultUpdate = $bd->prepare($upt);

            //Si NO se ejecuta bien se dara $err= true y se cancela la transaccion
            if($resultUpdate->execute(array(':id' => $idLibro,':cantidad'=> $cantidad))){
                echo "stock actualizado";
            }else{
                print_r($resultUpdate->errorInfo());
                $err = TRUE;
            } 
        } 

           

            
    //////////////////                         DATOS DEL CORREO                        ///////////////////////
    
        //Consulta BD - Id del pedido
        $insPed = $bd->query("SELECT *
            FROM Pedido
            WHERE IdPedido = '$idPedido'");
        $resulPedido = $insPed->fetch();
    
        //Receptor del correo
       $receptor  = $resulUd['Correo'];
              
        //Asunto del correo
        $asunto= "Gracias por comprar con Literary League!!!";

        //Contenido del correo
       $contenido_correo = '<h2>Hola '.$resulUd['Nombre'].' </h2><br>';
       $contenido_correo .= '<h2>Tu pedido #'.$resulPedido['IdPedido'].' </h2><br>';
   
       $nombreCookieCarrito = "carrito_" . $_SESSION['usuario']['IdUsuario'];
       $carritoActual = isset($_COOKIE[$nombreCookieCarrito]) ? unserialize($_COOKIE[$nombreCookieCarrito]) : array();
   

        ////////////          Comprobacion del formato de los libro          /////////////

        //Arrays donde clasificar los libros
        $libroFisico = [];
        $libroDigital = [];
        
        foreach ($carritoActual as $producto) {
            $idLibro = $producto['id'];
            $cantidad = $producto['cantidad'];
            
            //consultas BD - si el libro es de 'formato': fisico o bolsillo
            $resul = $bd->query("SELECT IdLibro
                    FROM libro 
                    WHERE (Formato = 'Fisico' OR Formato = 'Bolsillo') AND IdLibro = '$idLibro';");

            //Si hay un resultado lo inserta en el array de '$librosFisicos'
            if($resul->rowCount() === 1){
                array_push($libroFisico, $producto);
            }

            //consultas BD - si el libro es de 'formato': fisico o bolsillo
            $resul2 = $bd->query("SELECT IdLibro
                    FROM libro 
                    WHERE Formato = 'Digital' AND IdLibro = '$idLibro';");

            //Si hay un resultado lo inserta en el array de '$librosDigitales'
            if($resul2->rowCount() === 1){
                array_push($libroDigital, $producto);
            }  
        }
        
        //Si hay valores en el array '$libroFisico' se cumplira el if e imprimira el siguiente contenido
        if(!empty($libroFisico) ){
            $fechaInvertida = date("d-m-Y", strtotime($fecha));

            $contenido_correo .= '<h2>Te llegara tu compra en un plazo de 12 a 14 días desde hoy a ' . $fechaInvertida . '</h2>
                                    <h3>El numero de seguimiento es '.$numeroAleatorio.' de la empresa <a href="https://www.google.es">CorreoR</a></h3>
                                    <h3>Los siguientes libros:  </h3><br><ul>';
            
            foreach($libroFisico as $libro){
                $idLibro = $libro['id'];
                $ins = $bd->query("SELECT *
                    FROM libro
                    WHERE IdLibro = '$idLibro'");
                $dato = $ins->fetch();
        
                $contenido_correo .= "<li>
                                    <ul><b>{$dato['Nombre']}</b>
                                    <li>{$dato['Tipo']}</li>
                                    <li>Cantidad: " . $libro['cantidad'] . "</li></ul></li>
                                    </ul>";
            }   
        }  

        //Si hay valores en el array '$libroDigital' se cumplira el if e imprimira el siguiente contenido
        if (!empty($libroDigital)){
            $contenido_correo .= '<h2>Eston son los códigos para cada libro  </h2>
                                <h3>Los siguientes libros:  </h3><br><ul>';
            
            foreach($libroDigital as $libro){
                $idLibro = $libro['id'];
                $ins = $bd->query("SELECT *
                            FROM libro
                            WHERE IdLibro = '$idLibro'");
                $dato = $ins->fetch();
        
                $contenido_correo .= "<li><ul><b>{$dato['Nombre']}</b>
                                    <li>{$dato['Tipo']}</li>
                                    <li>Cantidad: " . $libro['cantidad'] . "</li></ul></li>
                                    <ul>";
                
                for ($i = 1; $i <= $libro['cantidad']; $i++) {
                    $numeroAleatorio = random_int(1, 1000000);
                    $contenido_correo .= "<li>Código " .$i.": <b>". $numeroAleatorio . "</b></li>";
                }
                $contenido_correo .= "</ul><br>";
            }   
            $contenido_correo .= '<h3>Ve a <a href="https://www.google.es">pontucodigo</a>
                    para obtener tu libro a traves del código</h3></ul>';
        }

    //Inserción del contenido del correo en la función
    enviarCorreo($receptor, $asunto, $contenido_correo);

    //Elminamos la cookie carrito
    setcookie($nombreCookieCarrito, serialize($carritoActual), time() - (86400 * 365 * 10)); 

    //Si NO ha habido errores se cumple la transaccion, de lo contrario se cancela
        if(isset($err)){
            $bd->rollback();
        }else{
            $bd->commit();
            header("Location: misPedidos.php"); 
        }
            
            
            
    }else{
        //Mensaje de error a falta de saldo para la compra
        if($resulUd['Saldo'] < $_POST["precioFinal"]){
            echo '<script>
                    Swal.fire({
                        icon: "warning",
                        title: "Saldo insuficiente para realizar la acción",
                        showConfirmButton: false,
                        timer: 3000
                    });
                </script>';
        }

         //Mensaje de error a falta de direccion enlazada a usuario
        if(empty($resulUd['Direccion'])) {
            echo '<script>
                Swal.fire({
                    icon: "warning",
                    title: "No hay una dirrecion adjunta, debes añadir una",
                    showConfirmButton: false,
                    timer: 3000
                });
                </script>';
        }  
       
       //Mensaje de error a falta del correo enlazado a usuario
        if(empty($resulUd['Correo'])) {
            echo '<script>
                Swal.fire({
                    icon: "warning",
                    title: "No hay un Correo, debes añadir uno",
                    showConfirmButton: false,
                    timer: 3000
                });
                </script>';
        } 
    } 
} 

?>
