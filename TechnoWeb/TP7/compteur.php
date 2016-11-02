<?php
  require_once('compteur.inc.php');
  session_start();

  if (isset($_GET["deconnexion"])) {
    if (isset($SESSION_['userID'])) {
      unset($SESSION_['userID']);
    }
    session_destroy();
  }
?>

<!DOCTYPEhtml>
  <html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8"/>
    <title>Compteurs</title>
  </head>
    <body>
      <p>Compteur de hits: <?php echo compteur('/tmp/compteur.txt'); ?></p>
      <p>Compteur de nouvelles sessions: <?php echo compteurSession('/tmp/compteurSession.txt'); ?></p>
      <a href="compteur.php?deconnexion=true">Réinitialiser la connexion<a/>
  </body>
</html>
