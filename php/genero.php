    <!--------------------------                           PHP                            --------------------------------->
    <!-- En este fichero se imprimen los libros según el género selecionado -->
    <?php
    /* Incluimos el contenido del fichero 'general.php' */
    require('general.php');

    ?>

    <!--------------------------                           HTML                            --------------------------------->
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Generos</title>
        <link rel="stylesheet" href="../css/genero.css">
    </head>

    <body>

        <!--------------------         CUERPO PRINCIPAL         ----------------------->
        <main>
            <div class="prueba">
            <!-- Imprimimos el nombre del genero que hayamos seleccionado anteriormente -->
            <!-- La variable $imprimeLibros contiene los libros según su género. (Más detalles en 'general.php) -->
            <?php 
                echo '<h2>' . $nombreGeneroSeleccionado . '</h2>';
                echo $imprimeLibros;
            ?>
            </div>
        </main>
    </body>
</html>
