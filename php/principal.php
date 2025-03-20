    <!--------------------------                           PHP                            --------------------------------->
    <!-- En este fichero realizamos consultas a la base de datos para imprimir las caracteristicas de los
    'libros polulares' y 'más baratos'.-->
    
    <?php
    /* Incluimos el contenido del fichero 'general.php' */
    require('general.php');

    /* Conexión con la base de datos */
    $cadena_conexion = "mysql:dbname=libreria;host=127.0.0.1";
    $usuario = "root";
    $bd = new PDO($cadena_conexion, $usuario);
    $bd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_SILENT);

    /* Consulta a la base de datos para buscar los libros 'populares' y lo almacenamos el la variable $resul */
    $resul = $bd->query(
        "SELECT l.*, a.Nombre AS NombreAutor, a.Apellidos AS ApellidosAutor, g.Nombre AS NombreGenero
        FROM libro l
        JOIN autor a ON l.Autor = a.IdAutor
        JOIN genero g ON l.Genero = g.IdGenero
        WHERE l.Populares = '1';
    "
    );
        /* Almacenamos en la variable $librosPopulares, una lista con todas las caracteristicas de los libros polulares */
        $librosPopulares = '<ul class= "ul-libros">';
        foreach ($resul as $libro) {  
            $librosPopulares .= '<a href="libro.php?id=' . $libro['IdLibro'] . '"</a>';
            $librosPopulares .= '<img src= "'.$libro['Imagen'].'"></li>';
            $librosPopulares .= "<li class='nom'><strong>{$libro['Nombre']}</strong></li>";
            $librosPopulares .= "<li>{$libro['ApellidosAutor']}, {$libro['NombreAutor']}</li>";
            $librosPopulares .= "<li class='precio'>{$libro['Precio']}€</li>";
            $librosPopulares .= "<li class='formato'>{$libro['Formato']}</li>";
        
        }              
        $librosPopulares .= '</ul>'; 
        
           /* MAS BARATOS */

        /* Consulta a la base de datos para buscar los libros 'masBaratos' y lo almacenamos el la variable $resul */
        $resul = $bd->query(
            "SELECT l.*, a.Nombre AS NombreAutor, a.Apellidos AS ApellidosAutor, g.Nombre AS NombreGenero
            FROM libro l
            JOIN autor a ON l.Autor = a.IdAutor
            JOIN genero g ON l.Genero = g.IdGenero
            ORDER BY l.Precio ASC
            LIMIT 8;
        ");
        
        /* Almacenamos en la variable $losMasBaratos, una lista con todas las caracteristicas de los libros más baratos */
        $losMasBaratos = '<ul class= "ul-libros">';
    
        foreach ($resul as $libro) {  
            $losMasBaratos.= '<a href="libro.php?id=' . $libro['IdLibro'] . '">';
            $losMasBaratos.= '<img src= "'.$libro['Imagen'].'"></li>';
            $losMasBaratos.= "<li class='nom'><strong>{$libro['Nombre']}</strong></li>";
            $losMasBaratos.= "{$libro['ApellidosAutor']}, {$libro['NombreAutor']}</li>";
            $losMasBaratos.= "<li class='precio'>{$libro['Precio']}€</li>";
            $losMasBaratos .= "<li class='formato'>{$libro['Formato']}</li>";
            }              
        $librosPopulares .= '</a></ul>';  
    ?>

    <!--------------------------                           HTML                            --------------------------------->
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Principal</title>
        <link rel="stylesheet" href="../css/principal.css">
    </head>

    <body>
        <!--------------------         CUERPO PRINCIPAL         ----------------------->
        <main>
            <!-- Impresion de libros populares -->
            <div class="estilos">
                <h2 class="titulos">Populares</h2>
                    <?php
                    echo $librosPopulares;
                    ?>
            </div>
            <!-- Impresion de libros más baratos -->
            <div class="estilos2">
                <h2 class="titulos">Los más Baratos</h2>
                    <?php
                    echo $losMasBaratos;
                    ?>  
            </div>
            
        </main>
    </body>

    </html>
