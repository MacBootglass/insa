#!/bin/bash

if [ $# -ge 1 ]
then
  if [ -e $1 ]
  then
    echo "Fichier :$1"
    if [ -r $1 ]
    then
      echo "Vous avez les droits de lecture"
    fi

    if [ -x $1 ]
    then
      echo "Vous avez les droits d'execution"
    fi

    if [ -w $1 ]
    then
      echo "Vous avez les droits d'ecriture"
    fi
  else
    echo "Fichier inexistant :$1"
  fi
else
  echo "Usage : $0 suivit d'un parametre"
fi
