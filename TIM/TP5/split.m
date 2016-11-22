function [A,B,C,D] = split(Image)
      
      [n,p]=size(Image);
      
      
    if n>=2 && p>=2        
       A=Image(1:n/2,1:p/2);
       C=Image(n/2+1:n,1:p/2);
       B=Image(1:n/2,p/2+1:p);
       D=Image(n/2+1:n,p/2+1:p);
    end


end

