clear all;close all;clc;

red = readtable('winequality-red.csv', 'HeaderLines',1);

white = readtable('winequality-white.csv', 'HeaderLines',1);

%conditioning
normalize_data(red);
normalize_data(white);

%add red versus white column, remove quality
feature_extraction(red);
feature_extraction(white);

%combine, make randomly select samples so equal entries of each?
combined = combine_datasets(red,white);

%%svm,bayesion modeling, cross-validation, yadda yadda