function [SA_File, EMPA_File, DLR_File] = read_Directories(Row)
%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ["\t../", ","];

% Specify column names and types
opts.VariableNames = ["Row", "SA", "EMPA", "DLR"];
opts.VariableTypes = ["double", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["SA", "EMPA", "DLR"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["SA", "EMPA", "DLR"], "EmptyFieldRule", "auto");

% Import the data
Directories = readtable("../Directories.txt", opts);
%% Clear temporary variables
clear opts


SA_File     = Directories.SA(Row);
EMPA_File   = Directories.EMPA(Row);
DLR_File    = Directories.DLR(Row);
