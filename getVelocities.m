function [outputData] = getVelocities(data,trackNumber, time_interval)
%   GETMSD Returns a matrix of time (col 1) vs. average velocity between 2 slices (col 2) of a track in a dataset. 
%   Returns empty if slice is not > 1
%   Assume time = 0 at slice 1, slices must start at 1 in ascending
%   order, time_interval should be constant for the track. Track should
%   have slice number in col 1, x in col 2, y in col 3.
outputData = [];
track = getTrack(data, trackNumber);

%   Loop over all slices from slice 2
for i = 2:(size(track, 1))
    %   Calculate the (x, y) for current slice and the previous
    x1 = track(i-1, 2);
    y1 = track(i-1, 3);
    x2 = track(i, 2);
    y2 = track(i, 3);
    %   Calculate MSD
    velocity = sqrt((x2 - x1)^2 + (y2 - y1)^2)/time_interval;
    %   Input the data into a table of time vs MSD, assuming slice 1 = time
    %   zero and time_interval is constant
    outputData = [outputData; (i - 1) * time_interval, velocity];
end


end