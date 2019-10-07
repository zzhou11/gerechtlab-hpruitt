function [msd] = getMSDImaris(data, trackID)
%GETMSDIMARIS Returns a MSD value for the track. 
%   Data must be Col 1 = x, col 2 = y, col 3 = x, col 4 = time, col 5 = track ID, this should ony
%   be used in conjunction with getMSDImarisAll

%   NaN means not enough slices in a track to determine MSD


%   Initialize variable
msd = [];

%   Extracts the track as a N x 3 Matrix 
track = []; 
for i = 1:(size(data, 1))
    if data(i, 5) == trackID
        track = [track; data(i, 1), data(i, 2), data(i, 3)]; % Assumes that time is ascending
    end
end


%   Calculate the MSD for this track
msd_sum = 0;
%   Check if slice number is greater than or equal to 2
if size(track, 1) >= 2  
        x0 = track(1, 1);
        y0 = track(1, 2);
        z0 = track(1, 3);
%   Loop over all slices from slice 2
    for i = 2:(size(track, 1))
        %   Define the coordinates
        x = track(i, 1);
        y = track(i, 2);
        z = track(i, 3);
        msd_sum = msd_sum + (x - x0)^2 + (y - y0)^2 + (z - z0)^2;
    end
    msd = msd_sum / size(track, 1);
else
    msd = NaN; 
end 
end

