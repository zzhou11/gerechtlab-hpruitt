function [outputTrack] = getTrack(data, trackNumber)
%   GETTRACK Given a data matrix, returns the specified track as a matrix,
%   the first column indicates the slices. Returns an empty matrix if no
%   track of the target track number is found


outputTrack = [];
%   Loops through the first column of the data, which are the track numbers
for i = 1:size(data,1)
    
    % Checks if you found the target trackNumber
    if data(i, 1) == trackNumber
        
        % Loop until the end of this track
        startRow = i;
        for j = i:size(data,1)
            % Checks if you reached the end of the track
            if j == size(data,1) || data(j + 1) ~= trackNumber
                endRow = j;
                outputTrack = data(startRow:endRow, 2:end);
                % Reached the end of the slice, break out of this loop
                break
            end
        end
        % Reached the end of the slice, break out of this loop
        break
    end
    
end

end

