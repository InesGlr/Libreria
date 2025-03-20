    <!--------------------------                           PHP                            --------------------------------->
<?php
    session_start(); /* Nos unimos a la sesion iniciada */
    $_SESSION = array();
    session_destroy();
    setcookie(session_name(), 123, time()-1000); 
    header("Location: login.php"); /* Redirigimos al fichero 'login.php' */
?>
