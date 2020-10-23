clear all;close all;clc;

red = readtable('winequality-red.csv');
white = readtable('winequality-white.csv');
% Verify that the both the red and the white dataset features are being 
% read in the same order
if isequal(white.Properties.VariableNames, red.Properties.VariableNames)
    tableNames = white.Properties.VariableNames;
else
    %Need to reorder one of the tables so they are in the same order
    %TODO? Not really needed right now but a good check to keep in
end
    
red=table2array(red);
white=table2array(white);

%Feature Selection
res = feature_selection(white,red,tableNames);

%conditioning/normalize data
red=normalize_data(red);
white=normalize_data(white);

%add red versus white column, remove quality
%0 is red, 1 is white
red=feature_extraction(red,0);
white=feature_extraction(white,1);

%combine, make randomly select samples so equal entries of each?
combined = combine_datasets(red,white);

%%svm,bayesion modeling, cross-validation, yadda yadda