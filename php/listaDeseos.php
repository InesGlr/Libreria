    <!--------------------------                           PHP                            --------------------------------->
    <!-- En este fichero comprobamos si tenemos una sesion iniciada, si no es asi, saltara un alerta ya que
    para poder ver la lista de deseos, tenemos que tener iniciada la sesion.
    Creamos una cookie para controlar la lista de deseos de cada usuario registrado.
    Podemos eliminar libros de la lista de deseos
    Haciendo clic sobre los libros, accedemos a la informacion / caracteristicas-->

<?php
    /* Incluimos el contenido del fichero 'general.php' */
    require('general.php');

    /* Conexión con la base de datos */
    $cadena_conexion = "mysql:dbname=libreria;host=127.0.0.1";
    $usuario = "root";
    $clave = "";
    $bd = new PDO($cadena_conexion, $usuario);
    $bd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
  
?>
    
 <!--------------------------                           HTML                            --------------------------------->
 <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lista de deseos</title>
        <link rel="stylesheet" href="../css/listaDeseos.css">

    </head>

    <body>
        <!--------------------         CUERPO PRINCIPAL         ----------------------->
        <main>
    <?php
    /* Verificamos si la sesion está inicializada y si no esta vacia */
    if (isset($_SESSION['usuario']) && !empty($_SESSION['usuario'])) {

        /* Almacenamos en la variable el nombre de la cookie, que será listaDeseos_ seguido del valor del IdUsuario*/
        $nombreCookieLista = "listaDeseos_" . $_SESSION['usuario']['IdUsuario'];
        /* Comprobamos si esta inicializara la cookie y la convertimos en un array. */
        $listaActual = isset($_COOKIE[$nombreCookieLista]) ? unserialize($_COOKIE[$nombreCookieLista]) : array();

        /* Si está vacia la variable '$listaActual', saltará un mensaje de que la lista de deseos esta vacía */
        if (empty($listaActual)) {
            echo '<h3 class="advertencia">Tu lista de deseos está vacía</h3>';

        }else {
        /* Si no esta vacía  ' $listaActual': */
        if (!empty($listaActual)) {
            /* Verificamos si se ha inicializado el boton de eliminar,si es asi,
            obtiene el id del libro a eliminar, verifica si esta en la lista de deseos
            lo elimina y actualiza la cookie */
            if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["borrar_libro_de_la_lista"])) {
                $idLibroEliminar = $_POST["identificador_libro"];
    
                if (in_array($idLibroEliminar, $listaActual) ) {
                
                    $listaActual = array_diff($listaActual, array($idLibroEliminar));

                    setcookie($nombreCookieLista, serialize($listaActual), time() + (86400 * 365 * 10));
                    if (empty($listaActual)) {
                        echo '<h3 class="advertencia">Tu lista de deseos está vacía</h3>';
            
                    }
                }
            }

            /* Hacemos que nos muestre primero los últimos libros insertados. */
            $listaDeseosInvertida = array_reverse($listaActual);
            /* Hacemos una consulta a la BBDD para guardar en $libros toda su informacion */
            foreach ($listaDeseosInvertida as $idLibro) {
                $libros = $bd->query("SELECT l.*, a.Nombre AS NombreAutor, a.Apellidos AS ApellidosAutor
                    FROM libro l
                    INNER JOIN autor a ON l.Autor = a.IdAutor
                    WHERE l.IdLibro = '$idLibro'
                ");
            
                $imprimeLibros = '<ul>';
                /* Imprimimos toda su información */
                    foreach ($libros as $libro) {
                        $imprimeLibros .= '<a href="libro.php?id=' . $libro['IdLibro'] . '">';
                        $imprimeLibros .= '<img src= "'.$libro['Imagen'].'">';
                        $imprimeLibros .='<li class="nom"><strong>' . $libro['Nombre'] . '</strong></li>';
                        $imprimeLibros .= "<li>{$libro['ApellidosAutor']}, {$libro['NombreAutor']} </li>";
                        $imprimeLibros .= "<li class='precio'>{$libro['Precio']}€</li>";
                        $imprimeLibros .= "<li class='formato'>{$libro['Formato']}</li></a>";
                    
                        $imprimeLibros .= '<form action="' . htmlspecialchars($_SERVER["PHP_SELF"]) . '" method="POST">
                        <input type="hidden" name="identificador_libro" value="' . $idLibro . '" id="identificador_libro">
                        <button type="submit"  name="borrar_libro_de_la_lista" class="bi bi-trash-fill"></button>
                        </form><br>';
                    }              
                    $imprimeLibros .= '</ul>'; 

                    echo $imprimeLibros;    
            }            
        } 
    }    
} else {
        /* Si queremos ver la lista de deseos y no se ha iniciado sesión, saltara este mensaje y 
        si pinchamos en  'Iniciar sesion' nos redirige a 'login.php'  */
        echo "<p class='alerta-sesion'><i class='bi bi-x-square-fill'></i> <a href='login.php'><b><u>Inicia sesión </u></b></a> para ver tu lista de deseos</p>";

}
    ?>
        </main>
    </body>

    </html>
