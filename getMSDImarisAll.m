% Performs getMSDImaris on a file for all tracks, returns as a
% N x 1 .xlsx file. Input must be a .csv Imaris file with Col 1: X, Col 2:
% Y, Col 3: Z, Col 7: Time, Col 8: Track ID, and time must be in ascending order.

% Navigate, opens a UI for choosing input and output folder
fprintf('Choose the .csv file to be analyzed\n');
[file, path] = uigetfile('*.csv');
fprintf('%s\n',path)
oldFolder = cd(path);
destination = uigetdir;
fprintf('Running getMSD... \n');
cd(oldFolder);

%   Extracts usable data
rawData = readtable(strcat(path,file));
newData = [rawData{:,1}, rawData{:,2}, rawData{:,3}, rawData{:,7}, rawData{:,8}];
%   Format for newData : x, y, z, time, track ID

%   Obtain usable tracks, defined as tracks that start at time 1
usableTracks  = [];
time = 1;
for i = 1:size(newData, 1)
    if newData(i, 4) == time
        usableTracks = [usableTracks; newData(i, 5)];
    end
end

results = [];
%   Loop over all tracks
for i = 1:size(usableTracks, 1)
    results = [results; usableTracks(i, 1), getMSDImaris(newData, usableTracks(i, 1))]; 
end

header = {'Track ID', 'MSD'};
cd(destination);
output = [header; num2cell(results)];
writecell(output, strcat(file, ' MSD results.xlsx'));
cd(oldFolder);
fprintf('Finished running. \n');