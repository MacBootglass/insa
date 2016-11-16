<?php
  header('Content-Type: text/html; charset=UTF-8');
  setlocale(LC_TIME, "fr_FR.utf8");
    try {
        include("classes/db.class.php");
        include("classes/message.class.php");
        include("classes/message.db.class.php");
        if (!file_exists("messages.sqlite")) {
            include('init.php');
        } else {
            db::Connect('sqlite:messages.sqlite');
        }

        if (!empty($_POST)) {
            // Insertion du nouveau
            try {
                $m= new Message();
                $m->setUrl($_POST['url']);
                $m->setEmail($_POST['email']);
                $m->setTexte($_POST['texte']);
                MessageDb::Create($m);
            } catch (Exception $e) {
                // gestion des erreurs
                $err = $e->getMessage();
            }
        }
?>
<html>
  <head></head>
  <body>
    <h1>News</h1>
<?php
if (!empty($err)) {
       echo "<p>Une erreur est survenu : ".$err."</p>";
}
?>
<table>
    <tr><th>Date</th><th>Titre</th><th></th></tr>
<?php
        $listedesmessages = MessageDb::ListMessage();
        foreach ($listedesmessages as $m) {
            echo "<tr><td>".$m->getDate().'</td><td>'.$m->getTexte()."</td><td><a href='iframe.php?id=".$m->getId()."'>Découvrir</a></td></tr>\n";
        }
    } catch (Exception $e) {
        echo $e->getMessage();
    }
?>
</table>
<h2>Ajouter un site</h2>
    <form method="POST" action="">
        URL : <input type="text" name="url"/><br/>
        Email : <input type="text" name="email"/><br/>
        Descriptif : <textarea name="texte"/></textarea><br/>
        <input type="submit" value="Ajouter">
    </form>
</body>
</html>
