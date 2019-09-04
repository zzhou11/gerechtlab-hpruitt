function [ratio] = getConfinementRatioImaris(data, trackID)
%   GETCONFINEMENTRATIOSIMARIS Returns the displacement / distance ratio of each track, returns a Nx2 matrix, first column 
%   indicates the track, second column indicates the ratios
%   Data must be from getConfinementRatioImarisAll
%   ConfinementRatio must be between 1 and 0 (inclusive), or NaN if there
%   isn't enough data, -1 if the particle did not move at all

%   Initialize useful variables
ratio = 0;
track = [];
%   Loop over the data to obtain the track of interest
for i = 1:size(data, 1)
    if data(i, 4) == trackID
        track = [track; data(i, 1), data(i, 2)];
    end
end
%   If there is only one or less slice of data, return NaN for that ratio
if size(track,1) <= 1
    ratio = NaN;
else
    %   Calculate the displacement for this track
    xinit = track(1, 1);
    yinit = track(1, 2);
    xfinal = track(end, 1);
    yfinal = track(end, 2);
    displacement = sqrt((xfinal - xinit)^2 + (yfinal - yinit)^2);
    distance = 0;
    
    %   Calculate the distance traveled for this track
    %   loop over the first column of slices
    for j = 1:size(track, 1) - 1
        %   Get the coords for the current slice and the next slice
        x1 = track(j, 1);
        x2 = track(j + 1, 1);
        y1 = track(j, 2);
        y2 = track(j + 1, 2);
        %   Compute their distance
        distance = distance + sqrt((x2 - x1)^2 + (y2 - y1)^2);
    end
    %   Calculate the confinement ratio
    if distance ~= 0
        ratio = displacement/distance;
    else
        ratio = -1;
    end
end
end

