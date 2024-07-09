function plotPA_INCAS(Plume_Area)
Plume_Area(12:13,:)=[];

INCAS   =  Plume_Area.INCAS_PlumeArea;
DLR     =  Plume_Area.DLR_PlumeArea;
EMPA    =  Plume_Area.EMPA_PlumeArea;
Region  =  Plume_Area.Region;

Fig=figure;
ax1=subplot(1,2,1);
    gscatter(INCAS, DLR,Region,[],[],70);
        title('Plume Area - Measurement vs Simulation', 'FontSize', 15,'fontweight','bold')
        xlabel('Measurement (ppm.m) - INCAS', 'FontSize', 15,'fontweight','bold')
        ylabel('Simulation (ppm.m) - DLR', 'FontSize', 15,'fontweight','bold')

        ax=gca;
        ax.FontSize = 16;
        grid on
        grid minor
x= linspace(0,max(INCAS));  
y1=0.43*x;
y2=x;
hold on
plot(x,y1,'r--','DisplayName','Regression Line','LineWidth',2.5);
plot(x,y2,'k--','DisplayName','1:1 Line','LineWidth',2.5);

        lgd=legend('Interpreter', 'none');
        lgd.FontSize=18;

ax2=subplot(1,2,2);
    gscatter(INCAS, EMPA,Region,[],[],70);
        title('Plume Area - Measurement vs Simulation', 'FontSize', 24,'fontweight','bold')
        xlabel('Measurement (ppm.m) - INCAS', 'FontSize', 20,'fontweight','bold')
        ylabel('Simulation (ppm.m) - EMPA', 'FontSize', 20,'fontweight','bold')
        lgd=legend('Interpreter', 'none');
        lgd.FontSize=18;
        ax=gca;
        ax.FontSize = 16;
        linkaxes([ax1,ax2],'x'); 
        grid on
        grid minor
        
x= linspace(0,max(INCAS));  
y1=0.33*x;
y2=x;
hold on
plot(x,y1,'r--','DisplayName','Regression Line','LineWidth',2.5);
plot(x,y2,'k--','DisplayName','1:1 Line','LineWidth',2.5);
        
% Create textbox
annotation(Fig,'textbox',...
    [0.277083333333333 0.34040047114252 0.0868055555555558 0.0636042402826854],...
    'String',{'Y = 0.43 * X','R^{2} = 0.61'},...
    'FontSize',18,...
    'FontName','Helvetica Neue',...
    'FitBoxToText','off');

% Create textbox
annotation(Fig,'textbox',...
    [0.758333333333334 0.316843345111896 0.0805555555555559 0.061248527679621],...
    'String',{'Y = 0.33 * X','R^{2} = 0.92'},...
    'FontSize',18,...
    'FontName','Helvetica Neue',...
    'FitBoxToText','off');
end