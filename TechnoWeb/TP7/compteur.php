<?php
  require_once('compteur.inc.php');
  session_start();
?>

<!DOCTYPE html>
  <html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8"/>
    <title>Compteurs</title>
  </head>
    <body>
      <p>Compteur de hits: <?php echo compteur('/tmp/compteur.txt'); ?></p>
      <p>Compteur de nouvelles sessions: <?php echo compteurSession('/tmp/compteurSession.txt'); ?></p>
      <a href="deconnexion.php">Réinitialiser la connexion<a/>
  </body>
</html>
