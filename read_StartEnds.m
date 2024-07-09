function SA_RC=read_StartEnds
%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 96);

% Specify sheet and range
opts.Sheet = "Circles";
opts.DataRange = "A2:CR201";

% Specify column names and types
opts.VariableNames = ["ID", "RegionCluster", "Region", "SA_Start", "SA_End", "DLR_Start", "DLR_End", "EMPA_Start", "EMPA_End", "SA_PlumeAreaWS", "DLR_PlumeAreaWS", "EMPA_PlumeAreaWS", "SA_PlumeArea", "DLR_PlumeArea", "EMPA_PlumeArea", "SA_WS", "DLR_WS", "EMPA_WS", "SA_WD", "DLR_WD", "EMPA_WD", "SA_Alt", "SA_T", "DLR_T", "EMPA_T", "SA_RH", "DLR_RH", "EMPA_RH", "SA_Bck", "DLR_Bck", "EMPA_Bck", "CO2_CH4", "C2H6_CH4", "Tracer1", "Tracer2", "Tracer3", "Tracer4", "Tracer5", "Tracer6", "Tracer7", "Tracer8", "Tracer9", "Tracer10", "Tracer11", "Tracer12", "Tracer13", "Tracer14", "Tracer15", "Tracer16", "Tracer17", "Tracer18", "Tracer19", "Tracer20", "Tracer21", "DLR_Tracer1", "EMPA_Tracer1", "DLR_Tracer2", "EMPA_Tracer2", "DLR_Tracer3", "EMPA_Tracer3", "DLR_Tracer4", "EMPA_Tracer4", "DLR_Tracer5", "EMPA_Tracer5", "DLR_Tracer6", "EMPA_Tracer6", "DLR_Tracer7", "EMPA_Tracer7", "DLR_Tracer8", "EMPA_Tracer8", "DLR_Tracer9", "EMPA_Tracer9", "DLR_Tracer10", "EMPA_Tracer10", "DLR_Tracer11", "EMPA_Tracer11", "DLR_Tracer12", "EMPA_Tracer12", "DLR_Tracer13", "EMPA_Tracer13", "DLR_Tracer14", "EMPA_Tracer14", "DLR_Tracer15", "EMPA_Tracer15", "DLR_Tracer16", "EMPA_Tracer16", "DLR_Tracer17", "EMPA_Tracer17", "DLR_Tracer18", "EMPA_Tracer18", "DLR_Tracer19", "EMPA_Tracer19", "DLR_Tracer20", "EMPA_Tracer20", "DLR_Tracer21", "EMPA_Tracer21"];
opts.VariableTypes = ["double", "string", "string", "datetime", "datetime", "datetime", "datetime", "datetime", "datetime", "double", "double", "double", "double", "double", "double", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, ["RegionCluster", "Region", "SA_WS", "DLR_WS", "EMPA_WS", "SA_WD", "DLR_WD", "EMPA_WD", "SA_Alt", "SA_T", "DLR_T", "EMPA_T", "SA_RH", "DLR_RH", "EMPA_RH", "SA_Bck", "DLR_Bck", "EMPA_Bck", "CO2_CH4"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["RegionCluster", "Region", "SA_WS", "DLR_WS", "EMPA_WS", "SA_WD", "DLR_WD", "EMPA_WD", "SA_Alt", "SA_T", "DLR_T", "EMPA_T", "SA_RH", "DLR_RH", "EMPA_RH", "SA_Bck", "DLR_Bck", "EMPA_Bck", "CO2_CH4"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "SA_Start", "InputFormat", "");
opts = setvaropts(opts, "SA_End", "InputFormat", "");
opts = setvaropts(opts, "DLR_Start", "InputFormat", "");
opts = setvaropts(opts, "DLR_End", "InputFormat", "");
opts = setvaropts(opts, "EMPA_Start", "InputFormat", "");
opts = setvaropts(opts, "EMPA_End", "InputFormat", "");

% Import the data
SA_RC = readtable("../Regions_Clusters.xlsx", opts, "UseExcel", false);


%% Clear temporary variables
clear opts
end