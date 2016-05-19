function [ xnew, ynew ] = intersectionTroisCercles(xB1, xB2, xB3, yB1, yB2, yB3, distanceBalise1, distanceBalise2, distanceBalise3)
    a1 = 2*(xB2-xB1);
    a2 = 2*(xB3-xB2);
    b1 = 2*(yB2-yB1);
    b2 = 2*(yB3-yB2) ;
    c1 = (xB1^2-xB2^2)+(yB1^2-yB2^2)-distanceBalise1^2+distanceBalise2^2;
    c2 = (xB2^2-xB3^2)+(yB2^2-yB3^2)-distanceBalise2^2+distanceBalise3^2;
    ynew = (a2*c1-a1*c2)/(a1*b2-a2*b1);
    xnew = (-c1-b1*ynew)/a1;
end

