function plot_INCAS(INCAS,INCAS_Reg,Row)
i = Row;

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

[~,INCAS_Start]    = min(abs(datenum(INCAS.Date)-datenum(INCAS_Reg.INCAS_Start(i))));
[~,INCAS_End]      = min(abs(datenum(INCAS.Date)-datenum(INCAS_Reg.INCAS_End(i))));

figure
set(gcf, 'Position', get(0, 'Screensize'))
    ax1=subplot(2,1,1);
        plot(INCAS.Date(INCAS_Start:INCAS_End),INCAS.CH4_drycalibrated(INCAS_Start:INCAS_End),'b-','LineWidth',2,'DisplayName','Methane');
        ylabel('Methane (ppb)')
        yyaxis right;
        %C2=smoothdata(INCAS.C2H6_ppb(INCAS_Start:INCAS_End));
        %INCAS.C2H6_ppb(INCAS_Start:INCAS_End) = INCAS.C2H6_ppb(INCAS_Start:INCAS_End) - min(C2);
        plot(INCAS.Date(INCAS_Start:INCAS_End),INCAS.CO2ppm(INCAS_Start:INCAS_End)-min(INCAS.CO2ppm(INCAS_Start:INCAS_End)),'r-','LineWidth',2,'DisplayName','Carbon Dioxide');
        ylabel('Carbon Dioxide (ppm)')
        legend
        ax = gca;
        ax.YAxis(1).Color = 'b';
        ax.YAxis(2).Color = 'r';

        
    ax2=subplot(2,1,2);
        plot(INCAS.Date(INCAS_Start:INCAS_End),INCAS.CH4_drycalibrated(INCAS_Start:INCAS_End),'b-','LineWidth',2,'DisplayName','Methane');
        ylabel('Methane (ppb)')
        yyaxis right;
        plot(INCAS.Date(INCAS_Start:INCAS_End),INCAS.COppm(INCAS_Start:INCAS_End),'k-','LineWidth',2,'DisplayName','Carbon Monoxide');
        ylabel('Carbon Monoxide (ppm)')
        legend
        ax = gca;
        ax.YAxis(1).Color = 'b';
        ax.YAxis(2).Color = 'k';

        
    ax3=subplot(2,2,3);
        plot(INCAS.Date(INCAS_Start:INCAS_End),INCAS.PressurehPa(INCAS_Start:INCAS_End),'b-','LineWidth',2,'DisplayName','Pressure');
        ylabel('Temperature (C)')
        yyaxis right;
        plot(INCAS.Date(INCAS_Start:INCAS_End),INCAS.B_H2O_pct(INCAS_Start:INCAS_End),'k-','LineWidth',2,'DisplayName','Relative Humidity');   
        ylabel('Relative Humidity (%)')
        legend
        ax = gca;
        ax.YAxis(1).Color = 'b';
        ax.YAxis(2).Color = 'k';

    ax4=subplot(2,2,4);
        plot(INCAS.Date(INCAS_Start:INCAS_End),INCAS.AltitudemAGL(INCAS_Start:INCAS_End),'DisplayName','Altitude');
        legend
        
linkaxes([ax1,ax2,ax3,ax4],'x'); 
supt = suptitle(strcat(sprintf('%.2f',INCAS_Reg.ID(i))," ", char(INCAS_Reg.Region(i))));
supt.FontSize = 32;
supt.FontWeight = 'bold';

     linkaxes([ax1,ax2],'x'); 
supt = suptitle(strcat(sprintf('%.2f',INCAS_Reg.ID(i))," ", char(INCAS_Reg.Region(i))));
supt.FontSize = 32;
supt.FontWeight = 'bold';   

FileDir_Matlab = convertCharsToStrings(strcat("../Figures/INCAS"));
FileDir_jpg = convertCharsToStrings(strcat("../Figures/INCAS"));

FileName = strcat(sprintf('%.2f',INCAS_Reg.ID(i))," ", char(INCAS_Reg.Region(i)));

saveas(gcf,strcat(FileDir_Matlab,"/",FileName,"_","INCAS.fig"))
saveas(gcf,strcat(FileDir_jpg,"/",FileName,"_","INCAS.jpg"))


close all
end