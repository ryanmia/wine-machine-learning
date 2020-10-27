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
%res = feature_selection(white,red,tableNames);

%conditioning/normalize data
red=normalize_data(red);
white=normalize_data(white);

%add red versus white column, remove quality
%0 is red, 1 is white
red=feature_extraction(red,0);
white=feature_extraction(white,1);

%combine, make randomly select samples so equal entries of each?
combined = combine_datasets(red,white);

combined_label=combined(:,end);
combined=combined(:,1:end-1);

split=round(size(combined,1)*.9);
data_train=combined(1:split,:)';
data_test=combined(split:end,:)';
label_train=combined_label(1:split,:);
label_test=combined_label(split:end,:);


predicted=knn(100,data_test,data_train,label_train);
correct_rate_knn=get_correct_rate(predicted,label_test)

%fixed acidity, volatile acidity, residual sugars, chlorides, free sulfur dioxide, total sulfur dioxide, and sulphates
%2,5,7,10
data_train=data_train([1, 2, 4, 5, 6, 7, 10],:);
data_test=data_test([1, 2, 4, 5, 6, 7, 10],:);
predicted=knn(5,data_test,data_train,label_train);
correct_rate_knn_lessfeatures=get_correct_rate(predicted,label_test)


%%svm,bayesion modeling, cross-validation, yadda yadda