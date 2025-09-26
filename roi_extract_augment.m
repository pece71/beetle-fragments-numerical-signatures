%% roi_extract_augment.m
% Interactive ROI extraction, augmentation, and metadata logging
% Output: fragment_metadata.csv and augmented fragment images
% Author: Ronnie O. Serfa Juan

clc; clear; close all;

% === Step 1: Select Input & Output Folder ===
imgFolder = uigetdir([], 'Select Folder with Insect Images');
saveFolder = uigetdir([], 'Select Folder to Save Extracted and Augmented Fragments');

if imgFolder == 0 || saveFolder == 0
    error('Both input and output folders must be selected.');
end

% === Step 2: Prepare Image List and Metadata Header ===
imgFiles = dir(fullfile(imgFolder, '*.jpg'));  % can also use *.png
metadata = {'OriginalImage','FragmentImage','AnatomicalRegion','Species','AugmentationType'};

% === Step 3: Process Each Image ===
for i = 1:length(imgFiles)
    filename = imgFiles(i).name;
    fullPath = fullfile(imgFolder, filename);
    img = imread(fullPath);

    % Display image and select ROI
    figure;
    imshow(img);
    title(['Select ROI for: ', filename]);
    roi = imcrop(img);
    roi_resized = imresize(roi, [256 256]); % standard size for ML compatibility
    close;

    % Ask user for anatomical region and species
    prompt = {'Enter anatomical region (e.g., thorax, elytra, snout):', ...
              'Enter species name (e.g., Sitophilus_zeamais):'};
    dlgtitle = 'Fragment Metadata';
    dims = [1 50];
    definput = {'thorax','Sitophilus_zeamais'};
    answer = inputdlg(prompt, dlgtitle, dims, definput);

    anatomical = strrep(lower(answer{1}), ' ', '_');
    species = strrep(lower(answer{2}), ' ', '_');

    % Define base filename
    ba
