function DLR=read_DLR (FileName,SA,Row)

if     Row == 1
    FileName_Geo = 'ROMEO_ANA_2____20191003_114900_s4d_SCIAVI.nc';
    dd=03;
elseif Row ==2
    FileName_Geo = 'ROMEO_ANA_2____20191007_110500_s4d_SCIAVI.nc';
    dd=07;
elseif Row ==3
    FileName_Geo = 'ROMEO_ANA_2____20191008_065500_s4d_SCIAVI.nc';
    dd=08;
elseif Row ==4
    FileName_Geo = 'ROMEO_ANA_2____20191009_090730_s4d_SCIAVI.nc';
    dd=09;
elseif Row ==5
    FileName_Geo = 'ROMEO_ANA_2____20191010_083430_s4d_SCIAVI.nc';
    dd=10;
elseif Row ==6
    FileName_Geo = 'ROMEO_ANA_2____20191011_090700_s4d_SCIAVI.nc';
    dd=11;
elseif Row ==7
    FileName_Geo = 'ROMEO_ANA_2____20191012_100430_s4d_SCIAVI.nc';
    dd=12;
elseif Row ==8
    FileName_Geo = 'ROMEO_ANA_2____20191015_100330_s4d_SCIAVI.nc';
    dd=15;
elseif Row ==9
    FileName_Geo = 'ROMEO_ANA_2____20191017_095930_s4d_SCIAVI.nc';
    FileName_Geo2= 'ROMEO_ANA_2____20191017_122400_s4d_SCIAVI.nc';
    dd=17;
elseif Row ==10
    FileName_Geo = 'ROMEO_ANA_2____20191018_112530_s4d_SCIAVI.nc';
    dd=18;
elseif Row ==11
    FileName_Geo = 'ROMEO_ANA_2____20191021_105730_s4d_SCIAVI.nc';
    dd=21;
end

FileName_Geo = convertCharsToStrings(strcat("../DLR/Old/",FileName_Geo));

if Row==9
    FileName_Geo2 = convertCharsToStrings(strcat("../DLR/Old/",FileName_Geo2));
end

Time = ncread(FileName,'time');
Time=double(Time-(datenum(2019,09,dd)-datenum(2019,09,21)));
T=datenum(2019,09,dd) + Time;

DLR=table;
DLR.Date=datestr(T, 'yyyy-mm-dd hh:MM:ss');
DLR.Date=datetime(DLR.Date, 'Format', 'yyyy-MM-dd HH:mm:ss');
clear T; clear Time;

lat = ncread(FileName_Geo,'tlat');
lon = ncread(FileName_Geo,'tlon');
if Row==9
    lat2 = ncread(FileName_Geo2,'tlat');
    lon2 = ncread(FileName_Geo2,'tlon');
    
    lat = [lat;lat2];
    lon = [lon;lon2];
end
CH4_Bck = ncread(FileName,'tracer_gp_CH4_fx_f');
CH4_OMV = ncread(FileName,'tracer_gp_CH4OMV_f');
    CH4_OMV_1 = ncread(FileName,'tracer_gp_CH4OMV1_f');
    CH4_OMV_2 = ncread(FileName,'tracer_gp_CH4OMV2_f');
    CH4_OMV_3 = ncread(FileName,'tracer_gp_CH4OMV3_f');
    CH4_OMV_4 = ncread(FileName,'tracer_gp_CH4OMV4_f');
    CH4_OMV_5 = ncread(FileName,'tracer_gp_CH4OMV5_f');
    CH4_OMV_6 = ncread(FileName,'tracer_gp_CH4OMV6_f');
    CH4_OMV_7 = ncread(FileName,'tracer_gp_CH4OMV7_f');
    CH4_OMV_8 = ncread(FileName,'tracer_gp_CH4OMV8_f');
    CH4_OMV_9 = ncread(FileName,'tracer_gp_CH4OMV9_f');
    CH4_OMV_10 = ncread(FileName,'tracer_gp_CH4OMV10_f');
    CH4_OMV_11 = ncread(FileName,'tracer_gp_CH4OMV11_f');
    CH4_OMV_12 = ncread(FileName,'tracer_gp_CH4OMV12_f');
    CH4_OMV_13 = ncread(FileName,'tracer_gp_CH4OMV13_f');
    CH4_OMV_14 = ncread(FileName,'tracer_gp_CH4OMV14_f');
    CH4_OMV_15 = ncread(FileName,'tracer_gp_CH4OMV15_f');
    CH4_OMV_16 = ncread(FileName,'tracer_gp_CH4OMV16_f');
    CH4_OMV_17 = ncread(FileName,'tracer_gp_CH4OMV17_f');
    CH4_OMV_18 = ncread(FileName,'tracer_gp_CH4OMV18_f');
    CH4_OMV_19 = ncread(FileName,'tracer_gp_CH4OMV19_f');
    CH4_OMV_20= ncread(FileName,'tracer_gp_CH4OMV20_f');
    CH4_OMV_21 = ncread(FileName,'tracer_gp_CH4OMV21_f');
CH4_Others = ncread(FileName,'tracer_gp_CH4OTHERS_f');
CH4_Lakes = ncread(FileName,'tracer_gp_CH4LAKES_f');
CH4_EDF = ncread(FileName,'tracer_gp_CH4EDF_f');
U = ncread(FileName,'COSMO_um1_f');
V = ncread(FileName,'COSMO_vm1_f');
T = ncread(FileName,'COSMO_tm1_f')-273.15;
RH = ncread(FileName,'COSMO_rhum_f');
P = ncread(FileName,'COSMO_press_f')/1e5;

CH4_TNO_B = ncread(FileName,'tracer_gp_CH4TNOB_f');
CH4_TNO_D = ncread(FileName,'tracer_gp_CH4TNOD_f');
CH4_TNO_J = ncread(FileName,'tracer_gp_CH4TNOJ_f');
CH4_TNO_KL = ncread(FileName,'tracer_gp_CH4TNOKL_f');
CH4_TNO = (CH4_TNO_B + CH4_TNO_D + CH4_TNO_J + CH4_TNO_KL);
CH4_TNO_OMV = ncread(FileName,'tracer_gp_TNODOMV_f');

DLR.Lat = lat(1:size(DLR.Date));
DLR.Lon = lon(1:size(DLR.Date));
clear lat; clear lon;
DLR.U_f = U;
DLR.V_f = V;
DLR.T_f = T;
DLR.RH = RH;
DLR.P_f = P;

DLR.CH4_Bck = CH4_Bck*1e9;
DLR.CH4_OMV = CH4_OMV*1e9;
    DLR.Tracer1 = CH4_OMV_1*1e9;
    DLR.Tracer2 = CH4_OMV_2*1e9;
    DLR.Tracer3 = CH4_OMV_3*1e9;
    DLR.Tracer4 = CH4_OMV_4*1e9;
    DLR.Tracer5 = CH4_OMV_5*1e9;
    DLR.Tracer6 = CH4_OMV_6*1e9;
    DLR.Tracer7 = CH4_OMV_7*1e9;
    DLR.Tracer8 = CH4_OMV_8*1e9;
    DLR.Tracer9 = CH4_OMV_9*1e9;
    DLR.Tracer10 = CH4_OMV_10*1e9;
    DLR.Tracer11 = CH4_OMV_11*1e9;
    DLR.Tracer12 = CH4_OMV_12*1e9;
    DLR.Tracer13 = CH4_OMV_13*1e9;
    DLR.Tracer14 = CH4_OMV_14*1e9;
    DLR.Tracer15 = CH4_OMV_15*1e9;
    DLR.Tracer16 = CH4_OMV_16*1e9;
    DLR.Tracer17 = CH4_OMV_17*1e9;
    DLR.Tracer18 = CH4_OMV_18*1e9;
    DLR.Tracer19 = CH4_OMV_19*1e9;
    DLR.Tracer20 = CH4_OMV_20*1e9;
    DLR.Tracer21 = CH4_OMV_21*1e9;
    CH4=0;
    for j=1:21
            Tracer=DLR.(genvarname(strcat('Tracer',num2str(j))));
            CH4=CH4+Tracer;
    end
    DLR.CH4_OMV=CH4;
    
DLR.EDF_f = CH4_EDF*1e9;
DLR.TNO_f = CH4_TNO*1e9;
DLR.Lakes_f = CH4_Lakes*1e9;
DLR.Others_f = CH4_Others*1e9;
DLR.TNO_OMV = CH4_TNO_OMV*1e9;
clear CH4_OMV; clear CH4_EDF; clear CH4_Lakes; clear CH4_Others;
clear CH4_A; clear CH4_B; clear CH4_C;
clear CH4_TNO; clear CH4_TNO_B; clear CH4_TNO_D; clear CH4_TNO_J; clear CH4_TNO_KL;

DLR=DLR(~any(ismissing(DLR),2),:);

for i=1:size(DLR,1)
    [~,SA_Index] = min(abs(datenum(SA.Date)-datenum(DLR.Date(i))));
    DLR.Dis(i) = SA.Dis(SA_Index);
end

for i = 1:size(DLR,1)-1
    DLR.Dis2 (i) = DLR.Dis(i+1) - DLR.Dis(i);
end
    DLR.Dis2(i+1) = DLR.Dis2(i);
end