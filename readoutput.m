function [dtxt,dnum,leg] = readoutput(fl)
    fileID = fopen(fl,'r');
    fscanf(fileID,'%s',1);
    fd = fscanf(fileID,'%s',1);
    fscanf(fileID,'%s',1);
    fn = fscanf(fileID,'%s',1);
    full_filename = fullfile(fd,fn);
    dtxt{1,1} = full_filename;
    fscanf(fileID,'%s',4);
    bkt = 2*fscanf(fileID,'%f',1);
    bkx = 2*fscanf(fileID,'%f',1);
    bky = 2*fscanf(fileID,'%f',1);
    bkf = 2*fscanf(fileID,'%f',1);
    fscanf(fileID,'%s',1);
    aux = fscanf(fileID,'%s',1);
    if (aux == '-')
        dtxt{2,1} = [];
    else
        b = fscanf(fileID,'%c%s',bkt);
        dtxt{2,1} = strcat(aux,b);
    end
    fscanf(fileID,'%s',1);
    a = fscanf(fileID,'%s',1);
    b = fscanf(fileID,'%c%s',bkx);
    dtxt{3,1} = strcat(a,b);
    fscanf(fileID,'%s',1);
    a = fscanf(fileID,'%s',1);
    b = fscanf(fileID,'%c%s',bky);
    dtxt{4,1} = strcat(a,b);
    fscanf(fileID,'%s',15);
    dnum = zeros(15,1);
    for i=1:15
        dnum(i,1) = fscanf(fileID,'%f',1);
    end
    fscanf(fileID,'%s',10);
    for i=1:10
        if (i==4)
            a = fscanf(fileID,'%s',1);
            b = fscanf(fileID,'%c%s',bkf);
            dtxt{i+4,1} = strcat(a,b);
        else
            dtxt{i+4,1} = fscanf(fileID,'%s',1);
        end
    end
    fscanf(fileID,'%s',1);
    m = fscanf(fileID,'%f',1);
    fscanf(fileID,'%s',18);
    % fscanf(fileID,'%f',1);
    leg = cell(m,13);
    dnum(16,1) = 0;
    for i=1:m
        n = fscanf(fileID,'%f',1);
        if (n==0)
            leg{i,1} = fscanf(fileID,'%s',1);
        else
            a = fscanf(fileID,'%s',1);
            b = fscanf(fileID,'%c%s',n*2);
            leg{i,1} = strcat(a,b);
        end
        leg{i,2} = fscanf(fileID,'%s',1);
        leg{i,3} = fscanf(fileID,'%f',1);
        j = fscanf(fileID,'%f',1);
        if (j==1)
            leg{i,4} = fscanf(fileID,'%f',1);
            leg{i,5} = fscanf(fileID,'%f',1);
            leg{i,6} = fscanf(fileID,'%f',1);
            dnum(16,1) = dnum(16,1) + 1;
        end
        leg{i,7} = fscanf(fileID,'%f',1);
        leg{i,8} = fscanf(fileID,'%f',1);
        leg{i,9} = fscanf(fileID,'%f',1);
        leg{i,10} = fscanf(fileID,'%f',1);
        leg{i,11} = fscanf(fileID,'%f',1);
        leg{i,12} = fscanf(fileID,'%f',1);
        leg{i,13} = fscanf(fileID,'%f',1);
    end
    fclose(fileID);
end