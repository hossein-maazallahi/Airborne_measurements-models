clc
clear all
close all

Plume_Area = [];
TracerArea = [];
Rows = [1 2 3 4 5 6 7 8 9 10 11 12 13 14];

INCAS_Reg = read_StartEnds;
%% Calculation - Not needed to be repeated for plotting and it is locked

for i=1:14

Row = Rows(i); % Row represents each day's of flight measurements

% Row = 5 should be excluded as it is for the region 11;
%% Reading measurements and model outputs

[INCAS_File, EMPA_File, DLR_File]=read_Directories(Row);
    INCAS    = read_INCAS(INCAS_File);
    EMPA     = read_EMPA(EMPA_File,INCAS);
    DLR      = read_DLR(DLR_File,INCAS,Row); 
    
    figure
    plot(INCAS.Lat,INCAS.Lon,'o');
    figure
    plot(DLR.Lat,DLR.Lon,'o');
    figure
    plot(EMPA.Lat,EMPA.Lon,'o');
    
    
  
clear INCAS_File EMPA_File DLR_File
%% Plotting
    plot_INCAS(INCAS,INCAS_Reg,Row);
    plot_GHG(INCAS,EMPA,DLR,INCAS_Reg,Row);
    plot_Tracers(INCAS,EMPA,DLR,INCAS_Reg,Row);
    plot_C2H6CO2(SA_RC);
%% Plume area
Plume_Area = [Plume_Area;calc_PlumeArea(INCAS,EMPA,DLR,INCAS_Reg,Row)];
Plume_Area(~Plume_Area.ID,:) = [];
TracerArea=[TracerArea;calc_TracerArea(INCAS,EMPA,DLR,INCAS_Reg,Row)];
TracerArea(any(TracerArea.DLR_Tracer1==0,2),:) = [];
i


end