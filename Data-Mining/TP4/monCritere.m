function J = monCritere( theta )
  J = (1 - theta(1))^2 + 100 * (theta(2) - theta(1)^2)^2;
end

