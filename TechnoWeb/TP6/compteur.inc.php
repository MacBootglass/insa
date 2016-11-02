<?php
  function compteur($nomdufichier){
    $fichier = fopen($nomdufichier, 'c+');
    flock($fichier, LOCK_EX);
    $compteur = fgets($fichier, 100);
    if(empty($compteur))
      $compteur = 0;
    else
      settype($compteur, "integer");
    $compteur++;
    fseek($fichier, 0);
    fputs($fichier, $compteur);
    flock($fichier, LOCK_UN);
    fclose($fichier);
    return $compteur;
  }
?>
