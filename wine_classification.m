clear all;close all;clc;

red = readtable('winequality-red.csv', 'HeaderLines',1);
white = readtable('winequality-white.csv', 'HeaderLines',1);

red=table2array(red);
white=table2array(white);
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