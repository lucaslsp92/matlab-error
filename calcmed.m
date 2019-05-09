function [A] = calcmed(dtxt,dnum)
    [m,~] = size(dtxt);
    A = cell(m-1,1);
    B = cell(1,1);
    ref = cell(1,1);
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
                nf = 20;
                C = [];
                C = cell(20,1);
                nfx = ones(20,1);
                for k=1:n
                    ys = M(k,dnum(i,2))/0.05-1;   % coordenada admensionalizada y/h
%                     yp = M(k,dnum(i,1));
                    us = M(k,dnum(i,1))/0.5;    % velocidade admensionalizada u/uw
                    fx = floor(((ys+1)*10)+1);
                    C{fx,1}(nfx(fx,1),1) = ys;
                    C{fx,1}(nfx(fx,1),2) = us;
                    nfx(fx,1) = nfx(fx,1) + 1;
                end
                for l=1:20
                    yh = ((l-1)/10)-0.95;
                    for w=1:o
                        if (yh < ref{1,1}(w,2))
                            uref = (((yh-ref{1,1}(w-1,2))/((ref{1,1}(w,2)-ref{1,1}(w-1,2))))*(ref{1,1}(w,1)-ref{1,1}(w-1,1)))+ref{1,1}(w-1,1);
                            break
                        end
                    end
                    if(isempty(C{l,1}))
                        nf = nf-1;
                    else
                        u = mean(C{l,1}(:,2));
                        e = e + abs(u-uref)/uref;
                    end
                end
                e = e/nf;
                A{i-1,1}(j+1,1) = j*0.1;            % cada csv corresponde a um print step
                A{i-1,1}(j+1,2) = 100*e;
                D = strsplit(dtxt{i,1},'\');
                [~,w] = size(D);
                E = strsplit(D{1,w},'.');
                F = strcat(string(E{1,1}),'.',num2str(j),'.',string(E{1,2}));
                fprintf('%s\r',string(F));
            end
        end
    end
end