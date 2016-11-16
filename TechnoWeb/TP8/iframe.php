<?php
  header('Content-Type: text/html; charset=UTF-8');
  setlocale(LC_TIME, "fr_FR.utf8");
    include("classes/db.class.php");
    include("classes/message.class.php");
    include("classes/message.db.class.php");
    db::Connect('sqlite:messages.sqlite');
    $message = MessageDb::Read((int)$_GET['id']);
?>
<html>
<head>
    <style>
        iframe {
          border:0;
          margin:0;
          padding:0;
          width:100%;
          height:100%;
        }
    </style>
</head>
<body>
<div><h1><?php echo $message->getTexte(); ?></h1>
<a href="index.php">Retour à la liste</a></div>
<iframe src="<?php echo $message->getUrl(); ?>"></iframe>

</body>
</html>
