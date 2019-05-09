function [autocorrelation] = getAutocorrelation(data, trackNumber)
%GETAUTOCORRELATION Returns a turning angle autocorrelation value for the track. Data
%   must be in the standard format of ascending slice number from 1 in in
%   col 2, x in col 3, and y in col 4. If # of slices in track is <= 2,this
%   function returns empty.
%   More positive values of autocorrelation means that the cell is
%   migrating in roughly the same direction. More negative values means the
%   cell switches between different directions. More or less measures
%   "consistency". 

autocorrelation = [];
track = getTrack(data, trackNumber);
cosSum = 0;
%   Check if slice number is greater than or equal to 3
if size(track, 1) >= 3
    
%   Loop over all slices from slice 3
    for i = 3:(size(track, 1))
        %   Define the coordinates
        x1 = track(i-2, 2);
        y1 = track(i-2, 3);
        x2 = track(i-1, 2);
        y2 = track(i-1, 3);
        x3 = track(i, 2);
        y3 = track(i, 3);
        %   Define velocity vectors
        vec1 = [x2 - x1, y2 - y1];
        vec2 = [x3 - x2, y3 - y2];
        %   Calculate the velocity vectors' magnitudes
        mag1 = sqrt(vec1(1)^2 + vec1(2)^2);
        mag2 = sqrt(vec2(1)^2 + vec2(2)^2);
        %   Calculate the cos(theta) via the law of cosines. If the value is
        %   +1, the cell travels in the same direction in over 3 slices, if the
        %   value is -1, the cell travels in opposite directions over 3 slices.
        %   First sum this value, then divide by number of slices to obtain
        %   autocorrelation for this track
        cosSum = cosSum + dot(vec1, vec2) / (mag1 * mag2);
    end
    
    autocorrelation = cosSum / size(track, 1);
end
end

