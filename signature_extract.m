%% signature_extract.m
% Compute numerical signature descriptors from fragment images
% Output: fragment_signatures.csv
% Author: Ronnie Serfa Juan

clear; clc;

% === Step 1: Select Folder with Fragment Images ===
imgFolder = uigetdir([], 'Select Folder with Fragment Images');
if imgFolder == 0
    error('No folder selected.');
end

% === Step 2: Prepare Image List ===
imgFiles = dir(fullfile(imgFolder, '*.png')); % or .jpg
if isempty(imgFiles)
    error('No PNG/JPG images found in the selected folder.');
end

% === Step 3: Initialize Results Table ===
results = {'ImageName','Species','AnatomicalRegion','Resolution',...
           'Skewness','Kurtosis','Entropy','StdDev'};

% === Step 4: Loop Over Images ===
for i = 1:length(imgFiles)
    filename = imgFiles(i).name;
    fullPath = fullfile(imgFolder, filename);
    img = imread(fullPath);

    % Convert to grayscale
    grayImg = rgb2gray(img);

    % Compute descriptors
    stdVal = std2(grayImg);
    entropyVal = entropy(grayImg);
    skewVal = skewness(double(grayImg(:)));
    kurtVal = kurtosis(double(grayImg(:)));

    % Try to parse labels from filename
    tokens = split(filename, '_');
    if numel(tokens) >= 2
        species = tokens{1};
        anatomical = tokens{2};
    else
        species = 'unknown';
        anatomical = 'unknown';
    end

    % Resolution info
    [rows, cols, ~] = size(img);
    resStr = sprintf('%dx%d', cols, rows);

    % Append to results
    results(end+1,:) = {filename, species, anatomical, resStr, ...
                        skewVal, kurtVal, entropyVal, stdVal};
end

% === Step 5: Save Results to CSV ===
outFile = fullfile(imgFolder, 'fragment_signatures.csv');
writecell(results, outFile);

fprintf('Signature extraction complete. Results saved to: %s\n', outFile);
