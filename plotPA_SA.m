function plotPA_SA(SA_RC)
for i=1:28
    SA_RC(SA_RC.ID == i, :) = [];
end

SA_WS     =  SA_RC.SA_PlumeAreaWS;
DLR_WS    =  SA_RC.DLR_PlumeAreaWS;
EMPA_WS   =  SA_RC.EMPA_PlumeAreaWS;

SA_WS_Corr(1:19,:)    = SA_WS(1:19);
SA_WS_Corr(20:23,:)   = SA_WS(20:23)*0.2;
SA_WS_Corr(24:32,:)   = SA_WS(24:32);
SA_WS_Corr(33:36,:)   = SA_WS(33:36)*0.13;
SA_WS_Corr(37:40,:)   = SA_WS(37:40)*0.54;
SA_WS_Corr(41:78,:)   = SA_WS(41:78);
SA_WS_Corr(79:82,:)   = SA_WS(79:82)*0.54;
SA_WS_Corr(83:92,:)   = SA_WS(83:92);
SA_WS_Corr(93:97,:)   = SA_WS(93:97)*0.14;
SA_WS_Corr(98:116,:)  = SA_WS(98:116);
SA_WS_Corr(117:125,:) = SA_WS(117:125)*0.57;
SA_WS_Corr(126:200,:) = SA_WS(126:200);

SA_WS2    = SA_RC.SA_PlumeAreaWS(SA_RC.RegionCluster=="R8" | SA_RC.RegionCluster=="R7" | SA_RC.RegionCluster=="R5aD1" | SA_RC.RegionCluster=="R5aD2");
DLR_WS2   = SA_RC.DLR_PlumeAreaWS(SA_RC.RegionCluster=="R8" | SA_RC.RegionCluster=="R7" | SA_RC.RegionCluster=="R5aD1" | SA_RC.RegionCluster=="R5aD2");
EMPA_WS2  = SA_RC.EMPA_PlumeAreaWS(SA_RC.RegionCluster=="R8" | SA_RC.RegionCluster=="R7" | SA_RC.RegionCluster=="R5aD1" | SA_RC.RegionCluster=="R5aD2");

SA        =  SA_RC.SA_PlumeArea;
DLR       =  SA_RC.DLR_PlumeArea;
EMPA      =  SA_RC.EMPA_PlumeArea;

Region    =  SA_RC.Region;
Region2   =  SA_RC.Region(SA_RC.RegionCluster=="R8" | SA_RC.RegionCluster=="R7" | SA_RC.RegionCluster=="R5aD1" | SA_RC.RegionCluster=="R5aD2");

%% Plot plume areas with wind speed included
Fig=figure;
ax1=subplot(1,2,1);
    gscatter(SA_WS, DLR_WS,Region,[],[],70);
        title('Plume Area - Measurement vs Simulation', 'FontSize', 15,'fontweight','bold')
        xlabel('Measurement (ppm.m^{2} s^{-1}) - SA', 'FontSize', 15,'fontweight','bold')
        ylabel('Simulation (ppm.m^{2} s^{-1}) - DLR', 'FontSize', 15,'fontweight','bold')

        ax=gca;
        ax.FontSize = 16;
        grid on
        grid minor
x= linspace(0,max(SA_WS));  
y1=0.78*x;
y2=x;
hold on
plot(x,y1,'r--','DisplayName','Regression Line','LineWidth',2.5);
plot(x,y2,'k--','DisplayName','1:1 Line','LineWidth',2.5);

        lgd=legend('Interpreter', 'none');
        lgd.FontSize=18;

ax2=subplot(1,2,2);
    gscatter(SA_WS, EMPA_WS,Region,[],[],70);
        title('Plume Area - Measurement vs Simulation', 'FontSize', 24,'fontweight','bold')
        xlabel('Measurement (ppm.m^{2} s^{-1}) - SA', 'FontSize', 20,'fontweight','bold')
        ylabel('Simulation (ppm.m^{2} s^{-1}) - EMPA', 'FontSize', 20,'fontweight','bold')
        lgd=legend('Interpreter', 'none');
        lgd.FontSize=18;
        ax=gca;
        ax.FontSize = 16;
        %linkaxes([ax1,ax2],'x'); 
        grid on
        grid minor
        
x= linspace(0,max(SA_WS));  
y1=0.45*x;
y2=x;
hold on
plot(x,y1,'r--','DisplayName','Regression Line','LineWidth',2.5);
plot(x,y2,'k--','DisplayName','1:1 Line','LineWidth',2.5);
        
% Create textbox
annotation(Fig,'textbox',...
    [0.306944444444444 0.333333333333332 0.0868055555555559 0.0636042402826854],...
    'String',{'Y = 0.78 * X','R^{2} = 0.66'},...
    'FontSize',18,...
    'FontName','Helvetica Neue',...
    'FitBoxToText','off');

% Create textbox
annotation(Fig,'textbox',...
    [0.766666666666667 0.389870435806831 0.0805555555555559 0.061248527679621],...
    'String',{'Y = 0.45 * X','R^{2} = 0.79'},...
    'FontSize',18,...
    'FontName','Helvetica Neue',...
    'FitBoxToText','off');

end