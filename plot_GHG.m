function plot_GHG(INCAS,EMPA,DLR,INCAS_Reg,Row)
i=Row;

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

    [~,DLR_Start]      = min(abs(datenum(DLR.Date)-datenum(INCAS_Reg.DLR_Start(i))));
    [~,DLR_End]        = min(abs(datenum(DLR.Date)-datenum(INCAS_Reg.DLR_End(i))));

    [~,EMPA_Start]     = min(abs(datenum(EMPA.Date)-datenum(INCAS_Reg.EMPA_Start(i))));
    [~,EMPA_End]       = min(abs(datenum(EMPA.Date)-datenum(INCAS_Reg.EMPA_End(i))));

    figure; 
    set(gcf, 'Position', get(0, 'Screensize'))
ax1=subplot(4,1,[1 2]);

        plot(INCAS.Date(INCAS_Start:INCAS_End),INCAS.CH4_drycalibrated(INCAS_Start:INCAS_End)-min(INCAS.CH4_drycalibrated(INCAS_Start:INCAS_End)),'r-','LineWidth',2,'DisplayName','INCAS');
    hold on
        plot(DLR.Date(DLR_Start:DLR_End),DLR.CH4_OMV(DLR_Start:DLR_End),'b-','LineWidth',2,'DisplayName','DLR');
        plot(EMPA.Date(EMPA_Start:EMPA_End),EMPA.CH4_OMV(EMPA_Start:EMPA_End),'k-','LineWidth',2,'DisplayName','EMPA');
    hold off
    legend
    title ('Plume Duration')
    ylabel('Methane Enh. (ppb)');
    xlabel('Time (UTC)');
    
ax2=subplot(4,1,[3 4]);   
    plot(INCAS.Dis2(INCAS_Start:INCAS_End),INCAS.CH4_drycalibrated(INCAS_Start:INCAS_End)-min(INCAS.CH4_drycalibrated(INCAS_Start:INCAS_End)),'r-','LineWidth',2,'DisplayName','INCAS');
    hold on
        plot(DLR.Dis2(DLR_Start:DLR_End),DLR.CH4_OMV(DLR_Start:DLR_End)-min(DLR.CH4_OMV(DLR_Start:DLR_End)),'b-','LineWidth',2,'DisplayName','DLR');
        plot(EMPA.Dis2(EMPA_Start:EMPA_End),EMPA.CH4_OMV(EMPA_Start:EMPA_End)-min(EMPA.CH4_OMV(EMPA_Start:EMPA_End)),'k-','LineWidth',2,'DisplayName','EMPA');
    hold off
    
    legend
    title ('Plume Width')
    ylabel('Methane Enh. (ppb)');
    xlabel('Distance (m)');
    %linkaxes([ax1,ax2],'y'); 
    supt = suptitle(strcat(sprintf('%.2f',INCAS_Reg.ID(i))," ", char(INCAS_Reg.Region(i))));
    supt.FontSize = 32;
    supt.FontWeight = 'bold';
 
FileDir_Matlab = convertCharsToStrings(strcat("../Figures/INCAS-DLR-EMPA"));
FileDir_jpg    = convertCharsToStrings(strcat("../Figures/INCAS-DLR-EMPA"));

FileName = strcat(sprintf('%.2f',INCAS_Reg.ID(i))," ", char(INCAS_Reg.Region(i)));

saveas(gcf,strcat(FileDir_Matlab,"/",FileName,"_","INCAS-DLR-EMPA.fig"))
saveas(gcf,strcat(FileDir_jpg,"/",FileName,"_","INCAS-DLR-EMPA.jpg"))

close all
end