function plot_C2H6CO2(SA_RC)
txt=SA_RC.CO2_CH4(:);
txt1=extractAfter(txt,":");
    Slope=str2num(char(extractBefore(txt1,"/")));
    CO2_R2=str2num(char(extractAfter(txt1,":")));
    C2H6=SA_RC.C2H6_CH4;
    Region=SA_RC.Region;
    figure
    gscatter(C2H6(CO2_R2>0.6), Slope(CO2_R2>0.6),Region(CO2_R2>0.6),[],[],70);
    gscatter(C2H6, CO2_R2,Region,[],[],70);
        legend('Interpreter', 'none');
        title('Ethane and Carbon Dioxide', 'FontSize', 15,'fontweight','bold')
        xlabel('Ethane : Methane (%)', 'FontSize', 15,'fontweight','bold')
        ylabel('Carbon Dioxide : Methane Correlation (R^{2})', 'FontSize', 15,'fontweight','bold')
        ax=gca;
        ax.FontSize = 24;
        %linkaxes([ax1,ax2],'x'); 
        grid on
        grid minor
end