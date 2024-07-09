function Plume_Area = calc_PlumeArea(SA,EMPA,DLR,SA_RC,Row)
Plume_Area = table;
if Row == 1
    i_min = 1; i_max = 22;
elseif Row == 2
    i_min = 23; i_max = 37;
elseif Row == 3
    i_min = 38; i_max = 42;
elseif Row == 4
    i_min = 43; i_max = 57;
elseif Row == 6
    i_min = 58; i_max = 90;
elseif Row == 7
    i_min = 91; i_max = 106;
elseif Row == 8
    i_min = 107; i_max = 112;
elseif Row == 9
    i_min = 113; i_max = 149;
elseif Row == 10
    i_min = 150; i_max = 175;
elseif Row == 11
    i_min = 176; i_max = 228;
end
    
for i = i_min:i_max
[~,SA_Start]    = min(abs(datenum(SA.Date)-datenum(SA_RC.SA_Start(i))));
[~,SA_End]      = min(abs(datenum(SA.Date)-datenum(SA_RC.SA_End(i))));

[~,DLR_Start]    = min(abs(datenum(DLR.Date)-datenum(SA_RC.DLR_Start(i))));
[~,DLR_End]      = min(abs(datenum(DLR.Date)-datenum(SA_RC.DLR_End(i))));

[~,EMPA_Start]    = min(abs(datenum(EMPA.Date)-datenum(SA_RC.EMPA_Start(i))));
[~,EMPA_End]      = min(abs(datenum(EMPA.Date)-datenum(SA_RC.EMPA_End(i))));

    SA_Plume   = SA(SA_Start:SA_End,:);
    DLR_Plume  = DLR(DLR_Start:DLR_End,:);
    EMPA_Plume = EMPA(EMPA_Start:EMPA_End,:);
    
    % SA
    SA_Plume.CH4_Enh = SA_Plume.CH4_ppm - min(SA_Plume.CH4_ppm)-1;
    
WS_SA = sqrt(SA_Plume.WindU.^2+SA_Plume.WindV.^2);
WD_SA = mod(180+(180/pi)*atan2(SA_Plume.WindV,SA_Plume.WindU),360);
    WS_SA_Mean = mean(WS_SA);                   %Wind Speed
    WS_SA_Std  = std(WS_SA);  
    WD_SA_Mean = mean(WD_SA);                   %Wind Direction
    WD_SA_Std  = std(WD_SA);                                                
       
    T_SA_Mean  = mean(SA_Plume.Temperature_C);  %Temperature
    T_SA_Std   = std(SA_Plume.Temperature_C);
    RH_SA_Mean  = mean(SA_Plume.RH_percent);    %Relative Humidity
    RH_SA_Std   = std(SA_Plume.RH_percent);
    Alt_SA_Mean  = mean(SA_Plume.AGL_m);         %Altitude
    Alt_SA_Std   = std(SA_Plume.AGL_m);  
    Bck_SA_CH4  = min(SA_Plume.CH4_ppm);        %Minimum  CH4 / Background
    U_SA_Mean  = mean(SA_Plume.WindU);
    V_SA_Mean  = mean(SA_Plume.WindV);
        
        
    SA_Area = sum(SA_Plume.CH4_Enh.* SA_Plume.Dis2)/1000;
    SA_Area2= sum(SA_Plume.CH4_Enh.* SA_Plume.Dis2.*WS_SA)/1000;
    %SA_Area3= sum(SA_Plume.CH4_Enh.* SA_Plume.Dis2.*SA.WindU)/1000;
    %SA_Area4= sum(SA_Plume.CH4_Enh.* SA_Plume.Dis2.*SA.WindV)/1000;
    
    % DLR
WS_DLR = sqrt(DLR_Plume.U_f.^2+DLR_Plume.V_f.^2);
WD_DLR = mod(180+(180/pi)*atan2(DLR_Plume.V_f,DLR_Plume.U_f),360);
        WS_DLR_Mean = mean(WS_DLR);
        WS_DLR_Std = std(WS_DLR);
        WD_DLR_Mean = mean(WD_DLR);
        WD_DLR_Std = std(WD_DLR);
        
        T_DLR_Mean   = mean(DLR_Plume.T_f);          %Temperature
        T_DLR_Std    = std(DLR_Plume.T_f);
        RH_DLR_Mean  = mean(DLR_Plume.RH);           %Relative Humidity
        RH_DLR_Std   = std(DLR_Plume.RH);
        Bck_DLR_CH4  = mean(DLR_Plume.CH4_Bck);      %CH4 / Background
        Bck_DLR_CH4_Std  = std(DLR_Plume.CH4_Bck);       
        U_DLR_Mean  = mean(DLR_Plume.U_f);
        V_DLR_Mean  = mean(DLR_Plume.V_f);
        DLR_Bck2 = min(DLR_Plume.CH4_OMV);
        
    DLR_Plume.CH4_OMV = DLR_Plume.CH4_OMV - min(DLR_Plume.CH4_OMV); % correcting background
    DLR_Area  = sum(DLR_Plume.CH4_OMV.* DLR_Plume.Dis2)/1000;
    DLR_Area2 = sum(DLR_Plume.CH4_OMV .*DLR_Plume.Dis2.*WS_DLR)/1000;
    %DLR_Area3 = sum(DLR.CH4OMV_f .*DLR.Dis2.*DLR.U_f)/1000;
    %DLR_Area4 = sum(DLR.CH4OMV_f .*DLR.Dis2.*DLR.V_f)/1000;
    
    % EMPA
WS_EMPA = sqrt(EMPA_Plume.U_f.^2+EMPA_Plume.V_f.^2);
WD_EMPA = mod(180+(180/pi)*atan2(EMPA_Plume.V_f,EMPA_Plume.U_f),360);

        WS_EMPA_Mean = mean(WS_EMPA);
        WS_EMPA_Std = std(WS_EMPA);
        WD_EMPA_Mean = mean(WD_EMPA);
        WD_EMPA_Std = std(WD_EMPA);
        
        T_EMPA_Mean   = mean(EMPA_Plume.T_f);          %Temperature
        T_EMPA_Std    = std(EMPA_Plume.T_f);
        RH_EMPA_Mean  = mean(EMPA_Plume.RH);           %Relative Humidity
        RH_EMPA_Std   = std(EMPA_Plume.RH);
        Bck_EMPA_CH4  = mean(EMPA_Plume.CH4_Bck);      %CH4 / Background
        Bck_EMPA_CH4_Std  = std(EMPA_Plume.CH4_Bck);       
        U_EMPA_Mean = mean(EMPA_Plume.U_f);
        V_EMPA_Mean = mean(EMPA_Plume.V_f);
        EMPA_Bck2 = min(EMPA_Plume.CH4_OMV);            % Additional CH4 back 
        
    EMPA_Plume.CH4_OMV = EMPA_Plume.CH4_OMV - min(EMPA_Plume.CH4_OMV); % correcting background
    EMPA_Area  = sum(EMPA_Plume.CH4_OMV .* EMPA_Plume.Dis2)/1000;
    EMPA_Area2 = sum(EMPA_Plume.CH4_OMV .* EMPA_Plume.Dis2.*WS_EMPA)/1000;
    %EMPA_Area3 = sum(EMPA.OMV_f .* EMPA.Dis2.*EMPA.U_f)/1000;
    %EMPA_Area4 = sum(EMPA.OMV_f .* EMPA.Dis2.*EMPA.V_f)/1000;
    
Plume_Area.ID (i-i_min+1)     = str2double(sprintf('%.2f',SA_RC.ID(i)));
Plume_Area.SA_PA(i-i_min+1)   = str2double(sprintf('%.0f',SA_Area2));
Plume_Area.DLR_PA(i-i_min+1)  = str2double(sprintf('%.0f',DLR_Area2));
Plume_Area.EMPA_PA(i-i_min+1) = str2double(sprintf('%.0f',EMPA_Area2));

Plume_Area.SA_PA2(i-i_min+1)   = str2double(sprintf('%.0f',SA_Area));
Plume_Area.DLR_PA2(i-i_min+1)  = str2double(sprintf('%.0f',DLR_Area));
Plume_Area.EMPA_PA2(i-i_min+1) = str2double(sprintf('%.0f',EMPA_Area));

Plume_Area.SA_WS(i-i_min+1) = strcat(num2str(WS_SA_Mean,'%6.1f'),"±",num2str(WS_SA_Std,'%6.1f'));
Plume_Area.DLR_WS(i-i_min+1) = strcat(num2str(WS_DLR_Mean,'%6.1f'),"±",num2str(WS_DLR_Std,'%6.1f'));
Plume_Area.EMPA_WS(i-i_min+1) = strcat(num2str(WS_EMPA_Mean,'%6.1f'),"±",num2str(WS_EMPA_Std,'%6.1f'));

Plume_Area.SA_WD(i-i_min+1) = strcat(num2str(WD_SA_Mean,'%6.1f'),"±",num2str(WD_SA_Std,'%6.1f'));
Plume_Area.DLR_WD(i-i_min+1) = strcat(num2str(WD_DLR_Mean,'%6.1f'),"±",num2str(WD_DLR_Std,'%6.1f'));
Plume_Area.EMPA_WD(i-i_min+1) = strcat(num2str(WD_EMPA_Mean,'%6.1f'),"±",num2str(WD_EMPA_Std,'%6.1f'));


Plume_Area.SA_Alt(i-i_min+1) = strcat(num2str(Alt_SA_Mean,'%6.0f'),"±",num2str(Alt_SA_Std,'%6.0f'));

Plume_Area.SA_T(i-i_min+1) = strcat(num2str(T_SA_Mean,'%6.1f'),"±",num2str(T_SA_Std,'%6.1f'));
Plume_Area.DLR_T(i-i_min+1) = strcat(num2str(T_DLR_Mean,'%6.1f'),"±",num2str(T_DLR_Std,'%6.1f'));
Plume_Area.EMPA_T(i-i_min+1) = strcat(num2str(T_EMPA_Mean,'%6.1f'),"±",num2str(T_EMPA_Std,'%6.1f'));

Plume_Area.SA_RH(i-i_min+1) = strcat(num2str(RH_SA_Mean,'%6.1f'),"±",num2str(RH_SA_Std,'%6.1f'));
Plume_Area.DLR_RH(i-i_min+1) = strcat(num2str(RH_DLR_Mean,'%6.1f'),"±",num2str(RH_DLR_Std,'%6.1f'));
Plume_Area.EMPA_RH(i-i_min+1) = strcat(num2str(RH_EMPA_Mean,'%6.1f'),"±",num2str(RH_EMPA_Std,'%6.1f'));

%Background
Plume_Area.SA_Bck(i-i_min+1) = strcat(num2str(Bck_SA_CH4,'%6.0f'),"±",num2str(000));
Plume_Area.DLR_Bck(i-i_min+1) = strcat(num2str(Bck_DLR_CH4,'%6.0f'),"±",num2str(Bck_DLR_CH4_Std,'%6.0f'));
Plume_Area.EMPA_Bck(i-i_min+1) = strcat(num2str(Bck_EMPA_CH4,'%6.0f'),"±",num2str(Bck_EMPA_CH4_Std,'%6.0f'));
Plume_Area.DLR_Bck2(i-i_min+1) = strcat(num2str(DLR_Bck2,'%6.0f'),"±",num2str(000,'%6.0f'));
Plume_Area.EMPA_Bck2(i-i_min+1) = strcat(num2str(EMPA_Bck2,'%6.0f'),"±",num2str(000,'%6.0f'));

% CO2
x = SA_Plume.CH4_ppm;
y = SA_Plume.CO2_ppm*1000;
R=corrcoef(x,y);
slope=polyfit(x,y,1);
Plume_Area.CO2_CH4(i-i_min+1) = strcat("Slope:",num2str(slope(1),'%6.0f'),"/RSq:",num2str(R(2)^2,'%6.2f'));

%C2H6
C2=smoothdata(SA_Plume.C2H6_ppb);
C2=C2-min(C2);
SA_Plume.C2H6_ppb = SA_Plume.C2H6_ppb - min(C2);
C2_sum = sum(SA_Plume.C2H6_ppb);
C1_sum = sum(SA_Plume.CH4_Enh);
Plume_Area.C2H6_CH4 (i-i_min+1) = str2double(sprintf('%6.1f',100*C2_sum / C1_sum));

kmlwriteline(strcat('SA',num2str(SA_RC.ID(i)),'.kml'),SA_Plume.Lat,SA_Plume.Lon,SA_Plume.CH4_Enh*1000);
kmlwriteline(strcat('DLR',num2str(SA_RC.ID(i)),'.kml'),DLR_Plume.Lat,DLR_Plume.Lon,DLR_Plume.CH4_OMV*1000);
kmlwriteline(strcat('EMPA',num2str(SA_RC.ID(i)),'.kml'),EMPA_Plume.Lat,EMPA_Plume.Lon,EMPA_Plume.CH4_OMV*1000);

%%
figure
ax1=subplot(1,3,1);
    plot(SA_Plume.Date,SA_Plume.CH4_Enh,'DisplayName','SA-CH4');
    hold on
    plot(SA_Plume.Date,SA_Plume.Temperature_C,'DisplayName','SA-T');
    plot(SA_Plume.Date,SA_Plume.RH_percent,'DisplayName','SA-RH');
    legend
    
ax2=subplot(1,3,2);
for i=2
    plot(DLR_Plume.Date,DLR_Plume.(genvarname(strcat('Tracer',num2str(i)))),'DisplayName',strcat('Tracer',num2str(i)));
    hold on 
end
    plot(DLR_Plume.Date,DLR_Plume.T_f,'DisplayName','DLR-T');
    plot(DLR_Plume.Date,DLR_Plume.RH,'DisplayName','DLR-RH');
    legend
    
ax3=subplot(1,3,3);
for i=1:21
    Tracer = strcat('Tracer',num2str(i));
    plot(EMPA_Plume.Date,EMPA_Plume.(genvarname(strcat('Tracer',num2str(i)))),'DisplayName',strcat('Tracer',num2str(i)));
    hold on
end
    plot(EMPA_Plume.Date,EMPA_Plume.T_f,'DisplayName','EMPA-T');
    plot(EMPA_Plume.Date,EMPA_Plume.RH,'DisplayName','EMPA-RH');
    legend

end