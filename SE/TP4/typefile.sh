#!/bin/bash
echo 'Repertoire courant = '$(pwd)

repertoire=""
caractere=""
bloc=""
tube=""
lien=""
socket=""
ordinaire=""
nontrie=""

for i in $("ls")
do
  if [ -d "$i" ]
    then
	   repertoire=$repertoire"\t"$i" est un repertoire\n"
     nontrie=$nontrie"\t"$i" est un repertoire\n"
  elif [ -c "$i" ]
    then
	  caractere=$caractere"\t"$i" est un fichier accede en mode caractere\n"
    nontrie=$nontrie"\t"$i" est un fichier accede en mode caractere\n"
  elif [ -b "$i" ]
    then
	   bloc=$bloc"\t"$i" est un fichier accede en mode bloc\n"
     nontrie=$nontrie"\t"$i" est un fichier accede en mode bloc\n"
  elif [ -p "$i" ]
    then
	   tube=$tube"\t"$i" est un fichier tube\n"
     nontrie=$nontrie"\t"$i" est un fichier tube\n"
  elif [ -L "$i" ]
    then
	   lien=$lien"\t"$i" est un fichier lien symbolique\n"
     nontrie=$nontrie"\t"$i" est un fichier lien symbolique\n"
  elif [ -S "$i" ]
    then
	   socket=$socket"\t"$i" est un fichier socket\n"
     nontrie=$nontrie"\t"$i" est un fichier socket\n"
  elif [ -f "$i" ]
    then
     ordinaire=$ordinaire"\t"$i" est un fichier ordinaire\n"
     nontrie=$nontrie"\t"$i" est un fichier ordinaire\n"
  fi
done

if [ $# -eq 1 -a $1 = "-sort" ]
  then
    echo -e $repertoire$caractere$bloc$tube$lien$socket$ordinaire
    echo -e "fin en mode tri par type\n\n"
fi
echo -e $nontrie
echo "fin en mode tri alphabetique"
