% Machine Learning For Signal Processing
% Final Project - Data Conditioning/Feature Extraction as a part of the 
% total data preprocessing for the final project
% Author: Cara Oehlert

clear; close all; clc;

wineFilepath = "redAndWhiteCombined.csv";

% read in the data from the csv file
wine = readtable(wineFilepath);

% Remove the truth data from the table and save it as a seperate variable
quality = wine.quality;
wine.quality = [];
color = wine.wineColor;
wine.wineColor = [];

% standardize the data to zero mean with a std deviation of 1
wine.fixedAcidity = normalize(wine.fixedAcidity);
wine.volatileAcidity = normalize(wine.volatileAcidity);
wine.citricAcid = normalize(wine.citricAcid);
wine.residualSugar = normalize(wine.residualSugar);
wine.chlorides = normalize(wine.chlorides);
wine.freeSulfurDioxide = normalize(wine.freeSulfurDioxide);
wine.totalSulfurDioxide = normalize(wine.totalSulfurDioxide);
wine.density = normalize(wine.density);
wine.pH = normalize(wine.pH);
wine.sulphates = normalize(wine.sulphates);
wine.alcohol = normalize(wine.alcohol);

% Compute the principal components of the dataset and plot the resulting 
% scree plot
[wcoeff,score,latent,tsquared,explained] = pca(table2array(wine));
figure;
pareto(explained)
xlabel('Principal Component')
ylabel('Variance Explained (%)')
title('Scree Plot of PCA output')

tableNames = wine.Properties.VariableNames;

figure;
boxplot(table2array(wine), 'Orientation','horizontal','Labels',tableNames)

