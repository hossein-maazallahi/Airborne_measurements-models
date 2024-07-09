clc
clear all
close all

TracersID=import_tracers_ID;
PlumeArea = import_plumes_info; %import the plume observed by both plumes
PlumeArea_EMPA=import_plumes_info_EMPA; %import info of plumes for the EMPA simulations
SA_Circles = ReadCircles;
PlumeArea_2=table; %Plume area statistics for the individual plumes obsevrec by both models
PlumeArea_3=table; %Plume area statistics for the individual plumes obsevrec by EMPA


%% for the plumes observed by EMPA
for i=1:size(PlumeArea_EMPA,1)
    i
    ID = floor(PlumeArea_EMPA.ID(i));
    
    FileName = char(SA_Circles.Region(ID));
    SA = readSA(FileName);
    
    EMPA = table;
    EMPA = ReadNETCDF_EMPA(ID,SA_Circles,SA);

    [~,SA_Start] = min(abs(datenum(SA.Time_UTC)-datenum(PlumeArea_EMPA.Plume_Start(i))));
    [~,SA_End] = min(abs(datenum(SA.Time_UTC)-datenum(PlumeArea_EMPA.Plume_End(i))));
    [~,SA_Start_Circle] = min(abs(datenum(SA.Time_UTC)-datenum(PlumeArea_EMPA.Circle_Start(i))));
    [~,SA_End_Circle] = min(abs(datenum(SA.Time_UTC)-datenum(PlumeArea_EMPA.Circle_End(i))));
    
    [~,EMPA_Start] = min(abs(datenum(EMPA.Date)-datenum(PlumeArea_EMPA.Plume_Start_EMPA(i))));
    [~,EMPA_End] = min(abs(datenum(EMPA.Date)-datenum(PlumeArea_EMPA.Plume_End_EMPA(i))));
    [~,EMPA_Start_Circle] = min(abs(datenum(EMPA.Date)-datenum(PlumeArea_EMPA.Circle_Start(i))));
    [~,EMPA_End_Circle] = min(abs(datenum(EMPA.Date)-datenum(PlumeArea_EMPA.Circle_End(i))));
    
 
    PlumeArea_3.ID (i) = PlumeArea_EMPA.ID(i);
    PlumeArea_3.ROI(i) = SA_Circles.Region (ID);
    PlumeArea_3.Date(i) = SA_Circles.Start (ID);
   
    
    PlumeArea_3.SA(i)       = sum((SA.CH4_ppm(SA_Start:SA_End)- min(SA.CH4_ppm(SA_Start:SA_End))).* SA.Dis2(SA_Start:SA_End))/1000;
    PlumeArea_3.EMPA_OMV (i)= sum((EMPA.OMV_f(EMPA_Start:EMPA_End) - min(EMPA.OMV_f(EMPA_Start:EMPA_End))).* EMPA.Dis2(EMPA_Start:EMPA_End))/1000;
    
end

%% for the plumes obsevred from both simulations
for i=1:size(PlumeArea,1)
    i
    ID = floor(PlumeArea.ID(i));
    
    FileName = char(SA_Circles.Region(ID));
    SA = readSA(FileName);

    DLR = table;
    DLR = ReadNETCDF_DLR(ID,SA_Circles);
    
    EMPA = table;
    EMPA = ReadNETCDF_EMPA(ID,SA_Circles);

    [~,SA_Start] = min(abs(datenum(SA.Time_UTC)-datenum(PlumeArea.Plume_Start(i))));
    [~,SA_End] = min(abs(datenum(SA.Time_UTC)-datenum(PlumeArea.Plume_End(i))));
    [~,SA_Start_Circle] = min(abs(datenum(SA.Time_UTC)-datenum(PlumeArea.Circle_Start(i))));
    [~,SA_End_Circle] = min(abs(datenum(SA.Time_UTC)-datenum(PlumeArea.Circle_End(i))));
    
    [~,DLR_Start] = min(abs(datenum(DLR.Date)-datenum(PlumeArea.Plume_Start_DLR(i))));
    [~,DLR_End] = min(abs(datenum(DLR.Date)-datenum(PlumeArea.Plume_End_DLR(i))));
    [~,DLR_Start_Circle] = min(abs(datenum(DLR.Date)-datenum(PlumeArea.Circle_Start(i))));
    [~,DLR_End_Circle] = min(abs(datenum(DLR.Date)-datenum(PlumeArea.Circle_End(i))));
    
    [~,EMPA_Start] = min(abs(datenum(EMPA.Date)-datenum(PlumeArea.Plume_Start_EMPA(i))));
    [~,EMPA_End] = min(abs(datenum(EMPA.Date)-datenum(PlumeArea.Plume_End_EMPA(i))));
    [~,EMPA_Start_Circle] = min(abs(datenum(EMPA.Date)-datenum(PlumeArea.Circle_Start(i))));
    [~,EMPA_End_Circle] = min(abs(datenum(EMPA.Date)-datenum(PlumeArea.Circle_End(i))));
    
    SA_Geo = meanm(SA.Latitude(SA_Start:SA_End),SA.Longitude(SA_Start:SA_End));
    DLR_Geo = meanm(DLR.Lat(DLR_Start:DLR_End),DLR.Lon(DLR_Start:DLR_End));
    EMPA_Geo = meanm(EMPA.Lat(EMPA_Start:EMPA_End),EMPA.Lon(EMPA_Start:EMPA_End));
 
     Re = 6.378*1e6;
 SA.Lat_Cart = (SA.Longitude - SA_Geo(2))*(pi/180)*cos((SA_Geo(1)*pi)/180)*Re;
 SA.Lon_Cart = (SA.Latitude - SA_Geo(1))*(pi/180)*Re;
 
 DLR.Lat_Cart = (DLR.Lon - DLR_Geo(2))*(pi/180)*cos((DLR_Geo(1)*pi)/180)*Re;
 DLR.Lon_Cart = (DLR.Lat - DLR_Geo(1))*(pi/180)*Re;
 
 EMPA.Lat_Cart = (EMPA.Lon - EMPA_Geo(2))*(pi/180)*cos((EMPA_Geo(1)*pi)/180)*Re;
 EMPA.Lon_Cart = (EMPA.Lat - EMPA_Geo(1))*(pi/180)*Re;
 
 SA.Dis(1) = 0;
 DLR.Dis(1) = 0;
 EMPA.Dis(1) = 0;
 
  
 for k=2:size(SA,1)-1
     SA.Dis(k) = sqrt((SA.Lat_Cart(k+1)-SA.Lat_Cart(k))^2+(SA.Lon_Cart(k+1)-SA.Lon_Cart(k))^2);
 end
 for k=2:size(DLR,1)-1
      DLR.Dis(k) = sqrt((DLR.Lat_Cart(k+1)-DLR.Lat_Cart(k))^2+(DLR.Lon_Cart(k+1)-DLR.Lon_Cart(k))^2);
 end
 for k=2:size(EMPA,1)-1
     EMPA.Dis(k) = sqrt((EMPA.Lat_Cart(k+1)-EMPA.Lat_Cart(k))^2+(EMPA.Lon_Cart(k+1)-EMPA.Lon_Cart(k))^2);
 end
 
 
    PlumeArea_2.ID (i) = PlumeArea.ID(i);
    
    PlumeArea_2.ROI(i) = SA_Circles.Region (ID);
    
    PlumeArea_2.Date(i) = SA_Circles.Start (ID);
    
    SA_Plume = SA(SA_Start:SA_End,:);
        %SA_Plume.Dis = SA_Plume.Dis - SA_Plume.Dis(1);
    DLR_Plume = DLR(DLR_Start:DLR_End,:);
        %DLR_Plume.Dis = DLR_Plume.Dis - DLR_Plume.Dis(1);
    EMPA_Plume = EMPA(EMPA_Start:EMPA_End,:);
        %EMPA_Plume.Dis = EMPA_Plume.Dis - EMPA_Plume.Dis(1);
    
    PlumeArea_2.SA(i) = sum((SA_Plume.CH4_ppm - min(SA_Plume.CH4_ppm)).* SA_Plume.Dis)/1000;
    PlumeArea_2.DLR_OMV (i) = sum((DLR_Plume.CH4OMV_f).* DLR_Plume.Dis)/1000;
    PlumeArea_2.EMPA_OMV (i)= sum(EMPA_Plume.OMV_f.* EMPA_Plume.Dis)/1000;
    
%% Circles
    threshold = 1;
    
figure('Position', get(0, 'Screensize'));

% Scientific aviation 
ax1 = subplot(3,1,1);
    plot(SA.Time_UTC(SA_Start_Circle:SA_End_Circle),SA.CH4_ppm(SA_Start_Circle:SA_End_Circle)-min(SA.CH4_ppm(SA_Start_Circle:SA_End_Circle)),'LineWidth',1,'DisplayName','SA')
legend
title(SA_Circles.Region(ID),'FontSize',20,'interpreter', 'none');
xlabel('Time (UTC)')
ylabel('Methane Enhance. (ppb)')
grid on
grid minor

% DLR
ax2 = subplot(3,1,2);
for j=1:21
        DLR_Circle=DLR.(genvarname(strcat('CH4OMV',num2str(j),'_f')));
        hold on
    if max(DLR_Circle(DLR_Start_Circle:DLR_End_Circle))>threshold
        plot(DLR.Date(DLR_Start_Circle:DLR_End_Circle),DLR_Circle(DLR_Start_Circle:DLR_End_Circle),'LineWidth',1.5,'DisplayName',TracersID.ID(j))
    end
end
hold off
legend
xlabel('Time (UTC)')
title('DLR simulation','FontSize',16)
ylabel('Methane Enhance. (ppb)')
grid on
grid minor

% EMPA
ax3 = subplot(3,1,3);
for j=1:21
        EMPA_Circle=EMPA.(genvarname(strcat('CH4OMV',num2str(j),'_f')));
        hold on
    if max(EMPA_Circle(EMPA_Start_Circle:EMPA_End_Circle))>threshold
        plot(EMPA.Date(EMPA_Start_Circle:EMPA_End_Circle),EMPA_Circle(EMPA_Start_Circle:EMPA_End_Circle),'LineWidth',1.5,'DisplayName',TracersID.ID(j))
    end
end
hold off
linkaxes([ax1,ax2,ax3],'x'); 
legend
xlabel('Time (UTC)')
title('EMPA simulation','FontSize',16)
ylabel('Methane Enhance. (ppb)')
grid on
grid minor


ID_File = char(SA_Circles.Region(ID));

FileDir_Matlab = convertCharsToStrings(strcat("/Users/hossein/Documents/Campaigns/ROMEO/Data/Flight/SA/Plumes/Individual_Plumes/Tracers/Circles/MATLAB"));
FileDir_jpg = convertCharsToStrings(strcat("/Users/hossein/Documents/Campaigns/ROMEO/Data/Flight/SA/Plumes/Individual_Plumes/Tracers/Circles/JPEG"));

saveas(gcf,strcat(FileDir_Matlab,"/",num2str(ID),"_",ID_File,"_","SA_","OMV_Tracers_Circle.fig"))
saveas(gcf,strcat(FileDir_jpg,"/",num2str(ID),"_",ID_File,"_","SA_","OMV_Tracers_Circle.jpg"))
    
%% Plumes
figure('Position', get(0, 'Screensize'));

% Scientific Aviation
ax1 = subplot(3,1,1);
    plot(SA.Time_UTC(SA_Start:SA_End),SA.CH4_ppm(SA_Start:SA_End)-min(SA.CH4_ppm(SA_Start:SA_End)),'LineWidth',1,'DisplayName','SA')
legend
title(PlumeArea.ROI(i),'FontSize',20,'interpreter', 'none');
xlabel('Time (UTC)')
ylabel('Methane Enhance. (ppb)')
grid on
grid minor

% DLR
ax2 = subplot(3,1,2);
flag=0;
for j=1:21
        DLR_Circle=DLR.(genvarname(strcat('CH4OMV',num2str(j),'_f')));
        hold on
    if max(DLR_Circle(DLR_Start:DLR_End))>threshold
        plot(DLR.Date(DLR_Start:DLR_End),DLR_Circle(DLR_Start:DLR_End),'LineWidth',1.5,'DisplayName',TracersID.ID(j))
    flag = flag+1;
    end
end
if flag == 0 
    plot(DLR.Date(DLR_Start:DLR_End), zeros(size(DLR.Date(DLR_Start:DLR_End),1)),'DisplayName','No Simulation')
end

hold off
legend
title('DLR simulation','FontSize',16)
xlabel('Time (UTC)')
ylabel('Methane Enhance. (ppb)')
grid on
grid minor

% EMPA
ax3 = subplot(3,1,3);
flag=0;
for j=1:21
        EMPA_Circle=EMPA.(genvarname(strcat('CH4OMV',num2str(j),'_f')));
        hold on
    if max(EMPA_Circle(EMPA_Start:EMPA_End))>threshold
        plot(EMPA.Date(EMPA_Start:EMPA_End),EMPA_Circle(EMPA_Start:EMPA_End),'LineWidth',1.5,'DisplayName',TracersID.ID(j))
    flag = flag+1;
    end
end
if flag == 0 
    plot(EMPA.Date(EMPA_Start:EMPA_End), zeros(size(EMPA.Date(EMPA_Start:EMPA_End),1)),'DisplayName','No Simulation')
end
hold off
linkaxes([ax1,ax2,ax3],'x'); 
legend
xlabel('Time (UTC)')
title('EMPA simulation','FontSize',16)
ylabel('Methane Enhance. (ppb)')
grid on
grid minor

ID_Plume = num2str(PlumeArea.ID(i));

FileDir_Matlab = convertCharsToStrings(strcat("/Users/hossein/Documents/Campaigns/ROMEO/Data/Flight/SA/Plumes/Individual_Plumes/Tracers/Plumes/MATLAB"));
FileDir_jpg = convertCharsToStrings(strcat("/Users/hossein/Documents/Campaigns/ROMEO/Data/Flight/SA/Plumes/Individual_Plumes/Tracers/Plumes/JPEG"));

saveas(gcf,strcat(FileDir_Matlab,"/",ID_Plume,"_",ID_File,"_","SA_","OMV_Tracers_Plume.fig"))
saveas(gcf,strcat(FileDir_jpg,"/",ID_Plume,"_",ID_File,"_","SA_","OMV_Tracers_Plume.jpg"))


figure

close all


end