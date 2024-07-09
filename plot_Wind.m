function plot_Wind(SA_RC)
    SA_WS = str2num(char(extractBefore(SA_RC.SA_WS,"±")));
    SA_WS_Err = str2num(char(extractAfter(SA_RC.SA_WS,"±")));
    SA_WD = str2num(char(extractBefore(SA_RC.SA_WD,"±")));
    SA_WD_Err = str2num(char(extractAfter(SA_RC.SA_WD,"±")));
    
    DLR_WS= str2num(char(extractBefore(SA_RC.DLR_WS,"±")));
    DLR_WS_Err= str2num(char(extractAfter(SA_RC.DLR_WS,"±")));
    DLR_WD= str2num(char(extractBefore(SA_RC.DLR_WD,"±")));
    DLR_WD_Err= str2num(char(extractAfter(SA_RC.DLR_WD,"±")));
    
    EMPA_WS= str2num(char(extractBefore(SA_RC.EMPA_WS,"±")));
    EMPA_WS_Err= str2num(char(extractAfter(SA_RC.EMPA_WS,"±")));
    EMPA_WD= str2num(char(extractBefore(SA_RC.EMPA_WD,"±")));
    EMPA_WD_Err= str2num(char(extractAfter(SA_RC.EMPA_WD,"±")));
    
    figure
    subplot(2,1,1)
        errorbar(SA_WS,DLR_WS,DLR_WS_Err,DLR_WS_Err,SA_WS_Err,SA_WS_Err,"LineStyle","none","LineWidth",2)
        
        hold on
        gscatter(SA_WS, DLR_WS,SA_RC.Region,[],[],50);
        xlabel('Wind Speed measured - SA', 'FontSize', 20,'fontweight','bold')
        ylabel('Wind Speed modelled - DLR', 'FontSize', 20,'fontweight','bold')
        lgd=legend('Interpreter', 'none');
        lgd.FontSize=18;
        x= linspace(min(SA_WS),max(SA_WS));  
        y2=x;
        hold on
        plot(x,y2,'r--','DisplayName','1:1 Line','LineWidth',2.5);
        ax=gca;
        ax.FontSize = 16;
        grid on
        grid minor
        hold off
        
    subplot(2,1,2)
        errorbar(SA_WS,EMPA_WS,EMPA_WS_Err,EMPA_WS_Err,SA_WS_Err,SA_WS_Err,"LineStyle","none","LineWidth",2)
        hold on
        gscatter(SA_WS, EMPA_WS,SA_RC.Region,[],[],50);
        xlabel('Wind Speed measured - SA', 'FontSize', 20,'fontweight','bold')
        ylabel('Wind Speed modelled - EMPA', 'FontSize', 20,'fontweight','bold')
        %lgd=legend('Interpreter', 'none');
        %lgd.FontSize=18;
        x= linspace(min(SA_WS),max(SA_WS));  
        y2=x;
        hold on
        plot(x,y2,'r--','DisplayName','1:1 Line','LineWidth',2.5);
        ax=gca;
        ax.FontSize = 16;
        grid on
        grid minor
        
    ttl=suptitle('Measured and Modelled Wind Speed');
    ttl.FontSize = 24;
    
    figure
    subplot(2,1,1)
        errorbar(SA_WD,DLR_WD,DLR_WD_Err,DLR_WD_Err,SA_WD_Err,SA_WD_Err,"LineStyle","none","LineWidth",2)
        hold on
        gscatter(SA_WD, DLR_WD,SA_RC.Region,[],[],50);
        xlabel('Wind Speed measured - SA', 'FontSize', 20,'fontweight','bold')
        ylabel('Wind Speed modelled - DLR', 'FontSize', 20,'fontweight','bold')
        %lgd=legend('Interpreter', 'none');
        %lgd.FontSize=18;
        x= linspace(min(SA_WD),max(SA_WD));  
        y2=x;
        hold on
        plot(x,y2,'r--','DisplayName','1:1 Line','LineWidth',2.5);
        ax=gca;
        ax.FontSize = 16;
        grid on
        grid minor
        hold off
        
    subplot(2,1,2)
        errorbar(SA_WD,EMPA_WD,EMPA_WD_Err,EMPA_WD_Err,SA_WD_Err,SA_WD_Err,"LineStyle","none","LineWidth",2)
        hold on
        gscatter(SA_WD, EMPA_WD,SA_RC.Region,[],[],50);
        xlabel('Wind Speed measured - SA', 'FontSize', 20,'fontweight','bold')
        ylabel('Wind Speed modelled - EMPA', 'FontSize', 20,'fontweight','bold')
        %lgd=legend('Interpreter', 'none');
        %lgd.FontSize=18;
        x= linspace(min(SA_WD),max(SA_WD));  
        y2=x;
        hold on
        plot(x,y2,'r--','DisplayName','1:1 Line','LineWidth',2.5);
        ax=gca;
        ax.FontSize = 16;
        grid on
        grid minor
        hold off
        
    ttl=suptitle('Measured and Modelled Wind Direction');
    ttl.FontSize = 24;
end