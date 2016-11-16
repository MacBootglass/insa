<?php
    db::Connect('sqlite:messages.sqlite');
    messageDb::CreateTable();
    messageDb::LoadSample();
?>
<html>
  <head></head>
  <body>
    <h1>Base initialisée</h1>
  </body>
</html>
