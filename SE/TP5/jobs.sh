#!/bin/bash
echo -e "Utilisateur: $(whoami) \t Terminal: $(tty)"
echo "Vous avez $(jobs | wc -l) jobs en cours dont :"
echo -e "\t- $(jobs | grep "Arrêté" | wc -l) endormis"
echo -e "\t- $(jobs | grep "En cours" | wc -l) en cours d'execution"
