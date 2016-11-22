function NouvelleImage= merge(Image1,Image2,up)
     if up 
       NouvelleImage = [Image1; Image2];
     else
       NouvelleImage = [Image1, Image2];
     end
end

