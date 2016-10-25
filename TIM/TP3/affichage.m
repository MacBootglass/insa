function affichage( originale, bruite, debruite, finale, gray, filtre)
  figure();
  subplot(2,2,1);
  imagesc(originale);
  title('Image originale');
  
  subplot(2,2,2);
  imagesc(bruite);
  title('Image bruitée');
  
  subplot(2,2,3);
  imagesc(debruite);
  title('Image debruitée');
  
  subplot(2,2,4);
  imagesc(finale);
  title(strcat('Image avec filtre', {' '}, filtre));
  colormap(gray);
end

