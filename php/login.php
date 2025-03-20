    <!--------------------------                           PHP                            --------------------------------->
    <!-- Fichero con el formulario de Inicio de sesión -->
    
    <?php
    /* Incluimos el contenido del fichero 'general.php' */
    require('general.php');
    
    // Redirigido
    if (isset($_GET["redirigido"])) {
        echo "<p>Debes hacer login para continuar</p>";
    }

    /* Función para comprobar si el correo y la clave del usuario
      existen en la base de datos y si coinciden */
    function comprobar_usuario($correo, $clave){
        $cadena_conexion = "mysql:dbname=libreria;host=127.0.0.1";
        $usuario = "root";
        $bd = new PDO($cadena_conexion, $usuario);
        $ins = "SELECT * FROM usuario WHERE Correo = '$correo' AND Clave = '$clave';";
        $resul = $bd->query($ins);
        if ($resul && $resul->rowCount() === 1) {
            return $resul->fetch();
        } else {
            return false;
        }
    }
    /* Declaración de variables */
    $completarFormulario = "";
    $formatoCorrecto = "";

    /* Verificamos a través del metodo POST si los datos obtenidos
    del formulario existene en la base de datos  */
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $correo = $_POST['correo'];
        $clave = $_POST['clave'];
        $usu = comprobar_usuario($_POST["correo"], $_POST["clave"]);

        if (empty($_POST['correo']) || empty($_POST['clave'])) {
            $completarFormulario = "Debe completar todo el formulario";
        }
        else if ($usu == false) {
            $formatoCorrecto = "Revise usuario y contraseña";
        } else {
            session_start(); /* Iniciamos sesión para almacenar los datos del usuario */
            $_SESSION['usuario'] = $usu;
            header("Location: principal.php");/* Si todo es correcto, redirigimos a 'principal.php' */
        }
    }
    
    ?>


    <!--------------------------                           HTML                            --------------------------------->
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/login_registro.css">
        <title>Inicio sesión</title>
    </head>

    <body>

        <!--------------------         CUERPO PRINCIPAL         ----------------------->
        <main>
            <!-- Formulario de login -->
            <form action=" <?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="POST">
                <div class="registro">
                    <div class="login">
                        <h1>INICIAR SESIÓN</h1>
                        <input name="correo" type="text" placeholder="Correo" value="<?php if (isset($correo)) echo $correo; ?>">
                        <p><input name="clave" id="clave" type="password" placeholder="Contraseña">
                            <i id="eyeIcon" class="bi bi-eye-fill" onclick="verClave()"></i></p>
                        <input type="submit" name="enviar" value="Iniciar Sesion" class="botones">

                        <!-- Errores -->
                        <p>¿No tienes cuenta? <a href="registro.php"><b>Registrate</b></a></p>
                        <p class="rojo"><?php echo $completarFormulario ?></p>
                        <p class="rojo"><?php echo $formatoCorrecto ?></p>
                        </div>
                    
            </form>
        </main>
        <script>
            /* Con esta funcion en JavaScript controlamos el icono 'eyeIcon' para ocultar o poder ver la contraseña */
            function verClave() {
                let claveInput = document.getElementById("clave");
                let eyeIcon = document.getElementById("eyeIcon");
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
    </body>

    </html>
