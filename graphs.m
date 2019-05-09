clearvars;
folder = 'C:\Users\lucas\OneDrive\Mestrado\Pesquisas\Turbulence_model\Couette_Flow\calib\matlab';
filename = 'temperror_cf2D_Re01300_Lxh64_t30_Cfflow_wtturb';

%% input data
input = strcat('input_',filename,'.txt');
full_filename_input = fullfile(folder,input);
[txt,num] = readinput(full_filename_input);

%% call calcmed.m
T = calcmed(txt,num);

%% save data
writecsv(folder,filename,T);

%% input graph data
output = strcat('output_',filename,'.txt');
full_filename_output = fullfile(folder,output);
[dtxt,dnum,leg] = readoutput(full_filename_output);

%% call plotgraph.m
graphplot(T,dtxt,dnum,leg);
