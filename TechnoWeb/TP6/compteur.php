<?php require('compteur.inc.php'); ?>
<!DOCTYPEhtml>
  <html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8"/>
    <title>Compteurs</title>
  </head>
    <body>
      <p>Compteur de hits: <?php echo compteur('/tmp/compteur.txt'); ?></p>
  </body>
</html>
