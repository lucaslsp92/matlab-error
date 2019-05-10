function [A] = calcmed(dtxt,dnum)
    [m,~] = size(dtxt);
    A = cell(m,1);
    B = cell(1,1);
    for i=1:m
        if (i==1)
            full_filename = char(dtxt{i,1});
            if (strcmp(char(dtxt{i,2}),'space'))
                M = dlmread(full_filename,'',dnum(i,3),0);
            elseif (strcmp(char(dtxt{i,2}),'comma'))
                M = dlmread(full_filename,',',dnum(i,3),0);
            end
            A{i,1}(:,1) = M(:,dnum(i,1));
            A{i,1}(:,2) = M(:,dnum(i,2))*dnum(i,4);
        else
            for j=dnum(i,5)-1:dnum(i,5)-1
                B = strsplit(dtxt{i,1},'.');
                full_filename = strcat(string(B{1,1}),'.',num2str(j),'.',string(B{1,2}));
                if (strcmp(char(dtxt{i,2}),'space'))
                    M = dlmread(full_filename,'',dnum(i,3),0);
                elseif (strcmp(char(dtxt{i,2}),'comma'))
                    M = dlmread(full_filename,',',dnum(i,3),0);
                end
                [n,~] = size(M);
                C = cell(20,1);
                nfx = ones(20,1);
                for k=1:n
                    ys = M(k,dnum(i,2))/0.05-1;   % coordenada admensionalizada y/h
                    yp = M(k,dnum(i,1));
                    us = M(k,dnum(i,1))/0.5;    % velocidade admensionalizada u/uw
                    fx = floor(((ys+1)*10)+1);
                    C{fx,1}(nfx(fx,1),1) = ys;
                    C{fx,1}(nfx(fx,1),2) = us;
                    nfx(fx,1) = nfx(fx,1) + 1;
                end
                for l=1:20
                    A{i,1}(l,1) = ((l-1)/10)-0.95;
                    A{i,1}(l,2) = mean(C{l,1}(:,2));
                    A{i,1}(l,3) = std(C{l,1}(:,2));
                end
            end
%         end
    end
end