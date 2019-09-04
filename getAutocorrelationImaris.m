function [autocorrelation] = getAutocorrelationImaris(data, trackID)
%GETAUTOCORRELATIONIMARIS Returns a turning angle autocorrelation value for the track. 
%   Data must be Col 1 = x, col 2 = y, col 3 = time, col 4 = track ID, this should ony
%   be used in conjunction with getAutocorrelationImarisAll

%   More positive values of autocorrelation means that the cell is
%   migrating in roughly the same direction. More negative values means the
%   cell switches between different directions. More or less measures
%   "consistency". NaN means not enough slices in a track to determine
%   autocorrelation


%   Initialize variable
autocorrelation = [];

%   Extracts the track as a N x 2 Matrix 
track = []; 
for i = 1:(size(data, 1))
    if data(i, 4) == trackID
        track = [track; data(i, 1), data(i, 2)]; % Assumes that time is ascending
    end
end


%   Calculate the autocorrelation for this track
cosSum = 0;
%   Check if slice number is greater than or equal to 3
if size(track, 1) >= 3
    
%   Loop over all slices from slice 3
    for i = 3:(size(track, 1))
        %   Define the coordinates
        x1 = track(i-2, 1);
        y1 = track(i-2, 2);
        x2 = track(i-1, 1);
        y2 = track(i-1, 2);
        x3 = track(i, 1);
        y3 = track(i, 2);
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
        if mag1 ~= 0 && mag2 ~= 0
            cosSum = cosSum + dot(vec1, vec2) / (mag1 * mag2);
        end
    end
    autocorrelation = cosSum / size(track, 1);
else
    autocorrelation = NaN; 
end 
end

