function res = feature_selection(white,red, tableNames)
% Machine Learning For Signal Processing
% Final Project - Feature Selection
% Author: Cara Oehlert
% Input Parameters: 
% red - red wine dataset with all features
% white - white wine dataset with all features
% tableNames = cell array of features string names

res = 0;
% Make sure red and white wine datasets have the same number of features
if(size(red, 2) == size(white, 2))
    numFeatures = size(red, 2);
else
    fprintf("Cant proceed, red and wine datasets do not have matching features");
    return;
end

numClusters = 4; % K value for clustering
totalRedSamples = size(red, 1);
totalWhiteSamples = size(white, 1);
colors = ["blue", "green", "magenta", "red"];%, "black", "cyan", "yellow"];

for feature_i = 1:numFeatures
    if ~strcmp(cell2mat(tableNames(feature_i)) , 'quality')
        % Cluster the red and wine datasets independently
        redClusters = kmeans(red(:, feature_i), numClusters);
        whiteClusters = kmeans(white(:, feature_i), numClusters);

        figure; subplot(1, 2, 1);
        sgtitle(cell2mat(tableNames(feature_i)));
        for k = 1:numClusters
            plot(red(redClusters==k, feature_i),'.','Markersize',20,'color',colors(k)) ;
            hold on;
        end
        ylabel('Normalized Value');
        xlabel('Sample Number')
        title('Red Wine');

        subplot(1, 2, 2);
        for k = 1:numClusters
            plot(white(whiteClusters==k, feature_i),'.','Markersize',20,'color',colors(k)) ;
            hold on;
        end
        ylabel('Normalized Value');
        xlabel('Sample Number')
        title('White Wine')

        % Create the Gaussian Mixture Model
        minRedVal = min(red(:, feature_i));
        maxRedVal = max(red(:, feature_i));
        xRed = minRedVal:0.01:maxRedVal; % data sample vector
        minWhiteVal = min(white(:, feature_i));
        maxWhiteVal = max(white(:, feature_i));
        xWhite = minWhiteVal:0.01:maxWhiteVal; % data sample vector

        %preallocate an array for each gaussian
        gaussianRed = zeros(numClusters, length(xRed));
        gaussianWhite = zeros(numClusters, length(xWhite));

        figure; subplot(1, 3, 1);
        for i = 1:k
            sigma = std(red(redClusters == i, feature_i));
            mu = mean(red(redClusters == i, feature_i));
            numSamplesInClusterK = length(red(redClusters == i, feature_i));
            gaussianWeightingFactor = numSamplesInClusterK/totalRedSamples;
            gaussianRed(i, :) = gaussianWeightingFactor .* 1/(sigma*sqrt(2*pi)) .* exp(-((xRed-mu).^2 / (2*sigma^2)));
            temp = gaussianRed(i, :);
            tempSum = sum(temp);
            plot(xRed, gaussianRed(i, :)); hold on;
        end
        title('Red Wine Clustered Gaussian Distributions')

        subplot(1, 3, 2);
        for i = 1:k
            sigma = std(white(whiteClusters == i, feature_i));
            mu = mean(white(whiteClusters == i, feature_i));
            numSamplesInClusterK = length(white(whiteClusters == i, feature_i));
            gaussianWeightingFactor = numSamplesInClusterK/totalWhiteSamples;
            gaussianWhite(i, :) = gaussianWeightingFactor .* 1/(sigma*sqrt(2*pi)) .* exp(-((xWhite-mu).^2 / (2*sigma^2)));
            temp = gaussianWhite(i, :);
            tempSum = sum(temp);
            plot(xWhite, gaussianWhite(i, :)); hold on;
        end
        title('White Wine Clustered Gaussian Distributions')

        % compute the gaussian mixtures (sum of weighted gaussians)
        gaussianMixtureModelRed = sum(gaussianRed);
        gaussianMixtureModelWhite = sum(gaussianWhite);
        subplot(1, 3, 3);
        plot(xRed, gaussianMixtureModelRed);
        hold on;
        plot(xWhite, gaussianMixtureModelWhite);
        title('Gaussian Mixture Model')
        legend('Red Wine', 'White Wine');
        sgtitle(cell2mat(tableNames(feature_i)));
    end
end
res= 1;