%% utils/metadata_checks.m
% Validate metadata CSV for naming conformity and completeness
% Usage:
%    metadata_checks('path/to/fragment_metadata.csv')

function metadata_checks(csvFile)
    if nargin < 1
        [file, path] = uigetfile('*.csv','Select metadata CSV file');
        if isequal(file,0)
            error('No file selected.');
        end
        csvFile = fullfile(path,file);
    end

    % Read metadata
    data = readcell(csvFile);
    header = data(1,:);
    rows   = data(2:end,:);

    fprintf('Validating metadata file: %s\n', csvFile);

    % Required columns
    requiredCols = {'OriginalImage','FragmentImage','AnatomicalRegion','Species','AugmentationType'};
    missingCols = setdiff(requiredCols, header);
    if ~isempty(missingCols)
        warning('Missing required columns: %s', strjoin(missingCols, ', '));
    else
        fprintf('✓ All required columns present.\n');
    end

    % Check for empty cells
    [r,c] = find(cellfun(@isempty, rows));
    if ~isempty(r)
        for k=1:numel(r)
            warning('Empty cell at row %d, column %s', r(k)+1, header{c(k)});
        end
    else
        fprintf('✓ No empty cells detected.\n');
    end

    % Check controlled vocabularies
    anatomicalSet = {'thorax','elytra','antenna','snout','head'};
    uniqueAnat = unique(rows(:,3));
    badAnat = setdiff(uniqueAnat, anatomicalSet);
    if ~isempty(badAnat)
        warning('Non-standard anatomical labels found: %s', strjoin(badAnat, ', '));
    else
        fprintf('✓ Anatomical region labels conform.\n');
    end

    fprintf('Metadata validation complete.\n');
end
