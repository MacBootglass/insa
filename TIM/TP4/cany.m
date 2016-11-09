function m = cany( mTheta, mG )
  count = 0;
  [x, y] = size(mG);
  m = mG;
  for i=2:x-1
    for j=2:y-1
      switch mTheta(i,j)
        case {0, 180}
          if mG(i, j-1) > mG(i, j) || mG(i, j+1) > mG(i, j)
            m(i,j) = 0;
            count = count + 1;
          end
        case {45, 225}
          if mG(i-1, j+1) > mG(i, j) || mG(i+1, j-1) > mG(i, j)
            m(i,j) = 0;
            count = count + 1;
          end
        case {90, 270}
          if mG(i-1, j) > mG(i, j) || mG(i+1, j) > mG(i, j)
            m(i,j) = 0;
            count = count + 1;
          end
        case {135, 315}
          if mG(i-1, j-1) > mG(i, j)||  mG(i+1, j+1) > mG(i, j)
            m(i,j) = 0;
            count = count + 1;
          end
      end
    end
  end
  disp(count);
end

