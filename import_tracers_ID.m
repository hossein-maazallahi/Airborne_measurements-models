function TracersID=import_tracers_ID
%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Row", "ID"];
opts.VariableTypes = ["double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "ID", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "ID", "EmptyFieldRule", "auto");

% Import the data
TracersID = readtable("/Users/hossein/Documents/Campaigns/ROMEO/Data/Flight/Tracers_ID.csv", opts);


%% Clear temporary variables
clear opts
end