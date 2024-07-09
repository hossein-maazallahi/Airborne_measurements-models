function INCAS=read_INCAS(INCAS_File)
%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 15);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Date", "Lat", "Lon", "AltitudemAGL", "AltitudemMSL", "PressurehPa", "CH4raw", "CH4calibrated", "CH4_dryraw", "CH4_drycalibrated", "COppm", "CO2ppm", "CO2_dryppm", "H2O", "B_H2O_pct"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Date", "InputFormat", "dd/MM/yyyy HH:mm:ss.SSS");

% Import the data
INCAS = readtable(INCAS_File, opts);


%% Clear temporary variables
clear opts


    lat_Ref=mean(INCAS.Lat(:));                    
    lon_Ref=mean(INCAS.Lon(:)); 
    Re=6.378e6;
INCAS.XCart=(INCAS.Lon-lon_Ref).*pi/180.*cos(lat_Ref.*pi/180).*Re; %x Cartesian
INCAS.YCart=(INCAS.Lat-lat_Ref).*pi/180.*Re;  
INCAS.Spd(1) = 0;
INCAS.Dis(1) = 0;

for i=2:size(INCAS,1)
    dt = milliseconds(diff(datetime([INCAS.Date(i-1);INCAS.Date(i)])))/1000;
    INCAS.Dis(i)= sqrt((INCAS.XCart(i)-INCAS.XCart(i-1))^2+(INCAS.YCart(i)-INCAS.YCart(i-1))^2);
    INCAS.Spd(i)= INCAS.Dis(i) / dt;
end

INCAS.Dis2 = cumsum(INCAS.Dis);

INCAS.CH4_drycalibrated = INCAS.CH4_drycalibrated*1000;
%% Clear temporary variables
clear opts
end