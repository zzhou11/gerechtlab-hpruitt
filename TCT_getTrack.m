function [outputTrack] = TCT_getTrack(trackNumber,data)
%   TCT_GETTRACK Given a data matrix, returns the track as a matrix,
%   the first column indicates the slices. Returns an empty matrix if no
%   track is found

outputTrack = [];

for i = 1:numel(data)
    % Checks if you found the target trackNumber
    if data(i) == trackNumber 
        
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
    
    % Checks if the loop has reached the end of the column of trackNumbers,
    % if it did, it means no track of the corresponding trackNumber has
    % been found, returns an empty matrix             
    if i == size(data,1) 
        break                               
    end  
end
     
end

