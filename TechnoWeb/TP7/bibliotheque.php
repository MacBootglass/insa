<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Bibliographie</title>
  </head>
  <body>
    <form action="bibliotheque.php" method="post">
      <fieldset>
        <legend>Date</legend>
        <input type="date" name="date">
        <input type="submit" name="submit" value="Envoyer">
      </fieldset>
    </form>
    <ul>
      <?php
        if (isset($_POST['date'])) {
          $xml = simplexml_load_file("bibliographie.xml");
          foreach ($xml->publication as $livre) {
            if (strcmp($livre->annee, substr($_POST['date'], 0, 4)) == 0)
              echo "<li>".$livre->titre."</li>";
          }
        }
      ?>
    </ul>
  </body>
</html>
