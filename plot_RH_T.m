function plot_RH_T(SA_RC)

%% Temperature
figure
subplot(2,1,1)
    Alt     = str2num(char(extractBefore(SA_RC.SA_Alt,"±")));
    Alt_err = str2num(char(extractAfter(SA_RC.SA_Alt,"±")));
    
    SA_Temp = str2num(char(extractBefore(SA_RC.SA_T,"±")));
    SA_Temp_Err = str2num(char(extractAfter(SA_RC.SA_T,"±")));
    
    DLR_Temp= str2num(char(extractBefore(SA_RC.DLR_T,"±")));
    DLR_Temp_Err= str2num(char(extractAfter(SA_RC.DLR_T,"±")));

    EMPA_Temp= str2num(char(extractBefore(SA_RC.EMPA_T,"±")));
    EMPA_Temp_Err= str2num(char(extractAfter(SA_RC.EMPA_T,"±")));
    
    subplot(2,1,1)
        errorbar(SA_Temp,DLR_Temp,DLR_Temp_Err,DLR_Temp_Err,SA_Temp_Err,SA_Temp_Err,"LineStyle","none","LineWidth",2)
        hold on
        gscatter(SA_Temp, DLR_Temp,SA_RC.Region,[],[],50);
        xlabel('Temperature measured - SA', 'FontSize', 20,'fontweight','bold')
        ylabel('Temperature modelled - DLR', 'FontSize', 20,'fontweight','bold')
        %lgd=legend('Interpreter', 'none');
        %lgd.FontSize=18;
        x= linspace(min(SA_Temp),max(SA_Temp));  
        y2=x;
        hold on
        plot(x,y2,'r--','DisplayName','1:1 Line','LineWidth',2.5);
        ax=gca;
        ax.FontSize = 16;
        grid on
        grid minor
        hold off
        
    subplot(2,1,2)
        errorbar(SA_Temp,EMPA_Temp,EMPA_Temp_Err,EMPA_Temp_Err,SA_Temp_Err,SA_Temp_Err,"LineStyle","none","LineWidth",2)
        hold on
        gscatter(SA_Temp, EMPA_Temp,SA_RC.Region,[],[],50);
        xlabel('Temperature measured - SA', 'FontSize', 20,'fontweight','bold')
        ylabel('Temperature modelled - EMPA', 'FontSize', 20,'fontweight','bold')
        %lgd=legend('Interpreter', 'none');
        %lgd.FontSize=18;
        x= linspace(min(SA_Temp),max(SA_Temp));  
        y2=x;
        hold on
        plot(x,y2,'r--','DisplayName','1:1 Line','LineWidth',2.5);
        ax=gca;
        ax.FontSize = 16;
        grid on
        grid minor
        hold off
        
    ttl=suptitle('Measured and Modelled Temperature');
    ttl.FontSize = 24;

%% Relative Humidity
figure
subplot(2,1,1)    
    SA_RH = str2num(char(extractBefore(SA_RC.SA_RH,"±")));
    SA_RH_Err = str2num(char(extractAfter(SA_RC.SA_RH,"±")));
    
    DLR_RH= str2num(char(extractBefore(SA_RC.DLR_RH,"±")));
    DLR_RH_Err= str2num(char(extractAfter(SA_RC.DLR_RH,"±")));

    EMPA_RH= str2num(char(extractBefore(SA_RC.EMPA_RH,"±")));
    EMPA_RH_Err= str2num(char(extractAfter(SA_RC.EMPA_RH,"±")));
    
    subplot(2,1,1)
        errorbar(SA_RH,DLR_RH,DLR_RH_Err,DLR_RH_Err,SA_RH_Err,SA_RH_Err,"LineStyle","none","LineWidth",2)
        hold on
        gscatter(SA_RH, DLR_RH,SA_RC.Region,[],[],50);
        xlabel('Relative Humidity measured - SA', 'FontSize', 20,'fontweight','bold')
        ylabel('Relative Humidity modelled - DLR', 'FontSize', 20,'fontweight','bold')
        %lgd=legend('Interpreter', 'none');
        %lgd.FontSize=18;
        x= linspace(min(SA_RH),max(SA_RH));  
        y2=x;
        hold on
        plot(x,y2,'r--','DisplayName','1:1 Line','LineWidth',2.5);
        ax=gca;
        ax.FontSize = 16;
        grid on
        grid minor
        hold off
        
    subplot(2,1,2)
        errorbar(SA_RH,EMPA_RH,EMPA_RH_Err,EMPA_RH_Err,SA_RH_Err,SA_RH_Err,"LineStyle","none","LineWidth",2)
        hold on
        gscatter(SA_RH, EMPA_RH,SA_RC.Region,[],[],50);
        xlabel('Relative Humidity measured - SA', 'FontSize', 20,'fontweight','bold')
        ylabel('Relative Humidity modelled - EMPA', 'FontSize', 20,'fontweight','bold')
        x= linspace(min(SA_RH),max(SA_RH));  
        y2=x;
        hold on
        plot(x,y2,'r--','DisplayName','1:1 Line','LineWidth',2.5);
        %lgd=legend('Interpreter', 'none');
        %lgd.FontSize=18;
        ax=gca;
        ax.FontSize = 16;
        grid on
        grid minor
        hold off
    ttl=suptitle('Measured and Modelled Relative Humidity');
    ttl.FontSize = 24;
end