function [A] = calcerror(dtxt,dnum)
    [m,~] = size(dtxt);
    A = cell(m-1,1);
    ref = cell(1,1);
    B = cell(1,1);
    for i=1:m
        if (i==1)
            full_filename = char(dtxt{i,1});
            if (strcmp(char(dtxt{i,2}),'space'))
                M = dlmread(full_filename,'',dnum(i,3),0);
            elseif (strcmp(char(dtxt{i,2}),'comma'))
                M = dlmread(full_filename,',',dnum(i,3),0);
            end
            ref{i,1}(:,1) = M(:,dnum(i,1));
            ref{i,1}(:,2) = M(:,dnum(i,2))*dnum(i,4);
        else
            for j=0:dnum(i,5)-1
                B = strsplit(dtxt{i,1},'.');
                full_filename = strcat(string(B{1,1}),'.',num2str(j),'.',string(B{1,2}));
                if (strcmp(char(dtxt{i,2}),'space'))
                    M = dlmread(full_filename,'',dnum(i,3),0);
                elseif (strcmp(char(dtxt{i,2}),'comma'))
                    M = dlmread(full_filename,',',dnum(i,3),0);
                end
                [n,~] = size(M);
                [o,~] = size(ref{1,1});
                e = 0;
                for k=1:n
                    ys = M(k,dnum(i,2))/0.05;   % coordenada admensionalizada y/h
                    us = M(k,dnum(i,1))/0.5;    % velocidade admensionalizada u/uw
                    for l=1:o
                        if (ys < ref{1,1}(l,2))
                            uref = (((ys-ref{1,1}(l-1,2))/((ref{1,1}(l,2)-ref{1,1}(l-1,2))))*(ref{1,1}(l,1)-ref{1,1}(l-1,1)))+ref{1,1}(l-1,1);
                            break
                        end
                    end
                    e = e + abs(us-uref)/uref;
                end
                e = e/n;
                A{i-1,1}(j+1,1) = j*0.1;            % cada csv corresponde a um print step
                A{i-1,1}(j+1,2) = 100*e;
                C = strsplit(dtxt{i,1},'\');
                D = strsplit(C{1,12},'.');
                E = strcat(string(D{1,1}),'.',num2str(j),'.',string(D{1,2}));
                fprintf('%s\r',string(E));
            end
        end
    end
end