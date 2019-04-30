function [A] = readxls(dtxt,dnum)
    [m,~] = size(dtxt);
    A = cell(m,1);
    for i=1:m
        full_filename = char(dtxt{i,1});
        if (strcmp(char(dtxt{i,2}),'space'))
            M = dlmread(full_filename,'',dnum(i,3),0);
        elseif (strcmp(char(dtxt{i,2}),'comma'))
            M = dlmread(full_filename,',',dnum(i,3),0);
        end
        A{i,1}(:,1) = M(:,dnum(i,1));
        A{i,1}(:,2) = M(:,dnum(i,2))*dnum(i,4);
    end
end