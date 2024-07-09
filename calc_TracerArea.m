function TracerArea=calc_TracerArea(SA,EMPA,DLR,SA_RC,Row)
TracersID=import_tracers_ID;
TracerArea=table;
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

    [~,DLR_Start]    = min(abs(datenum(DLR.Date)-datenum(SA_RC.DLR_Start(i))));
    [~,DLR_End]      = min(abs(datenum(DLR.Date)-datenum(SA_RC.DLR_End(i))));

    [~,EMPA_Start]    = min(abs(datenum(EMPA.Date)-datenum(SA_RC.EMPA_Start(i))));
    [~,EMPA_End]      = min(abs(datenum(EMPA.Date)-datenum(SA_RC.EMPA_End(i))));
    
    SA_Plume   = SA(SA_Start:SA_End,:);
    DLR_Plume  = DLR(DLR_Start:DLR_End,:);
    EMPA_Plume = EMPA(EMPA_Start:EMPA_End,:);
    
    for j=1:21
            DLR_Tracer=DLR_Plume.(genvarname(strcat('Tracer',num2str(j))));
            EMPA_Tracer=EMPA_Plume.(genvarname(strcat('Tracer',num2str(j))));
            
            WS_DLR = sqrt(DLR_Plume.U_f.^2+DLR_Plume.V_f.^2);
            WS_EMPA = sqrt(EMPA_Plume.U_f.^2+EMPA_Plume.V_f.^2);
            
            DLR_PlumeArea  = sum(DLR_Plume.CH4_OMV .* DLR_Plume.Dis2.*WS_DLR)/1000;
            EMPA_PlumeArea  = sum(EMPA_Plume.CH4_OMV .* EMPA_Plume.Dis2.*WS_EMPA)/1000;
            
            DLR_TracerArea = (sum(DLR_Tracer .* DLR_Plume.Dis2.*WS_DLR)/1000)/DLR_PlumeArea;
            EMPA_TracerArea = (sum(EMPA_Tracer .* EMPA_Plume.Dis2.*WS_EMPA)/1000)/EMPA_PlumeArea;

            TracerArea.(genvarname(strcat('DLR_EMPA',num2str(j))))(i)=DLR_TracerArea*EMPA_TracerArea;
            TracerArea.(genvarname(strcat('DLR_Tracer',num2str(j))))(i)=DLR_TracerArea;
            TracerArea.(genvarname(strcat('EMPA_Tracer',num2str(j))))(i)=EMPA_TracerArea;
    end
end
    