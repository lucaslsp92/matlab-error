function [] = writecsv(folder,filename,T)
    dataname = strcat(filename,'.csv');
    U = T;
    C = strsplit(folder,'\');
    [~,n] = size(C);
    D = C{1,1};
    for i=2:n-1
        D = fullfile(D,C{1,i});
    end
    D = fullfile(D,'csv',dataname);
    [m,~] = size(U);
    col = 1;
    tcol = 0;
    max = 0;
    for i=1:m
        [p,q] = size(U{i,1});
        tcol = tcol + q;
        if (max<p)
            max = p;
        end
    end
    A = zeros(max,tcol);
    for i=1:m
        [p,o] = size(U{i,1});
        if (p<max)
            for k=p+1:max
                U{i,1}(k,1) = 0;
                U{i,1}(k,2) = 0;
            end
        end
        for j=1:o
            A(:,col) = U{i,1}(:,j);
            col = col + 1;
        end
    end
    writematrix(A,D);
end