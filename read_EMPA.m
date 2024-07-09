function EMPA = read_EMPA(EMPA_File,SA)

EMPA = table;
EMPA.Date = datetime(ncread(EMPA_File,'time'), 'convertfrom', 'posixtime', 'Format', 'yyyy-MM-dd HH:mm:ss');
EMPA.Lat = ncread(EMPA_File,'lat');
EMPA.Lon = ncread(EMPA_File,'lon');
EMPA.U_f = ncread(EMPA_File,'U_f');
EMPA.V_f = ncread(EMPA_File,'V_f');
T = ncread(EMPA_File,'T_f')+273.15;
EMPA.T_f = ncread(EMPA_File,'T_f');
RH = ncread(EMPA_File,'RH_f');
EMPA.RH = ncread(EMPA_File,'RH_f');
P = ncread(EMPA_File,'P_f')*1e2;
EMPA.P_f = ncread(EMPA_File,'P_f')/1e3;
EMPA.CH4_Bck = ncread(EMPA_File,'CH4_BG_f');
EMPA.CH4_OMV = ncread(EMPA_File,'CH4_OMV_f');
    EMPA.Tracer1 = ncread(EMPA_File,'CH4_OMV01_f');
    EMPA.Tracer2 = ncread(EMPA_File,'CH4_OMV02_f');
    EMPA.Tracer3 = ncread(EMPA_File,'CH4_OMV03_f');
    EMPA.Tracer4 = ncread(EMPA_File,'CH4_OMV04_f');
    EMPA.Tracer5 = ncread(EMPA_File,'CH4_OMV05_f');
    EMPA.Tracer6 = ncread(EMPA_File,'CH4_OMV06_f');
    EMPA.Tracer7 = ncread(EMPA_File,'CH4_OMV07_f');
    EMPA.Tracer8 = ncread(EMPA_File,'CH4_OMV08_f');
    EMPA.Tracer9 = ncread(EMPA_File,'CH4_OMV09_f');
    EMPA.Tracer10 = ncread(EMPA_File,'CH4_OMV10_f');
    EMPA.Tracer11 = ncread(EMPA_File,'CH4_OMV11_f');
    EMPA.Tracer12 = ncread(EMPA_File,'CH4_OMV12_f');
    EMPA.Tracer13 = ncread(EMPA_File,'CH4_OMV13_f');
    EMPA.Tracer14 = ncread(EMPA_File,'CH4_OMV14_f');
    EMPA.Tracer15 = ncread(EMPA_File,'CH4_OMV15_f');
    EMPA.Tracer16 = ncread(EMPA_File,'CH4_OMV16_f');
    EMPA.Tracer17 = ncread(EMPA_File,'CH4_OMV17_f');
    EMPA.Tracer18 = ncread(EMPA_File,'CH4_OMV18_f');
    EMPA.Tracer19 = ncread(EMPA_File,'CH4_OMV19_f');
    EMPA.Tracer20= ncread(EMPA_File,'CH4_OMV20_f');
    EMPA.Tracer21 = ncread(EMPA_File,'CH4_OMV21_f');
        CH4=0;
    for j=1:21
            Tracer=EMPA.(genvarname(strcat('Tracer',num2str(j))));
            CH4=CH4+Tracer;
    end
    EMPA.CH4_OMV=CH4;
    
EMPA.EDF_f = ncread(EMPA_File,'CH4_EDF_f');

qv = 1.607785169.*RH.*exp((17.67.*(T-273.15))./(T-29.65))./(0.263.*P);

CH4_TNO_B = ncread(EMPA_File,'TNO_B_f');
CH4_TNO_D = ncread(EMPA_File,'TNO_D_f');
CH4_TNO_J = ncread(EMPA_File,'TNO_J_f');
CH4_TNO_KL = ncread(EMPA_File,'TNO_KL_f');
EMPA.TNO_f  = (CH4_TNO_B + CH4_TNO_D + CH4_TNO_J + CH4_TNO_KL).*(1./(1-qv)).*1e9;
EMPA.Lakes_f = ncread(EMPA_File,'CH4_LAKES_f');
EMPA.Others_f = ncread(EMPA_File,'CH4_OTHER_f');
EMPA.TNO_OMV = ncread(EMPA_File,'TNO_D_OMV_f').*(1./(1-qv)).*1e9;

EMPA=EMPA(~any(ismissing(EMPA),2),:);

for i=1:size(EMPA,1)
    [~,SA_Index] = min(abs(datenum(SA.Date)-datenum(EMPA.Date(i))));
    EMPA.Dis(i) = SA.Dis(SA_Index);
end

for i = 1:size(EMPA,1)-1
    EMPA.Dis2 (i) = EMPA.Dis(i+1) - EMPA.Dis(i);
end
EMPA.Dis2(i+1) = EMPA.Dis2(i);

end