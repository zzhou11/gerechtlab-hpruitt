

% Performs getTurningAngles on a file for all tracks, plots a graph for
% each track. Input must be a .csv Imaris file with Col 1: X, Col 2:
% Y, Col 7: Time, Col 8: Track ID, and time must be in ascending order.

% Navigate, opens a UI for choosing input and output folder
[file, path] = uigetfile('*.csv');
oldFolder = cd(path);
destination = uigetdir;
fprintf('Running turning angles... \n');

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
cd(destination);
set(0,'DefaultFigureVisible','off');
for i = 1:size(usableTracks, 1)
    [x, y] = getTurningAnglesImaris(newData, usableTracks(i, 1));
    xlabel('Slice');
    ylabel('Turning Angle');
    plot(x, y, ".-", 'MarkerSize', 25);
    title(strcat('Track ID ', num2str(usableTracks(i))));
    saveas(gcf, strcat(file, ' TrackID ', num2str(usableTracks(i)), ' turning angles'), 'jpg'); 
end
cd(oldFolder);
fprintf('Finished running. \n');

set(0,'DefaultFigureVisible','on');


