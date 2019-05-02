clearvars;
folder = 'C:\Users\lucas_pereira\OneDrive\Mestrado\Pesquisas\Turbulence_model\Couette_Flow\calib\matlab';
filename = 'cf2D_Re01300_Lxh64_2hl0010_t30_CcAlp1e-08_wtturb';

%% input data
input = strcat('input_',filename,'.txt');
full_filename_input = fullfile(folder,input);
[txt,num] = readinput(full_filename_input);

%% call readtxt.m
T = calcerror(txt,num);

%% save data
writecsv(folder,filename,T);

%% input graph data
output = strcat('output_',filename,'.txt');
full_filename_output = fullfile(folder,output);
[dtxt,dnum,leg] = readoutput(full_filename_output);

%% call plotgraph.m
graphplot(T,dtxt,dnum,leg);
