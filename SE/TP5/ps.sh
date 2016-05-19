#!/bin/bash
if [ $# -ge 1 ]
then
  for i in $(ps -o state -o cmd -u $1 | cut -d" " -f1,2)
  do
    case $i in
      "D")
        echo -e "\t\t\t\t\t\t :sommeil non interuptible"
      ;;
      "R")
        echo -e "\t\t\t\t\t\t :en cours d execution"
      ;;
      "S")
        echo -e "\t\t\t\t\t\t :sommeil interuptible"
      ;;
      "T")
        echo -e "\t\t\t\t\t\t :arrete"
      ;;
      "W")
        echo -e "\t\t\t\t\t\t :pagine"
      ;;
      "X")
        echo -e "\t\t\t\t\t\t :tue"
      ;;
      "Z")
        echo -e "\t\t\t\t\t\t :zombi"
      ;;
      *)
        echo "$i"
      ;;
    esac
  done
else
  echo "Usage : $0 suivit du nom d un utilisateur"
fi
