% Performs getConfinemntRatioImaris on a file for all tracks, returns as a
% N x 1 .xlsx file. Input must be a .csv Imaris file with Col 1: X, Col 2:
% Y, Col 7: Time, Col 8: Track ID, and time must be in ascending order.

% Navigate, opens a UI for choosing input and output folder
[file, path] = uigetfile('*.csv');
oldFolder = cd(path);
destination = uigetdir;
fprintf('Running confinement ratio... \n');

%   Extracts usable data
rawData = readtable(file);
newData = [rawData{:,1}, rawData{:,2}, rawData{:,7}, rawData{:,8}];
%   Format for newData : x, y, time, track ID

%   Obtain usable tracks, defined as tracks that end at max time. 
usableTracks  = [];
maxTime = newData(size(newData,1), 3);
for i = 1:size(newData, 1)
    if newData(i, 3) == maxTime
        usableTracks = [usableTracks; newData(i, 4)];
    end
end

results = [];
%   Loop over all tracks
for i = 1:size(usableTracks, 1)
    results = [results; usableTracks(i, 1), getConfinementRatioImaris(newData, usableTracks(i, 1))]; 
end

header = {'Track ID', 'Confinement Ratio'};
cd(destination);
output = [header; num2cell(results)];
writecell(output, strcat(file, ' confinement ratio results.xlsx'));
cd(oldFolder);
fprintf('Finished running. \n');