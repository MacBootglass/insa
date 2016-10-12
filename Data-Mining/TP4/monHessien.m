function H = monHessien(theta)
  H = [2-400*theta(2)+1200*theta(1)^2, -400*theta(1); -400*theta(1), 200];
end

