     <!--------------------------                           PHP                            --------------------------------->
    <!-- Fichero con el formulario de Registo -->
    <?php
      /* Incluimos el contenido del fichero 'general.php' */
    require('general.php');

    /* Conexión con la base de datos */
    $cadena_conexion = "mysql:dbname=libreria;host=127.0.0.1";
    $usuario = "root";
    $clave = "";

    /* Declaración de variables */
    $complearFormulario = "";
    $coincidencia = "";
    $formatoCorreo = "";
    $existente = "";

    /* A través del metodo POST verificamos si están inicializado los campos del formulario y lo almacenamos
    en su variable correspondiente. */
    try {
        $db = new PDO($cadena_conexion, $usuario, $clave);
        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            if (isset($_POST["nombre"]) && isset($_POST["correoR"]) && isset($_POST["claveR"]) && isset($_POST["claveRC"])) {
                $nombre = $_POST['nombre'];
                $correoR = strtolower($_POST['correoR']);
                $claveR = $_POST['claveR'];
                $claveRC = $_POST['claveRC'];

                /* Hacemos varias comprobamos:
                -  Que ningún campo del formulario esté vacio.
                -  Verificamos que el correo cumpla con una estuctura correcta. (Tiene que contener '@' y que termine en '.con' o '.es').
                -  Que el campo de contraseña y confirmacion contraseña coincidan
                -  Realizamos una consulta para verificar que el correo no este enlazado a otra cuenta
                     */
                if (empty($nombre) || empty($correoR) || empty($claveR) || empty($claveRC)) {
                    $complearFormulario = "Debe completar todo el formulario";
                } else if (!filter_var($correoR, FILTER_VALIDATE_EMAIL) || !preg_match("/@.*(\.es|\.com)$/", $correoR)) {
                    $formatoCorreo = "El formato del correo no es válido. <br> Debe contener '@' y terminar en '.es' o '.com'";
                } else if ($claveR != $claveRC) {
                    $coincidencia = "Las contraseñas no coinciden";
                } else {
                    $comprobacion = "SELECT * FROM usuario WHERE Correo = '$correoR'";
                    $usu = $bd->query($comprobacion);
                    if ($usu->rowCount() === 1) {
                            $existente = "Ya existe una cuenta enlazada a este correo";
                        } else {
                        
                        /*Si todo esta corecto, insertamos todos los datos en la tabla usuario que por defecto
                        cuando un usuario se registe tendrá un saldo de 100€ */
                        $ins = "INSERT INTO usuario (Nombre, Clave, Correo, Saldo) VALUES (:nombre, :claveR, :correoR, 100 )";
                        $stmt = $db->prepare($ins);

                        $stmt->bindParam(':nombre', $nombre);
                        $stmt->bindParam(':claveR', $claveR);
                        $stmt->bindParam(':correoR', $correoR);

                        /* Selecionamos todos los datos del usaurio y lo almacenamos en la variable $usuario */
                        if ($stmt->execute()) {
                            $ins2 = "SELECT * FROM usuario WHERE Correo = :correoU";
                            $stmt2 = $bd->prepare($ins2);
                            $stmt2->bindParam(":correoU", $correoR);
                            $stmt2->execute();
                            $usuario = $stmt2->fetch();

                            session_start(); /* Iniciamos sesión para almacenar los datos del usuario */
                            $_SESSION['usuario'] = $usuario; 
                            
                            header("Location: principal.php"); /* Si todo es correcto, redirigimos a 'principal.php' */
                            exit();
                        } else {
                            echo "Error al registrar el usuario";
                        }
                    
                    }
                }
            }
        }
    } catch (PDOException $e) {
        echo "Error con la base de datos: " . $e->getMessage();
    }
    ?>


    <!--------------------------                           HTML                            --------------------------------->
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/login_registro.css">
        <title>Formulario</title>
    </head>

    <body>
        <!--------------------         CUERPO PRINCIPAL         ----------------------->
        <main>
            <form action=" <?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="POST">

                <div class="registro">
                    <h1>REGISTRASE</h1>
                    <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="POST">
                        <input name="nombre" type="text" placeholder="Nombre" require>
                        <input name="correoR" type="text" placeholder="Correo Electronico">
                        <p><input name="claveR" id="claveR" type="password" placeholder="Contraseña">
                            <i id="eyeIconR" class="bi bi-eye-fill" onclick="verClave()"></i></p>

                        <p><input name="claveRC" id="claveRC" type="password" placeholder="Confirmar contraseña">
                            <i id="eyeIconRC" class="bi bi-eye-fill" onclick="verClave2()"></i></p><input type="submit" name="registrarse" value="Registrarme" class="botones">
                            <p>¿Tienes cuenta? <a href="login.php"><b>Iniciar Sesión</b></a></p>

                        <!-- Mensajes errores -->
                        <p class="rojo"><?php echo $coincidencia ?><?php echo $complearFormulario ?>
                        <?php echo $formatoCorreo ?> <?php echo $existente ?></p>
                    </form>
                </div>
            </form>
        </main>    
    </body>
</html>

    <!--------------------------                           JAVASCRIPT                            --------------------------------->
    <script>
        /* Con esta funcion en JavaScript controlamos el icono 'eyeIcon' para ocultar o poder ver la contraseña */
        /* Campo 'Contraseña' */
        function verClave() {
            let claveInput = document.getElementById("claveR");
            let eyeIcon = document.getElementById("eyeIconR");

            if (claveInput.type === "password") {
                claveInput.type = "text";
                eyeIconR.classList.remove("bi-eye-fill");
                eyeIconR.classList.add("bi-eye-slash-fill");
            } else {
                claveInput.type = "password";
                eyeIconR.classList.remove("bi-eye-slash-fill");
                eyeIconR.classList.add("bi-eye-fill");
            }
        } 

         /* Con esta funcion en JavaScript controlamos el icono 'eyeIcon' para ocultar o poder ver la contraseña */
        /* Campo 'Confirmar Contraseña' */
        function verClave2(){
            let claveInput = document.getElementById("claveRC");
            let eyeIcon = document.getElementById("eyeIconRC");                

            if (claveInput.type === "password") {
                claveInput.type = "text";
                eyeIcon.classList.remove("bi-eye-fill");
                eyeIcon.classList.add("bi-eye-slash-fill");
            } else {
                claveInput.type = "password";
                eyeIcon.classList.remove("bi-eye-slash-fill");
                eyeIcon.classList.add("bi-eye-fill");
            }
        }
        </script>
