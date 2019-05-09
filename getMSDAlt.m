function [MSD] = getMSDAlt(data,trackNumber, time_interval)
%   GETMSD Returns a MSD value for a defined track in a dataset.  
%   Returns NaN if slice is not > 1. This the alternate MSD calculations
%   of MSD, which is based off of "ROCK regulates the intermittent mode of
%   interstitial T cell migration in inflamed lungs" by Mrass et al.
%   Assume time = 0 at slice 1, slices must start at 1 in ascending
%   order, time_interval should be constant for the track. Track should
%   have slice number in col 1, x in col 2, y in col 3.
MSD = [];
total_displacement = 0;
track = getTrack(data, trackNumber);

%   Loop over all slices from slice 2
for i = 2:(size(track, 1))
    %   Calculate the (x, y) for current slice and the previous
    x1 = track(i-1, 2);
    y1 = track(i-1, 3);
    x2 = track(i, 2);
    y2 = track(i, 3);
    %   Calculate displacement, and add it to the total displacement 
    total_displacement = total_displacement + sqrt((x2 - x1)^2 + (y2 - y1)^2);
end

%   Calculate MSD
MSD = total_displacement / ((size(track, 1) - 1) * time_interval);


end