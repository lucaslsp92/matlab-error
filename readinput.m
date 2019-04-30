function [dtxt,dnum] = readinput(fl)
    fileID = fopen(fl,'r');
    fscanf(fileID,'%s',1);
    nfd = fscanf(fileID,'%f',1);
    fd = cell(nfd,1);
    for i=1:nfd
        fscanf(fileID,'%s',1);
        fd{i,1} = fscanf(fileID,'%s',1);
    end
    fscanf(fileID,'%s',1);
    nft = fscanf(fileID,'%f',1);
    nfn = zeros(nfd,1);
    fn = cell(nft,1);
    aux = 0;
    for i=1:nfd
        fscanf(fileID,'%s',1);
        nfn(i,1) = fscanf(fileID,'%f',1);
        for j=1+aux:nfn(i,1)+aux
            fscanf(fileID,'%s',1);
            fn{j,1} = fscanf(fileID,'%s',1);
        end
        aux = aux + nfn(i,1);
    end
    fscanf(fileID,'%s',1);
    npt = fscanf(fileID,'%f',1);
    pf = zeros(npt,2);
    np = zeros(nfd,2);
    aux = 0;
    for i=1:nfd
        fscanf(fileID,'%s',1);
        np(i,1) = fscanf(fileID,'%f',1);
        fscanf(fileID,'%s',1);
        np(i,2) = fscanf(fileID,'%f',1);
        fscanf(fileID,'%s',1);
        for j=1+aux:(np(i,1)/np(i,2))+aux
            for k=0:np(i,2)-1
                if (k==0)
                    pf(j,1) = i;
                    pf(j,2) = fscanf(fileID,'%f',1);
                else
                    pf(j+k,1) = pf(j,1);
                    pf(j+k,2) = pf(j,2);
                end
            end
        end
        aux = aux + np(i,1);
    end
    lin = zeros(nfd,1);
    col = zeros(nfd,2);
    del = cell(nfd,1);
    scl = zeros(nfd,1);
    nfr = zeros(nfd,1);
    aux = 0;
    for i=1:nfd
        fscanf(fileID,'%s',1);
        del{i+aux,1} = fscanf(fileID,'%s',1);
        fscanf(fileID,'%s',1);
        lin(i+aux,1) = fscanf(fileID,'%f',1);
        fscanf(fileID,'%s',1);
        col(i+aux,1) = fscanf(fileID,'%f',1);
        fscanf(fileID,'%s',1);
        for j=0:np(i,2)-1
            if (j==0)
                col(i+aux,2) = fscanf(fileID,'%f',1);
            else
                del{i+aux+j,1} = del{i+aux,1};
                lin(i+aux+j,1) = lin(i+aux,1);
                col(i+aux+j,1) = col(i+aux,1);
                col(i+aux+j,2) = fscanf(fileID,'%f',1);
            end
        end
        fscanf(fileID,'%s',1);
        for j=0:np(i,2)-1
            if (j==0)
                scl(i+aux,1) = fscanf(fileID,'%f',1);
            else
                scl(i+aux+j,1) = scl(i+aux,1);
            end
        end
        fscanf(fileID,'%s',1);
        for j=0:np(i,2)-1
            if (j==0)
                nfr(i+aux,1) = fscanf(fileID,'%f',1);
            else
                nfr(i+aux+j,1) = nfr(i+aux,1);
            end
        end
        aux = aux + np(i,2) - 1;
    end
    dtxt = cell(npt,2);
    dnum = zeros(npt,5);
    for i=1:npt
        p = char(fd{pf(i,1),1});
        n = char(fn{pf(i,2),1});
        full_filename = fullfile(p,n);
        dtxt{i,1} = full_filename;
        dtxt{i,2} = del{i,1};
        dnum(i,1) = col(i,1);
        dnum(i,2) = col(i,2);
        dnum(i,3) = lin(i,1);
        dnum(i,4) = scl(i,1);
        dnum(i,5) = nfr(i,1);
    end
    fclose(fileID);
end