function Plume_Area = calc_PlumeArea(INCAS,EMPA,DLR,INCAS_Reg,Row)
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
   
for i = Row
[~,INCAS_Start]   = min(abs(datenum(INCAS.Date)-datenum(INCAS_Reg.INCAS_Start(i))));
[~,INCAS_End]     = min(abs(datenum(INCAS.Date)-datenum(INCAS_Reg.INCAS_End(i))));

[~,DLR_Start]     = min(abs(datenum(DLR.Date)-datenum(INCAS_Reg.DLR_Start(i))));
[~,DLR_End]       = min(abs(datenum(DLR.Date)-datenum(INCAS_Reg.DLR_End(i))));

[~,EMPA_Start]    = min(abs(datenum(EMPA.Date)-datenum(INCAS_Reg.EMPA_Start(i))));
[~,EMPA_End]      = min(abs(datenum(EMPA.Date)-datenum(INCAS_Reg.EMPA_End(i))));

    INCAS_Plume   = INCAS(INCAS_Start:INCAS_End,:);
    DLR_Plume     = DLR(DLR_Start:DLR_End,:);
    EMPA_Plume    = EMPA(EMPA_Start:EMPA_End,:);
    
    % SA
    INCAS_Plume.CH4_Enh = INCAS_Plume.CH4_drycalibrated - min(INCAS_Plume.CH4_drycalibrated);
    
%WS_INCAS = sqrt(INCAS_Plume.WindU.^2+INCAS_Plume.WindV.^2);
    WS_SA_Mean = mean(WS_INCAS);                   %Wind Speed
    WS_SA_Std  = std(WS_INCAS);  
    
    T_SA_Mean          = mean(INCAS_Plume.Temperature_C);  %Temperature
    T_SA_Std           = std(INCAS_Plume.Temperature_C);
    RH_INCAS_Mean       = mean(INCAS_Plume.B_H2O_pct);    %Relative Humidity
    RH_INCAS_Std        = std(INCAS_Plume.B_H2O_pct);
    Alt_INCAS_Mean      = mean(INCAS_Plume.AltitudemAGL);         %Altitude
    Alt_INCAS_Std       = std(INCAS_Plume.AltitudemAGL);  
    Bck_INCAS_CH4       = min(INCAS_Plume.CH4_drycalibrated);        %Minimum  CH4 / Background
    U_INCAS_Mean       = mean(INCAS_Plume.WindU);
    V_INCAS_Mean       = mean(INCAS_Plume.WindV);
        
        
    INCAS_Area          = sum(INCAS_Plume.CH4_Enh.* INCAS_Plume.Dis)/1000;
    INCAS_Area2        = sum(INCAS_Plume.CH4_Enh.* INCAS_Plume.Dis.*WS_INCAS)/1000;
    INCAS_Area3        = sum(SA_Plume.CH4_Enh.* SA_Plume.Dis2.*SA.WindU)/1000;
    INCAS_Area4        = sum(SA_Plume.CH4_Enh.* SA_Plume.Dis2.*SA.WindV)/1000;
    
    % DLR
WS_DLR                  = sqrt(DLR_Plume.U_f.^2+DLR_Plume.V_f.^2);
        WS_DLR_Mean     = mean(WS_DLR);
        WS_DLR_Std      = std(WS_DLR);
        
        T_DLR_Mean      = mean(DLR_Plume.T_f);          %Temperature
        T_DLR_Std       = std(DLR_Plume.T_f);
        RH_DLR_Mean     = mean(DLR_Plume.RH);           %Relative Humidity
        RH_DLR_Std      = std(DLR_Plume.RH);
        Bck_DLR_CH4     = mean(DLR_Plume.CH4_Bck);      %CH4 / Background
        Bck_DLR_CH4_Std = std(DLR_Plume.CH4_Bck);       
        U_DLR_Mean      = mean(DLR_Plume.U_f);
        V_DLR_Mean      = mean(DLR_Plume.V_f);
        DLR_Bck2        = min(DLR_Plume.CH4_OMV);
        
    DLR_Plume.CH4_OMV   = DLR_Plume.CH4_OMV - min(DLR_Plume.CH4_OMV); % correcting background
    DLR_Area            = sum(DLR_Plume.CH4_OMV.* DLR_Plume.Dis)/1000;
    DLR_Area2           = sum(DLR_Plume.CH4_OMV .*DLR_Plume.Dis.*WS_DLR)/1000;
    DLR_Area3          = sum(DLR.CH4OMV_f .*DLR.Dis2.*DLR.U_f)/1000;
    DLR_Area4          = sum(DLR.CH4OMV_f .*DLR.Dis2.*DLR.V_f)/1000;
    
    % EMPA
WS_EMPA                 = sqrt(EMPA_Plume.U_f.^2+EMPA_Plume.V_f.^2);
        WS_EMPA_Mean        = mean(WS_EMPA);
        WS_EMPA_Std         = std(WS_EMPA);
        T_EMPA_Mean         = mean(EMPA_Plume.T_f);          %Temperature
        T_EMPA_Std          = std(EMPA_Plume.T_f);
        RH_EMPA_Mean        = mean(EMPA_Plume.RH);           %Relative Humidity
        RH_EMPA_Std         = std(EMPA_Plume.RH);
        Bck_EMPA_CH4        = mean(EMPA_Plume.CH4_Bck);      %CH4 / Background
        Bck_EMPA_CH4_Std    = std(EMPA_Plume.CH4_Bck);       
        U_EMPA_Mean         = mean(EMPA_Plume.U_f);
        V_EMPA_Mean         = mean(EMPA_Plume.V_f);
        EMPA_Bck2           = min(EMPA_Plume.CH4_OMV);            % Additional CH4 back 
        
    EMPA_Plume.CH4_OMV      = EMPA_Plume.CH4_OMV - min(EMPA_Plume.CH4_OMV); % correcting background
    EMPA_Area               = sum(EMPA_Plume.CH4_OMV .* EMPA_Plume.Dis)/1000;
    EMPA_Area2              = sum(EMPA_Plume.CH4_OMV .* EMPA_Plume.Dis.*WS_EMPA)/1000;
    EMPA_Area3             = sum(EMPA.OMV_f .* EMPA.Dis2.*EMPA.U_f)/1000;
    EMPA_Area4             = sum(EMPA.OMV_f .* EMPA.Dis2.*EMPA.V_f)/1000;
    
Plume_Area.ID (i)           = str2double(sprintf('%.2f',INCAS_Reg.ID(i)));
Plume_Area.Region (i)       = INCAS_Reg.Region(i);
Plume_Area.INCAS_PA(i)      = str2double(sprintf('%.0f',INCAS_Area));
Plume_Area.DLR_PA(i)        = str2double(sprintf('%.0f',DLR_Area));
Plume_Area.EMPA_PA(i)       = str2double(sprintf('%.0f',EMPA_Area));
Plume_Area.DLR_PA_WS(i)     = str2double(sprintf('%.0f',DLR_Area2));
Plume_Area.EMPA_PA_WS(i)    = str2double(sprintf('%.0f',EMPA_Area2));

Plume_Area.SA_WS(i)        = strcat(num2str(WS_SA_Mean,'%6.1f'),"±",num2str(WS_SA_Std,'%6.1f'));
Plume_Area.DLR_WS(i)        = strcat(num2str(WS_DLR_Mean,'%6.1f'),"±",num2str(WS_DLR_Std,'%6.1f'));
Plume_Area.EMPA_WS(i)       = strcat(num2str(WS_EMPA_Mean,'%6.1f'),"±",num2str(WS_EMPA_Std,'%6.1f'));
Plume_Area.INCAS_Alt(i)     = strcat(num2str(Alt_INCAS_Mean,'%6.0f'),"±",num2str(Alt_INCAS_Std,'%6.0f'));

Plume_Area.SA_T(i)         = strcat(num2str(T_SA_Mean,'%6.1f'),"±",num2str(T_SA_Std,'%6.1f'));
Plume_Area.DLR_T(i)         = strcat(num2str(T_DLR_Mean,'%6.1f'),"±",num2str(T_DLR_Std,'%6.1f'));
Plume_Area.EMPA_T(i)        = strcat(num2str(T_EMPA_Mean,'%6.1f'),"±",num2str(T_EMPA_Std,'%6.1f'));

Plume_Area.INCAS_RH(i)      = strcat(num2str(RH_INCAS_Mean,'%6.1f'),"±",num2str(RH_INCAS_Std,'%6.1f'));
Plume_Area.DLR_RH(i)        = strcat(num2str(RH_DLR_Mean,'%6.1f'),"±",num2str(RH_DLR_Std,'%6.1f'));
Plume_Area.EMPA_RH(i)       = strcat(num2str(RH_EMPA_Mean,'%6.1f'),"±",num2str(RH_EMPA_Std,'%6.1f'));

%Background
Plume_Area.INCAS_Bck(i)     = strcat(num2str(Bck_INCAS_CH4,'%6.0f'),"±",num2str(000));
Plume_Area.DLR_Bck(i)       = strcat(num2str(Bck_DLR_CH4,'%6.0f'),"±",num2str(Bck_DLR_CH4_Std,'%6.0f'));
Plume_Area.EMPA_Bck(i)      = strcat(num2str(Bck_EMPA_CH4,'%6.0f'),"±",num2str(Bck_EMPA_CH4_Std,'%6.0f'));
Plume_Area.DLR_Bck2(i)      = strcat(num2str(DLR_Bck2,'%6.0f'),"±",num2str(000,'%6.0f'));
Plume_Area.EMPA_Bck2(i)     = strcat(num2str(EMPA_Bck2,'%6.0f'),"±",num2str(000,'%6.0f'));

% CO2
x = INCAS_Plume.CH4_drycalibrated;
y = INCAS_Plume.COppm*1000;
R=corrcoef(x,y);
slope=polyfit(x,y,1);
Plume_Area.CO2_CH4(i)       = strcat("Slope:",num2str(slope(1),'%6.2f'),"/RSq:",num2str(R(2)^2,'%6.2f'));


%C2H6
C2=smoothdata(INCAS_Plume.C2H6_ppb);
C2=C2-min(C2);
INCAS_Plume.C2H6_ppb = INCAS_Plume.C2H6_ppb - min(C2);
C2_sum = sum(INCAS_Plume.C2H6_ppb);
C1_sum = sum(INCAS_Plume.CH4_Enh);
Plume_Area.C2H6_CH4 (i) = str2double(sprintf('%6.1f',100*C2_sum / C1_sum));

%KML write
kmlwriteline(strcat('INCAS',num2str(INCAS_Reg.ID(i)),'.kml'),INCAS_Plume.Lat,INCAS_Plume.Lon,INCAS_Plume.CH4_Enh*1000);
kmlwriteline(strcat('DLR',num2str(SA_RC.ID(i)),'.kml'),DLR_Plume.Lat,DLR_Plume.Lon,DLR_Plume.CH4_OMV*1000);
kmlwriteline(strcat('EMPA',num2str(SA_RC.ID(i)),'.kml'),EMPA_Plume.Lat,EMPA_Plume.Lon,EMPA_Plume.CH4_OMV*1000);


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