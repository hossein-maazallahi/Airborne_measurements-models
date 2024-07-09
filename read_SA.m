function SA=read_SA(SA_File);

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 17);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Date", "Time_EPOCH", "Lat", "Lon", "Alt", "WindU", "WindV", "Temperature_C", "RH_percent", "CH4_ppm", "CO2_ppm", "H2O_percent", "C2H6_ppb", "Heading_deg", "GrdSpeed_mps", "AGL_m", "Var17"];
opts.SelectedVariableNames = ["Date", "Time_EPOCH", "Lat", "Lon", "Alt", "WindU", "WindV", "Temperature_C", "RH_percent", "CH4_ppm", "CO2_ppm", "H2O_percent", "C2H6_ppb", "Heading_deg", "GrdSpeed_mps", "AGL_m"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Var17", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var17", "EmptyFieldRule", "auto");
opts = setvaropts(opts, "Date", "InputFormat", "yyyy-MM-dd HH:mm:ss");

% Import the data
SA = readtable(SA_File, opts);

SA.CH4_ppm = SA.CH4_ppm * 1000;
SA.Dis = cumsum(SA.GrdSpeed_mps);

for i = 1:size(SA,1)-1
    SA.Dis2 (i) = SA.Dis(i+1) - SA.Dis(i);
end
SA.Dis2(i+1) = SA.Dis2(i);

%% Clear temporary variables
clear opts
end