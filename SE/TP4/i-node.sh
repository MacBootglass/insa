#!/bin/bash

if [ $# -ge 1 ]
then
  if [ -e $1 ]
  then
    echo "I-node du fichier $1 :"$(ls -i | grep 'comptes' | cut -d" " -f1)
  else
    echo "Fichier inexistant :$1"
  fi
else
  echo "Usage : $0 suivit d'un parametre"
fi
