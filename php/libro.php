    <!--------------------------                           PHP                            --------------------------------->
    <?php
        require('general.php');

        //Conexión a la BBDD
        $cadena_conexion = "mysql:dbname=libreria;host=127.0.0.1";
        $usuario = "root";
        $bd = new PDO($cadena_conexion, $usuario);
        $bd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_SILENT);

        // Variables de alertas
        $alertaListaDeseos ="";
    
    //comprobacion de que GET existe en la BBDD o el id esta vacio vaya a genero.php
    $id = isset($_GET['id']) ? $_GET['id'] : null;
    
    $resul = $bd->query("SELECT IdLibro
                            FROM libro
                            WHERE IdLibro = $id");
     
    if ($id == null || $resul->rowCount() === 0) {
        header("location: genero.php?redirigido=true");
     }

    //Consulta BD - para imprimir el stock que hay de cada libro, en caso de no haber stock imprimirá un mensaje
    $resul = $bd->query("SELECT Stock
                            FROM libro
                            WHERE IdLibro = $id");
    $resul = $resul->fetch();
    
    if($resul['Stock'] <= 0){
        $stock = "<p class='noStock'><b>No hay stock</b></p>";
    }else{
        $stock = $resul['Stock'] . " stock";
    }

  

 ?>

    <!--------------------------                           HTML                            --------------------------------->
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/libro.css">
        <title>Libro</title>
        
    </head>

    <body>
        <!--------------------         CUERPO PRINCIPAL         ----------------------->
        <main>
            <article>
                <?php     
                //Hacemos una consulta para recoger todos los datos de un libro
                $libro = $bd->query("SELECT l.*, a.Nombre AS NombreAutor, a.Apellidos AS ApellidosAutor, g.Nombre AS NombreGenero
                    FROM libro l
                    JOIN autor a ON l.Autor = a.IdAutor
                    JOIN genero g ON l.Genero = g.IdGenero
                    WHERE l.IdLibro = '$id';
               ");

               //Imprimimos los datos del libro
                foreach ($libro as $lib) {
                    echo '
                        <ul class="libro-info">
                            <li>
                                <div class="img-libro">
                                    <img src="' . $lib['Imagen'] . '">
                                </div>
                            </li>
                            <li>
                                <div class="article">
                                    <p class="titulo-libro">' . $lib['Nombre'] . '</p>
                                    <p>' . $lib['ApellidosAutor'] . ', ' . $lib['NombreAutor'] . '</p>
                                    <p>ISBN: ' . $lib['ISBN'] . '</p>
                                    <p>Formato ' . $lib['Formato'] . '</p>
                                    <p>Tipo: ' . $lib['Tipo'] . '</p>
                                    <p class="precio">' . $lib['Precio'] . '€</p>
                                </div>
                            </li>
                        </ul>';
                }
                ?>
            </article>

            <aside>
                <!-----     Formulario de la cookie Carrito    ------->
                <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]) . "?id=$id"; ?>" method="POST">
                    <div class="caja-aside">
                    <p class = "stock"><b><?php echo $stock; ?></b></p>
                    <p>Cantidad: <input type="number" class="caja-cantidad" name="cantidad" id="cantidad" value="1" min="1"></p>
                    <p><input type="hidden" name="idCarrito" value="<?php echo $id ?>" id="idCarrito"></p>
                    <p><button type="submit" name="añadir_a_la_cesta" class="bi bi-cart-plus carro">Añadir a la cesta</button></p>
                    </div>
                </form>

                <!-----     Formulario de la cookie Lista    ------->
                <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]) . "?id=$id"; ?>" method="POST">
                    <input type="hidden" name="idLista" value="<?php echo $id ?>" id="idLista">
                
                <?php 
                    $estadoSesionUsu = isset($_SESSION['usuario']) && !empty($_SESSION['usuario']);
                    $nombreCookieLista = "";
                    if ($estadoSesionUsu && isset($_SESSION['usuario']['IdUsuario'])) {
                        //Añadimos el id del usuario al nombre para que la cookie sea unica para cada usuario
                        $nombreCookieLista = "listaDeseos_"  . $_SESSION['usuario']['IdUsuario'];     
                    }
                    else {
                          /* Si no está definida la sesión de usuario se establece esta como valor predeterminado 
                          para evitar el error de falta de declaracion del nombre de la cookie*/
                        $nombreCookieLista = "listaDeseos_predeterminada";
                    }

                    //Comprobamos el estado de la cookie lista
                    $listaActual = isset($_COOKIE[$nombreCookieLista]) ? unserialize($_COOKIE[$nombreCookieLista]) : array();
                       

                    //////////              POST AÑADIR A LISTA              //////////
                    if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["idLista"])) {
                        
                        //Comprueba la existencia de una session de usuario
                        if ($estadoSesionUsu) {
                              
                            //Si existe el id del libro en la cookie la elimina
                            if (in_array($id, $listaActual)) {
                                // Eliminar el valor
                                $listaActual = array_diff($listaActual, array($id));
                   
                            } else {
                                // Verificar si hay cookie 
                                if (!isset($_COOKIE[$nombreCookieLista])) {
                                    // Creamos la cookie
                                    setcookie($nombreCookieLista, serialize($listaActual), time() + (86400 * 365 * 10));
                                }
     
                                // Añade el libro a la lista
                                $listaActual[] = $id;
                            }
                            // Actualizar la cookie ya existente
                            setcookie($nombreCookieLista, serialize($listaActual), time() + (86400 * 365 * 10));
                                  
                        } else {
                            $alertaListaDeseos = "<p class='alerta-sesion'><i class='bi bi-x-square-fill'></i> <a href='login.php'><b><u>Inicia sesión </u></b></a>
                            </b>para añadirlo a la lista</a></p>";
                        } 
                    }
                
                    // Comprobamos que se cumple que hay sesion de usuario y esta añadido el id del libro a la cookie
                    $clase_del_btn = ($estadoSesionUsu && in_array($id, $listaActual)) ? "bi bi-heart-fill" : "bi bi-heart";
                ?>

    
    <button type="submit" id="corazon" name="añadir_a_la_lista" class="<?php echo $clase_del_btn; ?>"></button>
                    
    <?php echo  $alertaListaDeseos;?> 
                
</form>
                
        <?php
            //////////             POST AÑADIR A CARRITO          //////////
        if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["idCarrito"])) {

            //Comprobacion si hay una sesion del usuario
            if (isset($_SESSION['usuario']) && !empty($_SESSION['usuario'])) {

                //Se cumple si hay stock
                if($resul['Stock'] > 0){

                //Añade el id del usuario al nombre para que la cookie sea unica para cada usuario
                $nombreCookieCarrito = "carrito_" . $_SESSION['usuario']['IdUsuario'];
        
                // Obtiene el valor actual de la cookie
                $carritoActual = isset($_COOKIE[$nombreCookieCarrito]) ? unserialize($_COOKIE[$nombreCookieCarrito]) : array();
        
                // Obtiene la cantidad sino hay su valor sera '1' y el id del libro
                $cantidad = isset($_POST["cantidad"]) ? intval($_POST["cantidad"]) : 1;
                $id = $_POST["idCarrito"];
        
                    // Verificar si el id del libro ya está en el carrito
                    if (array_key_exists($id, $carritoActual) && is_array($carritoActual[$id])) {
                        // Aumenta la cantidad
                        $carritoActual[$id]['cantidad'] += $cantidad;
                    } else {
                        // Añadimos el nuevo libro a la cookie
                        $carritoActual[$id] = array(
                            'id' => $id,
                            'cantidad' => $cantidad
                        );
                    }
                echo "<p>Se ha añadido a la cesta</p>";

                // Actualizamos la cookie
                setcookie($nombreCookieCarrito, serialize($carritoActual), time() + (86400 * 365 * 10));
                }else{
                    echo "<p class='alerta-sesion'><i class='bi bi-x-square-fill'></i>Esta agotado, no puede añadirlo </p>";
                }
            } else {
               echo "<p class='alerta-sesion'><i class='bi bi-x-square-fill'></i> <a href='login.php'><b><u>Inicia sesión </u></b></a> para añadir al carrito</p>";
            }
        }
?>
            </aside>
            
            <!--     Caracteristicas del libro      -->
            <section>
                <h2 class="h2-caracteristicas">Características</h2>
                <ul>
                    <?php
                    //Consulta BD - para obtener los datos del libro
                    $caracteristicas = $bd->query("SELECT * 
                                FROM libro 
                                WHERE IdLibro = '$id'");
                    foreach ($caracteristicas as $caract) {
                        echo 
                            "<li class='descripcion'><b>Descripción:</b> <br>" . $caract['Descripcion'] . "</li>
                            <li><b>Edición:</b> " . $caract['Edicion'] . "</li>
                            ";
                        //Si existe una saga se imprime
                        if ($caract['Saga'] !== null || $caract['Num_Saga'] !== null) {
                            echo 
                                "<li><b> Saga:</b> " . $caract['Saga'] . "</li>
                                <li><b>Número de la saga:</b> " . $caract['Num_Saga'] . "</li>
                                ";
                        }
                    }
                    ?>
                </ul>
            </section>
        </main>
    </body>

    </html>

  
  
