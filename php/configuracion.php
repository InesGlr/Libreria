<?php
require ('general.php');

// Redirigido a 'logout' 
if (!isset($_SESSION["usuario"])) {
    header("Location: logout.php"); 
} 

//Conexión a la BBDD
$cadena_conexion = "mysql:dbname=libreria;host=127.0.0.1";
$usuario = "root";
$bd = new PDO($cadena_conexion, $usuario,);
$bd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

//Datos del usuario
$idusuario = $_SESSION["usuario"]["IdUsuario"];
$consulta_usuario = $bd->prepare("SELECT * FROM usuario WHERE IdUsuario = ?");
$consulta_usuario->execute([$idusuario]);
$resulUd = $consulta_usuario->fetch(PDO::FETCH_ASSOC);


//Datos de la direccion principal
$idDireccion = isset($_SESSION["direccion"]["IdDireccion"]) ? $_SESSION["direccion"]["IdDireccion"] : null ;
$resulDird = $bd->query("SELECT d.* 
    FROM direccion d, usuario u 
    WHERE d.IdDireccion = COALESCE(u.Direccion, '$idDireccion') AND u.IdUsuario = '$idusuario'");
$resulDir = $resulDird->fetch();
 

    //////////////////////////////                 POST's                ///////////////////////////////////////////////////
if ($_SERVER["REQUEST_METHOD"] == "POST") {


    //////////////         Post.- MODIFICAR USUARIO        ///////////////////
    
    //Comprobamos que este definida
    if (isset($_POST["actualizar_usuario"])) {
        //Datos del formulario  
        $nombre = $_POST["nombre"];
        $clave = $_POST["clave"];
        $saldo = $_POST["saldo"];
        $correo = $_POST["correo"];
        $telefono = $_POST["telefono"];

        //Consulta BD - Si existe el nuevo correo en la tabla 'usuario'
        $compribacion = "SELECT Correo FROM usuario WHERE Correo = '$correo'";
        $usuC = $bd->query($compribacion);

        //Si existe el nuevo correo en la BD dara error, de lo contrario hara la actualizacion
        if ($usuC->rowCount() === 1 && $resulUd["Correo"] !==$correo) {
            //Mensaje error con el correo insertado 
            echo '<script>
                Swal.fire({
                    icon: "warning",
                    title: "Ya existe este correo, prueba con otro",
                    showConfirmButton: false,
                    timer: 3000
                    });
                </script>';
        } else {
        // Actualización los datos del usuario de la tabla 'usuario'
        $actualizar_usuario = $bd->prepare("UPDATE usuario 
                        SET Nombre = ?, Clave = ?, Saldo = ?, Correo = ?,
                            Telefono = ?
                        WHERE IdUsuario = ?");
        $actualizar_usuario->execute([$nombre, $clave, $saldo, $correo, $telefono, $idusuario]);
        
        //Refrescamos la pagina para que aparezcan los datos actuales de la BD
        header("Refresh:0");

        }
    }

    //////////////         Post.- MODIFICAR DIRECCION EXISTENTE        ///////////////////
    
    //Comprobamos que este definida
    if (isset($_POST["actualizar_direccion"])) {

        //Comprobamos que todos los campos a excepcion de 'piso' contengan un valor
        if (empty($_POST["nombreRemitente"]) || empty($_POST["apellidosRemitente"])|| empty($_POST["pais"])
        || empty($_POST["provincia"])|| empty($_POST["ciudad"])|| empty($_POST["cp"])|| empty($_POST["calle"])
        || empty($_POST["numero"]) ) {
            //Mensaje error por un campo sin valor
            echo '<script>
            Swal.fire({
                icon: "warning",
                title: "Complete los campos necesarios",
                showConfirmButton: false,
                timer: 3000
                });
            </script>';
        } else {
            //Datos del formulario  
            $nombreRemitente = $_POST["nombreRemitente"];
            $apellidosRemitente = $_POST["apellidosRemitente"];
            $pais = $_POST["pais"];
            $provincia = $_POST["provincia"];
            $ciudad = $_POST["ciudad"];
            $cp = $_POST["cp"];
            $calle = $_POST["calle"];
            $numero = $_POST["numero"];
            $piso = $_POST["piso"];

            // Actualización los datos de la direccion de la tabla 'direccion', que ademas es la direccion principal
            $actualizar_direccion = $bd->prepare("UPDATE direccion 
                            SET NombreRemitente = '$nombreRemitente', ApellidosRemitente = '$apellidosRemitente',
                            Pais = '$pais', Provincia = '$provincia', Ciudad = '$ciudad', CP = '$cp',
                                Calle = '$calle', Numero = '$numero', Piso = '$piso' 
                            WHERE IdDireccion = '$idDireccion'");
            $actualizar_direccion->execute();

            //Refrescamos la pagina para que aparezcan los datos actuales de la BD
            header("Refresh:0");
        }
    } 
    

    //////////////         Post.- AÑADIR DIRECCIONES        ///////////////////
    
    //Comprobamos que este definida
    if (isset($_POST["añadir"])) {

        //Comprobamos que todos los campos a excepcion de 'piso' contengan un valor
        if (empty($_POST["nombreRem_añadir"]) || empty($_POST["apellidosRem_añadir"])|| empty($_POST["pais_añadir"])
        || empty($_POST["provincia_añadir"])|| empty($_POST["ciudad_añadir"])|| empty($_POST["cp_añadir"])|| empty($_POST["calle_añadir"])
        || empty($_POST["numero_añadir"]) ) {
            //Mensaje error por un campo sin valor
            echo '<script>
            Swal.fire({
                icon: "warning",
                title: "Complete los campos necesarios",
                showConfirmButton: false,
                timer: 3000
                });
            </script>';
        } else {
            
        //Datos del formulario
        $nombreRemi = $_POST["nombreRem_añadir"];
        $apellidosRemi = $_POST["apellidosRem_añadir"];
        $pais = $_POST["pais_añadir"];
        $provincia = $_POST["provincia_añadir"];
        $ciudad = $_POST["ciudad_añadir"];
        $cp = $_POST["cp_añadir"];
        $calle = $_POST["calle_añadir"];
        $numero = $_POST["numero_añadir"];
        $piso = $_POST["piso_añadir"];

    
        // Inicio de la transacción
        $bd->beginTransaction();

        // Inserción de los datos en la tabla 'direccion'
        $ins = "INSERT INTO direccion (NombreRemitente, ApellidosRemitente, Pais, Provincia, Ciudad, CP, Calle, Numero, Piso) 
            VALUES ('$nombreRemi','$apellidosRemi','$pais','$provincia', '$ciudad', '$cp', '$calle', '$numero', '$piso')";
        $stmt = $bd->prepare($ins);
        $resul = $stmt->execute();

        // Inserción del id de la direccion y el id del usuario en la tabla 'usuariodireccion'
        $id_direc = $bd->lastInsertId();
            $usuario_direc2 = $bd->prepare("INSERT INTO usuariodireccion (Usuario, Direccion) 
                                            VALUES ('$idusuario','$id_direc')");
        
            //Si alguno de los insert da error revertimos la transaccion, sino se ejecuto
            if (!$resul || !$usuario_direc2->execute()) {
                echo "Error: " . print_r($stmt->errorInfo()) . "<br>";
                $bd->rollBack();
            } else {
                $bd->commit();  
            }  
        } 
    } 


    //////////////         Post.- LISTA DIRECCIONES.-PARTE1/2        ///////////////////
    if (isset($_POST["id_direccion_usuario"])) {

        //Datos del formulario
        $id_direccion = $_POST["id_direccion_usuario"];

        //Consulta BD - obtencion datos de la direcion
        $consulta_direccion = $bd->query("SELECT * FROM direccion WHERE IdDireccion = '$id_direccion'");
        $nueva_direccion = $consulta_direccion->fetch(PDO::FETCH_ASSOC);

        // Actualización de la dirección del usuario en la tabla de 'usuario'
        $consulta_update = $bd->query("UPDATE usuario SET Direccion = '$id_direccion' WHERE IdUsuario = $idusuario");
            
            //Comprobacion en el caso de haber un error con la BD
            if ($consulta_update) {
                echo "La dirección del usuario se actualizó correctamente";
            } else {
                echo "Error al actualizar la dirección del usuario";
            }
        //Refrescamos la pagina para que aparezcan los datos actuales de la BD
        header("Refresh:0");
    }
}


    //////////////         LISTA DIRECCIONES.-PARTE2/2        ///////////////////

//Variable que emplearemos para imprimir el contenido
$direccionesUsuario ='' ;

/*Consulta BD - para la obtencion de los datos de las direcciones que
 esten relacionadas con el usuario, la direccion y que esten en la tabla usuariodireccion */
$resul = $bd->query("SELECT d.*
FROM usuario u, direccion d, usuariodireccion ud
WHERE u.IdUsuario = ud.Usuario AND d.IdDireccion = ud.Direccion AND u.IdUsuario = '$idusuario';");

//Si se encuentra algun resultado distinto de 0
if ($resul && $resul->rowCount() > 0) {

    //Guardamos los valores
    $resul = $resul->fetchAll();

    /*Imprimimos cada direccion dentro de un form para la futura 
    decision del usuario de selecionar una direccion como principal */
    foreach($resul as $dato){
    $direccionesUsuario .='<form action="' . htmlspecialchars($_SERVER["PHP_SELF"]) . '" method="POST"';
    
        /*Si el id de la direccion es el mismo que tiene el usuario como direccion principal, 
        le aplica el siguiente css que lo destaca ante las otras direcciones */
        if($dato['IdDireccion'] == $resulUd["Direccion"]){
            $direccionesUsuario .=' class=" bi2 bi-check-circle-fill"';
        }
            $direccionesUsuario .='>';
                $direccionesUsuario .= '<input type="hidden" name="id_direccion_usuario" value="' . $dato['IdDireccion'] . '" class="id_direccion_usuario">
                    <button>
                    <ul class="lista-direcciones" >
                        <li>Remitente: '.$dato['NombreRemitente'].' '.$dato['ApellidosRemitente'].'</li>
                        <li>Calle '.$dato['Calle'].' nº'.$dato['Numero'];
                        if($dato['Piso'] !== ''){
                            $direccionesUsuario .= ', piso: '.$dato['Piso'].'';
                        }
                        $direccionesUsuario .= '</li>
                        <li>'.$dato['Provincia'].', '.$dato['Ciudad'].' '.$dato['CP'].'</li>
                        <li>'.$dato['Pais'].'</li>';
                        $direccionesUsuario .= '</button>
                    </ul>
        </form>';
    }

} else {
    $direccionesUsuario .= "No tienes ninguna direccion";
}

?>

<!--------------------------                           HTML                            --------------------------------->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/configuracion.css">
    <title>Configuración</title>
</head>
<body>
<main>
    <!----------------         Formulario del usuario          --------------------->
<div class="usuario">
    <h1>Configuración</h1>
    <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="POST" class="actualizar_usuario">
        <ul>
        <li>Nombre: <input name="nombre" type="text" required value="<?php echo htmlspecialchars($resulUd["Nombre"]); ?>"></li>
        <li>Contraseña: <input name="clave" id="clave" type="password" required value="<?php echo htmlspecialchars($resulUd["Clave"]); ?>">
            <i id="eyeIcon" class="bi bi-eye-fill" onclick="verClave()"></i>
        </li>
        <li>Saldo: <input name="saldo" type="text" value="<?php echo htmlspecialchars($resulUd['Saldo']); ?>"></li>
        <li>Correo: <input name="correo" type="email" required value="<?php echo htmlspecialchars($resulUd["Correo"]); ?>"></li>
        <li>Teléfono: <input name="telefono" type="text" value="<?php echo htmlspecialchars($resulUd["Telefono"]); ?>"></li>
        </ul>
        <input type="submit" name="actualizar_usuario" value="Actualizar" class="botones">
    </form>
    </div>

    <!----------------         Formulario de la direccion principal          --------------------->
    <div class="direccion">
    <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="POST" class="actualizar_direccion">
    <h4 class="titulo">Dirección principal</h4>
    
    <?php
    //En el caso de que el usuario se a recien registrado le salga el primer echo
if($resulDird && $resulDird->rowCount() === 0){
    echo '<h3 class="advertencia">No hay una direccion principal</h3>';
}else{ 
    // Campos del form   
    echo '<ul>
            <li>Nombre del remitente: <input name="nombreRemitente" type="text" value="' . $resulDir["NombreRemitente"] . '"></li>
            <li>Apellidos del remitente: <input name="apellidosRemitente" type="text" value="' . $resulDir["ApellidosRemitente"] . '"></li>
            <li>País: <input name="pais" type="text" value="' . $resulDir["Pais"] . '"></li>
            <li>Provincia: <input name="provincia" type="text" value="' . $resulDir["Provincia"] . '"></li>
            <li>Ciudad: <input name="ciudad" type="text" value="' . $resulDir["Ciudad"] . '"></li>
            <li>Código Postal: <input name="cp" type="number" value="' . $resulDir["CP"] . '"></li>
            <li>Calle: <input name="calle" type="text" value="' . $resulDir["Calle"] . '"></li>
            <li>Número: <input name="numero" type="number" value="' . $resulDir["Numero"] . '"></li>
            <li>Piso: <input name="piso" type="text" value="' . $resulDir["Piso"] . '"></li>
        </ul>
        <input type="submit" name="actualizar_direccion" value="Actualizar" class="botones">';
}
    ?>

</form>
</div>

    <!----------------         Lista de direcciones          --------------------->
  <section>
    <div class="direcciones_existentes">
        <h4 class="titulo">Tus direcciones </h4>
        <div class="lista_direcciones">

        <?php 
        echo $direccionesUsuario; 
        ?>

       </div>
    </div>

    <!----------------         Formulario para añadir una nueva dirección          --------------------->
    <div class="añadir_direccion inicio-sesion">

    <button id="mostrarFormulario"><h4>Añadir nueva Dirección</h4></button>
    <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]) ; ?>" method="POST" id="formulario_nueva_direccion">
    <ul>
        <li>Nombre del remitente: <input name="nombreRem_añadir" type="text" value="" placeholder="Ana"></li>
        <li>Apellidos del remitente: <input name="apellidosRem_añadir" type="text" value="" placeholder="Garcia Velazquez"></li>
        <li>País: <input name="pais_añadir" type="text" value="" placeholder="España"></li>
        <li>Provincia: <input name="provincia_añadir" type="text" value="" placeholder="Toledo"></li>
        <li>Ciudad: <input name="ciudad_añadir" type="text" value="" placeholder="Bargas"></li>
        <li>Código Postal: <input name="cp_añadir" type="number" value="" placeholder="44001"></li>
        <li>Calle: <input name="calle_añadir" type="text" value="" placeholder="Progreso"></li>
        <li>Número: <input name="numero_añadir" type="number" value="" placeholder="43"></li>
        <li>Piso: <input name="piso_añadir" type="text" value="" placeholder="2ºB"></li>
    </ul>
    <input type="submit" name="añadir" class="botones" value="Añadir">
    </form>

    </div> 

    </section>    
</main>
</body>
</html>

    <!--------------------------                           JAVASCRIPT                            --------------------------------->
<script>
    //VISUALIZACION DE LA CLAVE
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

    //VISUALIZACION FORMULARIO DE AÑADIR DIRECCION 
    var boton = document.getElementById("mostrarFormulario");
    var formulario = document.getElementById("formulario_nueva_direccion");
    var formularioVisible = false; // Estado inicial del form

    boton.addEventListener("click", function() {
        if (formularioVisible) {
            // Ocultar el formulario
            formulario.style.display = "none";
            boton.style.backgroundColor = "rgb(243, 180, 45)";
            formularioVisible = false;
        } else {
            // Mostrar el formulario
            formulario.style.display = "block";
            boton.style.backgroundColor = "rgb(255, 153, 0)";
            formularioVisible = true;
        }
    });
</script>
