if [ ${PWD##*/} != "Rapport2" ]; then
  echo "Repertoire invalide"
  exit 1
fi

if [ ! -d "images" ]; then
  mkdir images
fi

if [ ! -f "images/schemaBO.png" ]; then
  wget http://i.imgur.com/d5Z1ID5.png -O images/schemaBO.png
fi

if [ ! -f "images/schemaBF.png" ]; then
  wget http://i.imgur.com/lsnQCzr.png -O images/schemaBF.png
fi

if [ ! -f "images/releveBO.png" ]; then
  wget http://i.imgur.com/gRaLVHf.png -O images/releveBO.png
fi

if [ ! -f "images/releveBF.png" ]; then
  wget http://i.imgur.com/MGKJIKs.png -O images/releveBF.png
fi

if [ ! -f "images/diagrammePhaseBO.png" ]; then
  wget http://i.imgur.com/8QmeErF.png -O images/diagrammePhaseBO.png
fi

if [ ! -f "images/diagrammePhaseBF.png" ]; then
  wget http://i.imgur.com/QkXlHNJ.png -O images/diagrammePhaseBF.png
fi

if [ ! -f "images/diagrammeGainBO.png" ]; then
  wget http://i.imgur.com/kEzECMz.png -O images/diagrammeGainBO.png
fi

if [ ! -f "images/diagrammeGainBF.png" ]; then
  wget http://i.imgur.com/Jk1A6xe.png -O images/diagrammeGainBF.png
fi

pdflatex Rapport.tex
pdflatex Rapport.tex
