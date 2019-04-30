function [c] = colorscl(cl,A,nc)
    [m,~] = size(A);
    if (cl == "parula")
        c = parula(m+1-nc);
    elseif (cl == "jet")
        c = jet(m-nc);
    elseif (cl == "hsv")
        c = hsv(m-nc);
    elseif (cl == "gray")
        c = gray(m+1-nc);
    end
end