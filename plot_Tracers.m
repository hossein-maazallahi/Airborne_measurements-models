function plot_Tracers(SA,EMPA,DLR,SA_RC,Row)
TracersID=import_tracers_ID;
TracerArea=table;
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
    [~,SA_Start]    = min(abs(datenum(SA.Date)-datenum(SA_RC.SA_Start(i))));
    [~,SA_End]      = min(abs(datenum(SA.Date)-datenum(SA_RC.SA_End(i))));

    [~,DLR_Start]    = min(abs(datenum(DLR.Date)-datenum(SA_RC.DLR_Start(i))));
    [~,DLR_End]      = min(abs(datenum(DLR.Date)-datenum(SA_RC.DLR_End(i))));

    [~,EMPA_Start]    = min(abs(datenum(EMPA.Date)-datenum(SA_RC.EMPA_Start(i))));
    [~,EMPA_End]      = min(abs(datenum(EMPA.Date)-datenum(SA_RC.EMPA_End(i))));
    
    SA_Plume   = SA(SA_Start:SA_End,:);
    DLR_Plume  = DLR(DLR_Start:DLR_End,:);
    EMPA_Plume = EMPA(EMPA_Start:EMPA_End,:);
    
    figure; 
    set(gcf, 'Position', get(0, 'Screensize'))
ax1=subplot(2,2,[1 2]);

plot(SA.Date(SA_Start:SA_End),SA.CH4_ppm(SA_Start:SA_End)-min(SA.CH4_ppm(SA_Start:SA_End)),'r-','LineWidth',2,'DisplayName','SA');
    hold on
        for j=1:21
            DLR_Tracer=DLR_Plume.(genvarname(strcat('Tracer',num2str(j))));
            plot(DLR_Plume.Date,DLR_Tracer,'LineWidth',1.5,'DisplayName',TracersID.ID(j))
        end
    hold off
    legend
    title ('Plume Duration')
    ylabel('Methane Enh. (ppb)');
    xlabel('Time (UTC)');
    grid on
    grid minor
    
ax2=subplot(2,2,[3 4]);
plot(SA_Plume.Date,SA_Plume.CH4_ppm-min(SA_Plume.CH4_ppm),'r-','LineWidth',2,'DisplayName','SA');
    hold on
        for j=1:21
            EMPA_Tracer=EMPA_Plume.(genvarname(strcat('Tracer',num2str(j))));           
            plot(EMPA_Plume.Date,EMPA_Tracer,'LineWidth',1.5,'DisplayName',TracersID.ID(j))
        end
    hold off
    legend
    title ('Plume Duration')
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
    
FileDir_Matlab = convertCharsToStrings(strcat("../Figures/SA-DLR-EMPA"));
FileDir_jpg = convertCharsToStrings(strcat("../Figures/SA-DLR-EMPA"));

FileName = strcat(sprintf('%.2f',SA_RC.ID(i))," ", char(SA_RC.Region(i)));

saveas(gcf,strcat(FileDir_Matlab,"/",FileName,"_","SA-DLR-EMPA.fig"))
saveas(gcf,strcat(FileDir_jpg,"/",FileName,"_","SA-DLR-EMPA.jpg"))

close all
    
end