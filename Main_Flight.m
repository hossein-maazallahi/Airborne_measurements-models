clc
clear all
close all

Plume_Area = [];
TracerArea = [];
Rows = [1 2 3 4 6 7 8 9 10 11];
SA_RC = read_StartEnds;

%% Not required to be repeated for the calculaiton
for i=1:10
 
Row = Rows(i); % Row represents each day's of flight measurements

% Row = 5 should be excluded as it is for the region 11;
%% Reading measurements and model outputs

[SA_File, EMPA_File, DLR_File]=read_Directories(Row);
    SA    = read_SA(strcat("../",SA_File));
    EMPA  = read_EMPA(strcat("../",EMPA_File),SA);
    DLR   = read_DLR(strcat("../",DLR_File),SA,Row); 
 
    
    
clear SA_File EMPA_File DLR_File
%% Plotting
    plot_SA(SA,SA_RC,Row);
    plot_GHG(SA,EMPA,DLR,SA_RC,Row)
    plot_Tracers(SA,EMPA,DLR,SA_RC,Row);
    plot_C2H6CO2(SA_RC);
%% Plume area
    Plume_Area = [Plume_Area;calc_PlumeArea(SA,EMPA,DLR,SA_RC,Row)];
    TracerArea=[TracerArea;calc_TracerArea(SA,EMPA,DLR,SA_RC,Row)];
    TracerArea(any(TracerArea.DLR_EMPA1==0,2),:) = [];
    i

end


%% Plotting 
plotPA_SA(SA_RC);
plot_C2H6CO2(SA_RC);
plot_RH_T(SA_RC);
plot_Wind(SA_RC);
