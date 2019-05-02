function [] = writecsv(folder,filename,T)
    dataname = strcat(filename,'.csv');
    C = strsplit(folder,'\');
    [~,n] = size(C);
    D = C{1,1};
    for i=2:n-1
        D = fullfile(D,C{1,i});
    end
    D = fullfile(D,'csv',dataname);
    [m,~] = size(T);
    col = 1;
    for i=1:m
        [~,o] = size(T{i,1});
        for j=1:o
            A(:,col) = T{i,1}(:,j);
            col = col + 1;
        end
    end
    writematrix(A,D);
end