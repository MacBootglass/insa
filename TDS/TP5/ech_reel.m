function [xe_reel] = ech_reel(Te,deltaT)

    nb_pts = 10 ;
    f0 = 5 ;
    t1 = -2 ;
    t2 = 2 ;

    for j =1:1:(1+(t2-t1)/Te)
        t_reel = t1+(j-1)*Te:deltaT/nb_pts:t1+(j-1)*Te+deltaT;
        x_reel = sin(pi*f0*t_reel)./(pi*t_reel) ;
        x_reel(abs(t_reel)<10^(-10)) = f0 ;
        xe_reel(j) = trapz(t_reel,x_reel);
    end
    
    xe_reel = xe_reel/deltaT;

end