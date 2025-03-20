    <!--------------------------                           PHP                            --------------------------------->
    <?php
    //Incluimos el contenido del fichero 'general.php'
    require('general.php');

    //Conexión a la base de datos utilizando PDO
    $cadena_conexion = "mysql:dbname=libreria;host=127.0.0.1";
    $usuario = "root";


    try {
        $bd = new PDO($cadena_conexion, $usuario);
        $bd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


        //Función para realizar la búsqueda
        function buscarLibros($busqueda, $bd) {
            $busqueda = "%$busqueda%";      //Almacenar la busqueda en una variable
        
        //Búsqueda por autor (Nombre y/o Apellido)
            $query = "SELECT libro.*, autor.Nombre AS NombreAutor, autor.Apellidos AS ApellidosAutor   /* Recogera todas las columnas de libro y de autor recogera Nombre y Apellidos*/
            FROM autor      /* De la tabla autor */
            JOIN libro ON autor.IdAutor = libro.Autor   /* Utilizamos JOIN para unir las tablas autor y libro en base a la condición autor.IdAutor = libro.Autor  */
            WHERE CONCAT(autor.Nombre, ' ', autor.Apellidos) LIKE :busqueda;    /* Juntamos nombre y apellido del autor y que sea igual a la busqueda*/
            ";   

            $stmt = $bd->prepare($query);   //Preparamos la consulta
            $stmt->bindParam(':busqueda', $busqueda, PDO::PARAM_STR);   //Se vincula el parametro :busqueda con la variable $busqueda
            $stmt->execute();       //Se ejecuta la consulta
            $resultados_autor = $stmt->fetchAll(PDO::FETCH_ASSOC);  //Se recuperan todos los resultados de la consulta como un array asociativo y se almacenan en la variable $resultados_autor

        //Búsqueda por género
            $query = "SELECT libro.*, autor.Nombre AS NombreAutor, autor.Apellidos AS ApellidosAutor      /* Recogera todas las columnas de libro y de autor recogera Nombre y Apellidos */
            FROM genero     /* De la tabla genero */
            JOIN libro ON genero.IdGenero = libro.Genero        /* Utilizamos JOIN para unir las tablas genero y libro en base a la condición genero.IdGenero = libro.Genero  */
            JOIN autor ON libro.Autor = autor.IdAutor   /* Utilizamos JOIN para unir las tablas libro y autor en base a la condición libro.Autor = autor.IdAutor  */
            WHERE genero.Nombre LIKE :busqueda;     /* Donde el nombre del Genero sea igual a la busqueda */
            ";

            $stmt = $bd->prepare($query);       //Preparamos la consulta
            $stmt->bindParam(':busqueda', $busqueda, PDO::PARAM_STR);   //Se vincula el parametro :busqueda con la variable $busqueda
            $stmt->execute();     //Se ejecuta la consulta
            $resultados_genero = $stmt->fetchAll(PDO::FETCH_ASSOC);     //Se recuperan todos los resultados de la consulta como un array asociativo y se almacenan en la variable $resultados_genero

        //Búsqueda por libro (Nombre, ISBN o Nombre de saga)
            $query = "SELECT libro.* , autor.Nombre AS NombreAutor, autor.Apellidos AS ApellidosAutor       /* Recogera todas las columnas de libro y de autor recogera Nombre y Apellidos */
            FROM libro      /* De la tabla libro */
            JOIN autor ON libro.Autor = autor.IdAutor       /* Utilizamos JOIN para unir las tablas libro y autor en base a la condición libro.Autor = autor.IdAutor  */
            WHERE libro.Nombre LIKE :busqueda OR libro.ISBN LIKE :busqueda OR libro.Saga LIKE :busqueda;    /* Donde el nombre o ISBN o el nombre de la saga del libro sea igual a la busqueda */
            ";

            $stmt = $bd->prepare($query);       //Preparamos la consulta
            $stmt->bindParam(':busqueda', $busqueda, PDO::PARAM_STR);   //Se vincula el parametro :busqueda con la variable $busqueda
            $stmt->execute();       //Se ejecuta la consulta
            $resultados_libro = $stmt->fetchAll(PDO::FETCH_ASSOC);      //Se recuperan todos los resultados de la consulta como un array asociativo y se almacenan en la variable $resultados_libro

            //Combinamos los resultados y eliminamos los duplicados y los almacenamos en la variable $resultados
            $resultados = array_unique(array_merge($resultados_autor, $resultados_genero, $resultados_libro), SORT_REGULAR);


            return $resultados;     //retornamos la variable $resultados
        }

    }catch (PDOException $e) {
        echo('Error de conexión a la base de datos: ' . $e->getMessage());
    }

    ?>

    <!--------------------------                           HTML                            --------------------------------->
    <!DOCTYPE html>
        <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Usuario</title>
                <link rel="stylesheet" href="../css/buscador.css">
            </head>

        <body>
            <!--------------------         CUERPO PRINCIPAL         ----------------------->
            <main>
                <?php
                    //Procesar la búsqueda si se envió el formulario
                    if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET["busqueda"])) {
                        $busqueda = isset($_GET['busqueda']) ? trim($_GET['busqueda']) : '';
                    
                        //Si la variable $busqueda no esta vacia llamamos a la funcion
                        if (!empty($busqueda)) {
                            $resultados = buscarLibros($busqueda, $bd);
                        
                            // Si la variable $resultados no esta vacia mostramos los resultados
                            if (!empty($resultados)) {
                                echo '<div class="h1-buscador">';
                                echo '<h2>Resultados de la búsqueda: <b>' . $busqueda . '</b></h2>';
                                echo '</div>';
                                echo '<ul class="ul-busqueda">';
                                //Hacemos un foreach para imprimir todos los libros de la busqueda
                                foreach ($resultados as $libro) {
                                    echo '<a href="libro.php?id=' . $libro['IdLibro'] . '">'; 
                                    echo '<img src= "'.$libro['Imagen'].'"></li>';
                                    echo "<li class ='nombre'><strong>{$libro['Nombre']}</strong></li>";
                                    echo "<li class='precio'>{$libro['Precio']}€</li>";
                                    echo "<li>{$libro['ApellidosAutor']} {$libro['NombreAutor']}</li>";
                                    echo "<li class='formato'>{$libro['Formato']}</li>";
                                }
                                echo '</ul>';
                            } else {
                                echo '<h3 class="advertencia">No se encontraron resultados</h3>';     //Si la variable $resultados esta vacia, es decir que no encontró ningun libro acorde con nuestra busqueda nos aparecerá un mensaje
                            }
                        } else {
                            echo '<h3 class="advertencia">Por favor, ingrese un término de búsqueda</h3>';    //Si la variable $busqueda esta vacia nos aparecerá un mensaje
                        } 
                    }
                ?>
            </main>
        </body>
    </html>
