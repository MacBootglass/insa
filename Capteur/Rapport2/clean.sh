if [ ${PWD##*/} != "Rapport2" ]; then
  echo "Repertoire invalide"
  exit 1
fi

rm -rf images
rm *.aux
rm *.log
rm *.pdf
rm *.toc
