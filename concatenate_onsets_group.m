base_dir = '/Users/almila/Desktop/stats project copy 4/data/';

for subj = 1:10
    sub_dir = sprintf('%ssub-%03d', base_dir, subj);
    cd (sub_dir)

    fileName = sprintf('all_onsets_goodImag_sub%03d.mat', subj);

% Check if the file exists before loading
    if exist(fileName, 'file')
        % Load the .mat file for the current subject
        load(fileName);

        % Print a message indicating successful loading
        disp(['Loaded file for subject: ', num2str(subj), ' from ', fileName]);
        
    else
        % Print a warning message if the file does not exist
        warning(['File not found for subject: ', num2str(subj), ' (', fileName, ')']);
    end
    TR = 2;
sessions = 6;
conc_onsets = {};

conc_onsets(1,:) = onsets(1,:);
session_vols = [242 242 242 242 242];
for k = 2:sessions
    for j = 1:length(onsets)
        conc_onsets{k,j} = onsets{k,j}+sum(session_vols(1:k-1))*TR;
    end
end

conc_onsets_fin = cell(1,length(onsets));

for n = 1:length(onsets)
    columnData = conc_onsets(:, n);
    
    % Alle Arrays in Spaltenvektoren umwandeln und zusammenfügen
    combinedArray = [];
    for row = 1:length(columnData)
        combinedArray = [combinedArray; columnData{row}(:)];
    end
    
    % In eine einzelne Zelle packen
    conc_onsets_fin{n} = combinedArray;
end

 saveFileName = sprintf('conc_onsets_sub%03d.mat', subj);

        % Save the data with the subject number in the file name
        save(saveFileName, 'conc_onsets_fin');


end
