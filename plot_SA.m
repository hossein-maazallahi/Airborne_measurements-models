function plot_SA(SA,SA_RC,Row)
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

for i=i_min:i_max
[~,SA_Start]    = min(abs(datenum(SA.Date)-datenum(SA_RC.SA_Start(i))));
[~,SA_End]      = min(abs(datenum(SA.Date)-datenum(SA_RC.SA_End(i))));

figure
set(gcf, 'Position', get(0, 'Screensize'))
    ax1=subplot(2,2,1);
        plot(SA.Date(SA_Start:SA_End),SA.CH4_ppm(SA_Start:SA_End),'DisplayName','Methane');
        ylabel('Methane (ppb)')
        yyaxis right;
        C2=smoothdata(SA.C2H6_ppb(SA_Start:SA_End));
        SA.C2H6_ppb(SA_Start:SA_End) = SA.C2H6_ppb(SA_Start:SA_End) - min(C2);
        plot(SA.Date(SA_Start:SA_End),SA.C2H6_ppb(SA_Start:SA_End),'DisplayName','Ethane');
        ylabel('Ethane (ppb)')
        legend
        
    ax2=subplot(2,2,2);
        plot(SA.Date(SA_Start:SA_End),SA.CH4_ppm(SA_Start:SA_End),'DisplayName','Methane');
        ylabel('Methane (ppb)')
        yyaxis right;
        plot(SA.Date(SA_Start:SA_End),SA.CO2_ppm(SA_Start:SA_End),'DisplayName','CarbonDioxide');
        ylabel('Carbon Dioxide (ppm)')
        legend
        
    ax3=subplot(2,2,3);
        plot(SA.Date(SA_Start:SA_End),SA.Temperature_C(SA_Start:SA_End),'DisplayName','Temperature');
        ylabel('Temperature (C)')
        yyaxis right;
        plot(SA.Date(SA_Start:SA_End),SA.RH_percent(SA_Start:SA_End),'DisplayName','Relative Humidity');   
        ylabel('Relative Humidity (%)')
        legend
        
    ax4=subplot(2,2,4);
        plot(SA.Date(SA_Start:SA_End),SA.AGL_m(SA_Start:SA_End),'DisplayName','Altitude');
        legend
        
linkaxes([ax1,ax2,ax3,ax4],'x'); 
supt = suptitle(strcat(sprintf('%.2f',SA_RC.ID(i))," ", char(SA_RC.Region(i))));
supt.FontSize = 32;
supt.FontWeight = 'bold';

FileDir_Matlab = convertCharsToStrings(strcat("../Figures/SA"));
FileDir_jpg = convertCharsToStrings(strcat("../Figures/SA"));

FileName = strcat(sprintf('%.2f',SA_RC.ID(i))," ", char(SA_RC.Region(i)));

saveas(gcf,strcat(FileDir_Matlab,"/",FileName,"_","SA.fig"))
saveas(gcf,strcat(FileDir_jpg,"/",FileName,"_","SA.jpg"))

close all
end