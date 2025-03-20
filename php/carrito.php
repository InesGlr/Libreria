    <!--------------------------                           PHP                            --------------------------------->
    <?php
    /* Con este fichero comprobamos si tenemos una sesion iniciada, si no es asi, saltara un alerta ya que
    para poder ver el carrito, tenemos que tener iniciada la sesion.
    Creamos una cookie para controlar el carrito de cada usuario registrado.
    Podemos eliminar libros del carrito.
    Podemos modificar la cantidad de libros que queremos comrpar.
    Haciendo clic sobre los libros, accedemos a la informacion / caracteristicas.
    Si pulsamos el boton comprar, nos redirige al php 'confirmacion.php'
     */

    /* Incluimos el contenido del fichero 'general.php' */
    require('general.php');

    /* Conexión con la base de datos */
    $cadena_conexion = "mysql:dbname=libreria;host=127.0.0.1";
    $usuario = "root";
    $precioTotal_boton="";
    ?>

    <!--------------------------                           HTML                            --------------------------------->
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/carrito.css">
        <title>Carrito</title>
        
    </head>

    <body>
        <!--------------------         CUERPO PRINCIPAL         ----------------------->
        <main>
            <div>
    <?php    
        /* Comprobamos si la sesión está inicializada y si no está vacía */
        if (isset($_SESSION['usuario']) && !empty($_SESSION['usuario'])) {
            /* Almacenamos en la variable el nombre de la cookie, que será carrito_ seguido del valor del IdUsuario*/
            $nombreCookieCarrito = "carrito_" . $_SESSION['usuario']['IdUsuario'];
            $precioFinal = 0;

            /* Comprobamos si esta inicializara la cookie , la convertimos en un array y la almacenamos en la variable $carritoActual. */
            $carritoActual = isset($_COOKIE[$nombreCookieCarrito]) ? unserialize($_COOKIE[$nombreCookieCarrito]) : array();

            /* Si está vacia la variable '$carritoActual', saltará un mensaje de que el carrito esta vacío */
            if (empty($carritoActual)) {
                echo '<h3 class="advertencia">El carrito está vacío</h3>';
            } 
            
            else {
                /* Modificamos la cantidad del producto  */
                if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["cantidad"])) {
                    $cantidad = isset($_POST["cantidad"]) ? intval($_POST["cantidad"]) : 1;
                    $idLibroModificado = $_POST["identificador_libro"];

                    $carritoActual[$idLibroModificado]['cantidad'] = $cantidad;
                    setcookie($nombreCookieCarrito, serialize($carritoActual), time() + (86400 * 365 * 10));
                    
                }
                /* Podemos eliminar un libro del carrito  */
                if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["borrar_libro_del_carrito"])) {
                    $idLibroEliminar = $_POST["identificador_libro"];

                    unset($carritoActual[$idLibroEliminar]);/* Destruye del carrito el libro */
                    setcookie($nombreCookieCarrito, serialize($carritoActual), time() + (86400 * 365 * 10));

                    if (empty($carritoActual)) {
                        echo '<h3 class="advertencia">El carrito está vacío</h3>';

                    }  
                }
                /* Mostramos los libros del carrito de forma invertida, es decir, se añade al inicio el último
                libro añadido */
                $carritoInvertido = array_reverse($carritoActual);
                
                foreach ($carritoInvertido as $producto) {
                    if (isset($producto['id']) && isset($producto['cantidad'])) {
                    $idLibro = $producto['id'];
                    $cantidad = $producto['cantidad'];

                    $resul = $bd->query("SELECT * FROM libro l WHERE IdLibro = '$idLibro'");
                    echo "<ul class'ul-carrito'>";
                        foreach($resul as $dato){
                            echo '<li><a href="libro.php?id=' . $dato['IdLibro'] . '">';
                            echo '<li><img src= "'.$dato['Imagen'].'">';   
                            echo "<li><strong>{$dato['Nombre']}</strong></li>";
                            echo "<li class='precio'>{$dato['Precio']}€</li>";
                            echo "<li>{$dato['Formato']}</li>";
                            echo "<li>{$dato['Tipo']}</li></a>";


                            echo '<form action="' . htmlspecialchars($_SERVER["PHP_SELF"]) . '" method="POST">
                            <p>Cantidad: <input type="number"  name="cantidad" id="cantidad" value="'. $cantidad .'" min="1" class = "input-cant"></p>
                            <p><input type="hidden"  name="identificador_libro" value="' . $idLibro . '" id="identificador_libro"></p>
                            </form>';

                            echo "<li class='formato'>Cantidad total: {$cantidad}</li>";
                            
                            /* Calculamos el precio por cantidad de libros */
                            $precioUdLibro = $cantidad * $dato['Precio'];
                            echo "<li>Total: {$precioUdLibro}€</li>";

                            $precioFinal += $precioUdLibro;

                            /* Boton de eliminar producto */
                            echo '<div class="boton-eliminar">';
                            echo '<form action="' . htmlspecialchars($_SERVER["PHP_SELF"]) . '" method="POST">
                            <input type="hidden" name="identificador_libro" value="' . $idLibro . '" id="identificador_libro">
                            <button type="submit" name="borrar_libro_del_carrito" class="bi bi-trash-fill"></button>
                            </form><br>';
                            echo '</div>';
                                }   
                    echo "</ul>";
                    }
                }

            }
            ?>
            <?php
            $precioTotal_boton =  "<div class= 'caja-total'>";
            if (!empty($carritoActual)) {
                $precioTotal_boton .=   '<form action="confirmacion.php" method="GET">
                <h2>Total pedido: '.$precioFinal.'€</h2>
                <input type="hidden" name="precioFinal" value="' . $precioFinal . '" id="identificador_libro">
                <input type="submit" name="comprar" class="boton-comprar" value="Comprar">
                </form> '; 
                $precioTotal_boton .= "</div>"; 
            }
        } else {
            /* Si queremos ver el carrito de la compra y no se ha iniciado sesión, saltará este mensaje y 
            si pinchamos en  'Iniciar sesion' nos redirige a 'login.php'  */
            echo "<p class='alerta-sesion'><i class='bi bi-x-square-fill'></i> <a href='login.php'><b><u>Inicia sesión </u></b></a> para ver tu carrito</p>";
        }
        
            ?>
            </div>
            <?php 
            echo $precioTotal_boton;
            ?>
        </main>
    </body>

    </html>
