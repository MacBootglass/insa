<?php
  function lireMessages($nomfichier):array {
    $fichier = fopen($nomfichier, "r");
    $messages = array();
    while($messagecode = fgets($fichier))
      $messages[] = decodeMessage($messagecode);
    return $messages;
  }

    function ecrireMessage($nomfichier, $message) {
      $fichier = fopen($nomfichier, "a");
      flock($fichier, LOCK_EX);
      fputs($fichier, encodeMessage($message)."\n");
      flock($fichier, LOCK_UN);
      fclose($fichier);
    }

    function construireMessage($auteur, $texte):array {
      return array(strftime("%A %d %B %Y %T", (int)time()), $auteur, $texte);
    }

    function encodeMessage($message):string {
      return str_replace("|", "{pp}", str_replace("\r", "{cr}", str_replace("\n", "{nl}", $message[0])))
              ."|".str_replace("|", "{pp}", str_replace("\r", "{cr}", str_replace("\n", "{nl}", $message[1])))
              ."|".str_replace("|", "{pp}", str_replace("\r", "{cr}", str_replace("\n", "{nl}", $message[2])));
    }

    function decodeMessage($messagecode):array {
      list($date, $auteur, $texte) = explode("|", $messagecode);
      return array( str_replace("{nl}", "\n", str_replace("{cr}", "\r", str_replace("{pp}", "|", $date))),
                    str_replace("{nl}", "\n", str_replace("{cr}", "\r", str_replace("{pp}", "|", $auteur))),
                    str_replace("{nl}", "\n", str_replace("{cr}", "\r", str_replace("{pp}", "|", $texte)))
                  );
      }
?>
