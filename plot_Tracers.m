function plot_Tracers(INCAS,EMPA,DLR,INCAS_Reg,Row)
TracersID=import_tracers_ID;
TracerArea=table;
i = Row;

if Row == 1
    i_min = 2; i_max = 22;
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
    
    INCAS_Plume        = INCAS(INCAS_Start:INCAS_End,:);
    DLR_Plume          = DLR(DLR_Start:DLR_End,:);
    EMPA_Plume         = EMPA(EMPA_Start:EMPA_End,:);
    
    figure; 
    set(gcf, 'Position', get(0, 'Screensize'))
ax1=subplot(2,2,[1 2]);

plot(INCAS.Date(INCAS_Start:INCAS_End),INCAS.CH4_drycalibrated(INCAS_Start:INCAS_End)-min(INCAS.CH4_drycalibrated(INCAS_Start:INCAS_End)),'r-','LineWidth',2,'DisplayName','INCAS');
    hold on
        for j=1:21
            DLR_Tracer=DLR_Plume.(genvarname(strcat('Tracer',num2str(j))));
            plot(DLR_Plume.Date,DLR_Tracer,'LineWidth',1.5,'DisplayName',TracersID.ID(j))
        end
    hold off
    legend
    title ('INCAS vs DLR | Plume Duration')
    ylabel('Methane Enh. (ppb)');
    xlabel('Time (UTC)');
    grid on
    grid minor
    
ax2=subplot(2,2,[3 4]);
plot(INCAS_Plume.Date,INCAS_Plume.CH4_drycalibrated-min(INCAS_Plume.CH4_drycalibrated),'r-','LineWidth',2,'DisplayName','SA');
    hold on
        for j=1:21
            EMPA_Tracer=EMPA_Plume.(genvarname(strcat('Tracer',num2str(j))));           
            plot(EMPA_Plume.Date,EMPA_Tracer,'LineWidth',1.5,'DisplayName',TracersID.ID(j))
        end
    hold off
    legend
    title ('INCAS vs EMPA | Plume Duration')
    ylabel('Methane Enh. (ppb)');
    xlabel('Time (UTC)');
    grid on
    grid minor
    
    linkaxes([ax1,ax2],'x'); 
    
    title ('Plume Width')
    ylabel('Methane Enh. (ppb)');
    xlabel('Distance (m)');
    %linkaxes([ax1,ax2],'y'); 
    supt = suptitle(strcat(sprintf('%.2f',SA_RC.ID(i))," ", char(SA_RC.Region(i))));
    supt.FontSize = 32;
    supt.FontWeight = 'bold';
    
FileDir_Matlab = convertCharsToStrings(strcat("/Users/hossein/Documents/Campaigns/ROMEO/Data/Flight/INCAS/New_Evaluation/Figures/INCAS-DLR-EMPA/Tracers"));
FileDir_jpg = convertCharsToStrings(strcat("/Users/hossein/Documents/Campaigns/ROMEO/Data/Flight/INCAS/New_Evaluation/Figures/INCAS-DLR-EMPA/Tracers"));

FileName = strcat(sprintf('%.2f',INCAS_Reg.ID(i))," ", char(INCAS_Reg.Region(i)));

saveas(gcf,strcat(FileDir_Matlab,"/",FileName,"_","INCAS-DLR-EMPA_Tracers.fig"))
saveas(gcf,strcat(FileDir_jpg,"/",FileName,"_","INCAS-DLR-EMPA_Tracers.jpg"))
%}
close all
    
end