<?php
  header('Content-Type: text/html; charset=UTF-8') ;
  setlocale(LC_TIME ,"fr_FR.utf8");
  require_once('livredor.inc.php');

  initDB();
?>

<!DOCTYPE html>
<html>
  <head>
    <title> Forum ASI </title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <link href="style.css" rel="stylesheet" type="text/css"/>
  </head>

  <body>
    <header id="top">
      <img id="logo" src="Images/logo -asi.png" alt="ASI" width="125" height="58"/>
      <h1> Forum ASI </h1>
    </header>

    <p id="probleme"> </p>
    <form name="formulaire" action="livredor.php" method="post">
      <fieldset>
        <legend> Coordonnées : </legend>
        <label for="name">Nom : </label>
          <input placeholder="Saisissez votre nom" id="name" name="name" type="text" size="30"/>
        <label for="email">E- mail : </label>
          <input placeholder="Saisissez votre email" id="email" name="email" type="text" size="30"/>
      </fieldset>
      <fieldset>
        <legend> Message : </legend>
        <textarea rows="4" cols="50" id="message" name="message"> </textarea>
      </fieldset>
      <input type="button" value="Poster le message" onclick="Javascript:verification();"/>
      <input type="button" value="Effacer" onclick="Javascript:nettoyage();"/>
    </form>

    <?php // enregistrement du message si submit
      if ( isset($_POST) && ! empty($_POST['name'])) {
        $message = construireMessage ( $_POST['name']."(". $_POST['email'].")", $_POST['message']);
        ecrireMessage ('./livredor.dat', $message );
      }
    ?>

    <h1> Liste des messages postés </h1>
    <?php // affichage du livre d'or
      foreach( lireMessages('./livredor.dat') as $message ) :
    ?>
      <table>
        <tr>
          <td class="date"> <?php echo htmlentities($message[0]) ?> </td>
          <td class="auteur"> <?php echo htmlentities($message[1]) ?> </td>
        </tr>
        <tr>
          <td colspan="2"><pre> <?php echo htmlentities($message[2]) ?> </pre> </td>
        </tr>
      </table>
    <?php
      endforeach ;
    ?>

    <footer>
      <style type="text/css" scoped>
        object { overflow : auto ; }
      </style>
      <style type="text/css" scoped>
        p#probleme { color : red; }
      </style>

      <script type="text/javascript">
        function verification () {
          var emailBox = document.getElementById("email");
          var probleme = document.getElementById("probleme");
          if( emailBox.value == "") {
            if (! probleme.hasChildNodes()) {
              emailBox.style.outline = "solid red";
              probleme.appendChild(document.createTextNode("Champ obligatoire."));
            }
          } else {
            document.forms ['formulaire'].submit() ;
          }
        }

        function nettoyage () {
          if( confirm ('Etes vous sur ?') ) {
            document.getElementById ("email").style.outline = "initial";
            var probleme = document.getElementById("probleme");
            if (probleme.hasChildNodes()) {
              probleme.removeChild (probleme.childNodes.item(0)) ;
            }
            document.forms['formulaire'].reset();
          }
        }
      </script>
    </footer>
  </body>
</html>
