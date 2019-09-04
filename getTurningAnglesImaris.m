function [slices, resultsAngle] = getTurningAnglesImaris(data,trackID)
%GETTURNINGANGLESIMARIS Takes in usable data from plotTurningAnglesImaris and a track to calculate turning
%angles
%   Returns two 1 x N matrices, one of slices and the corresponding turning angle
%   Returns empty if slice < 3 (cannot analyze turning angle, too few data points).

resultsAngle = [];
slices = [];
track = [];

%   Loop over the data to obtain the track of interest
for i = 1:size(data, 1)
    if data(i, 4) == trackID
        track = [track; data(i, 1), data(i, 2)];
    end
end


theta = 0;
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
        %   Calculate the theta via the law of cosines. If either magnitude
        %   is zero, turning angle is zero.
        if mag1 ~= 0 && mag2 ~= 0
            theta = round(acosd(dot(vec1, vec2) / (mag1 * mag2)), 2);
        end
        
        %   Add the theta to the results, increment slices
        resultsAngle = [resultsAngle, theta];
        slices = [slices, i];
    end
end
end





