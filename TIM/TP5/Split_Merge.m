function NouvelleImage= Split_Merge(Image,Seuil, SeuilCorrespondant)
   
      [A,B,C,D] = split(Image);
      varianceA= var(A(:));
      varianceB= var(B(:));
      varianceC= var(C(:));
      varianceD= var(D(:));
      splitA = false;
      splitB = false;
      splitC = false;
      splitD = false;
    
     if varianceA >= Seuil 
       Split_Merge(A,Seuil, SeuilCorrespondant);
       splitA = true;
     end
     
     if varianceB >= Seuil
       Split_Merge(B,Seuil, SeuilCorrespondant);
       splitB = true;
     end
     
     if varianceC >= Seuil 
       Split_Merge(C,Seuil, SeuilCorrespondant);
       splitC = true;
     end
     
     if varianceD >= Seuil 
       Split_Merge(D,Seuil, SeuilCorrespondant);
       splitD = true;
     end
     
     A1 = A;
     B1 = B;
     C1 = C;
     D1 = D;
     
     
     if abs(varianceA - varianceB) < SeuilCorrespondant && ~splitA && ~splitB
       A1 = ones(size(A))*0;
       B1 = ones(size(B))*0;
     end
     
     if abs(varianceA - varianceC) < SeuilCorrespondant && ~splitA && ~splitC
       A1 = ones(size(A))*0;
       C1 = ones(size(C))*0;
     end
     
     if abs(varianceD - varianceB) < SeuilCorrespondant && ~splitD && ~splitB
       D1 = ones(size(D))*0;
       B1 = ones(size(B))*0;
     end
     
     if abs(varianceD - varianceC) < SeuilCorrespondant && ~splitD && ~splitC
       D1 = ones(size(D))*0;
       C1 = ones(size(C))*0;
     end
     
     
     
     NouvelleImage = [A1, B1; C1, D1];
%      disp(max(max(NouvelleImage)));


end

