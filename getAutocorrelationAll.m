function [results] = getAutocorrelationAll(data)
%GETAUTOCORRELATIONALL Runs getAutocorrelation on all tracks and returns
%   the results as a Nx1 table. 

results = [];
maxTrackIndex = getMaxTrack(data);
%   Loop over all tracks
for i = 1:maxTrackIndex
    track = getTrack(data, i);
    %   Check that the track is not empty, that is, a valid track is found
    if ~isempty(track)
        auto = getAutocorrelation(data, i);
        if ~isempty(auto) % Checks to see if autocorrelation is empty
            results = [results; i, getAutocorrelation(data, i)];
        else % Not enough slices to determine
            results = [results; i, NaN];
        end
    end
end

end

