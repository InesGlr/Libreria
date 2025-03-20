<!-- ESTE PHP ES LA BASE DE TODA LA PAGINA WEB, TANTO HTML, CSS Y PHP   -->

<!--------------------------                           PHP                            --------------------------------->
<?php
    ob_start();
    session_start();    

    //Conexión a la BBDD
    $cadena_conexion = "mysql:dbname=libreria;host=127.0.0.1";
    $usuario = "root";
    
    try {
        // Crear conexión PDO
        $bd = new PDO($cadena_conexion, $usuario);
        $bd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        


//////////////////           OBTENCIÓN NOMBRES DE LOS GÉNEROS Y DATOS DE LOS LIBROS                ///////////////////////

        //Obtener géneros desde la base de datos
        $generosResult = $bd->query("SELECT * FROM genero");
        $generosLibros = [];
    
        while ($row = $generosResult->fetch(PDO::FETCH_ASSOC)) {
            $generosLibros[$row['IdGenero']] = $row['Nombre'];
        }
    
        //Inicializar el género seleccionado
        $generoSeleccionado = isset($_GET['genero']) ? $_GET['genero'] : key($generosLibros);
        //Guardamos el genero en una variable
        $nombreGeneroSeleccionado = $generosLibros[$generoSeleccionado];
    
        //Obtener información completa de libros del género seleccionado desde la base de datos
        $librosResult = $bd->query("
            SELECT l.*, a.Nombre AS NombreAutor, a.Apellidos AS ApellidosAutor
            FROM libro l
            INNER JOIN autor a ON l.Autor = a.IdAutor
            WHERE l.Genero = $generoSeleccionado
        ");
        
        $libros = $librosResult->fetchAll();

    }catch (PDOException $e) {
        die("Error de conexión a la base de datos: " . $e->getMessage());
    } 
?>

    <!--------------------------                           HTML                            --------------------------------->
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
            <link rel="stylesheet" href="../css/general.css">
            <link rel="shortcut icon" href="../img/icono.ico" id="iconoVentana"/>        
        </head>

        <body>

            <!--------------------         CABECERO         ----------------------->
            <header>
                <!-- Barra Superior -->
                <section class="barra_superior">
                    <a class="cab_izq" href="principal.php">
                        <i class="bi bi-book-fill"></i>     <!-- Logo de la pagina -->
                        <h1>Literary league</h1>
                    </a>
                        <ul class="cab_der">
                            <li><a href="listaDeseos.php"><i class="bi bi-heart-fill"></i></a></li>
                            <li><a href="carrito.php"><i class="bi bi-cart"></i></a></li>
                            <li>
                                <div class="menu-desplegable">
                                    <!-- Si no hay un usuario iniciado aparece la siguiente lista con un enlace para hacer login y otro para registrarse en caso de no tener cuenta -->
                                    <?php if (!isset($_SESSION['usuario']) || empty($_SESSION['usuario']) || $_SESSION['usuario'] == null) {
                                        echo '<h2>Mi Cuenta</h2>
                                            <ul class="submenu">
                                            <li><a href="login.php">Iniciar Sesión</a></li>     
                                            <li><a href="registro.php">Registrarse</a></li>  
                                            </ul>';
                                    } else{
                                    /* Si hay usuario (con la cuenta iniciada) nos aparecerá un icono y el nombre del usuario y en el menu desplegable un enlace a mis pedidos, configuracion y cerrar sesion */
                                    $idusuario = $_SESSION["usuario"]["IdUsuario"];
                                    $usuario = $bd->prepare("SELECT Nombre FROM usuario WHERE IdUsuario = ?");
                                    $usuario->execute([$idusuario]);
                                    $resulUd = $usuario->fetch(PDO::FETCH_ASSOC);
                                    echo '<i class="bi bi-person-circle"> ' . $resulUd['Nombre'] . '</i>
                                    <ul  class="submenu">
                                    <li ><a href="misPedidos.php"><i class="bi bi-bag-check-fill"></i>Mis pedidos</a></li>
                                    <li class="confi"><a href="configuracion.php"><i class="bi bi-gear-fill"> Configuración</i></a></li>
                                    <li><button><a href="logout.php"><i class="bi bi-box-arrow-left"> Cerrar sesión</i></a></button></li>
                                    </ul>';
                                    } 
                                    ?>
                            </li>
                        </ul>

                    </div>
                </section>

                <!-- Barra Inferior -->
                <section class="barra_inferior">
                <form action="buscador.php" method="GET">   <!-- Buscador, donde se podrá buscar por nombre, autor, genero, saga o ISBN por buscador.php -->
                    <input type="text" name="busqueda" id="busqueda" placeholder="Busca por nombre, autor, género, saga o ISBN">
                    <button  class=" bi bi-search"></button>
                </form>
            </section>
            </header>


            <!--------------------         NAVEGADOR         ----------------------->
            <!-- Menu de categorias -->
            <nav >
            <div id="abrir_nav">&#9776; Menú</div>
                <div id= "navegador_lateral">
                        <!-- Iconos para pliege del navegador lateral -->
                    <i id="cerrar_nav" class="bi bi-x-lg"></i>
                        <i><a id="sinHover">GÉNEROS</a></i><ul>
                            <?php
                                //Mostrar lista de enlaces de los géneros
                                foreach ($generosLibros as $idGenero => $nombreGenero) {
                                    echo "<li><a href=genero.php?genero=$idGenero>$nombreGenero</a></li>";
                                }
                            ?>
                    </ul>
                </div>
            </nav>
            <!--------------------         CUERPO PRINCIPAL         ----------------------->
            <main>
                <?php 
                //Muestra una lista de libros y la información completa de cada uno segun el género 
                $imprimeLibros = '<ul class="ul-general">';
                foreach ($libros as $libro) {       
                        $imprimeLibros .= '<a href="libro.php?id=' . $libro['IdLibro'] . '">';
                        $imprimeLibros .= '<img src= "'.$libro['Imagen'].'">';
                        $imprimeLibros .='<li class="nom"><strong>' . $libro['Nombre'] . '</strong></li>';
                        $imprimeLibros .= "<li>{$libro['ApellidosAutor']}, {$libro['NombreAutor']} </li>";
                        $imprimeLibros .= "<li class='precio'>{$libro['Precio']}€</li>";
                        $imprimeLibros .= "<li class='formato'>{$libro['Formato']}</li>";
                }  
                $imprimeLibros .= '</ul>'; 
                ?>    
            </main>

            <!--------------------         PIE DE PAGINA         ----------------------->
            <footer>
                <div class="pie_izq">
                    <h2>Contacto</h2>
                    <ul>
                        <li>+34 666 555 444</li>
                        <li>LiteraryLeague@gmail.com</li>
                        <li>45007, Calle León nº35</li>
                    </ul>
                </div>
                <div class="pie_der">
                    <h2>Redes sociales</h2>
                    <ul>
                        <li><a href="#"><i class="bi bi-instagram"></i></a></li>
                        <li><a href="#"><i class="bi bi-facebook"></i></a></li>
                        <li><a href="#"><i class="bi bi-twitter"></i></a></li>
                    </ul>
                </div>
            </footer>
    </body>
</html>

    <!--------------------------                           JAVASCRIPT                            --------------------------------->
    <script>
        //Funciones para desplegar el navegador lateral
        var abrirNav = document.getElementById("abrir_nav");    //Menú
        var cerrarNav = document.getElementById("cerrar_nav");  //Icono X
        var navegador = document.getElementById("navegador_lateral");   //Navegador
        var navegadorVisible = true;    //Al entrar en la página el navegador siempre será visible

        //Función para mostrar el navegador pulsando en el Menú
        abrirNav.addEventListener("click", function() {
            navegador.style.display = "flex";  
            abrirNav.style.visibility = "hidden";
            navegadorVisible = true;
        });

        //Función para ocultar el navegador pulsando en la X
        cerrarNav.addEventListener("click", function() {
            navegador.style.display = "none";
            abrirNav.style.visibility = "visible";
            navegadorVisible = false;
        });

        //Impedimento para evitar mensaje de recarga de la pagina
        if(window.history.replaceState){
                window.history.replaceState(null,null,window.location.href);
        }          
                
    </script>
        
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>