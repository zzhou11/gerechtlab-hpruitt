function [outputData] = getConfinementRatios(data)
%   GETCONFINEMENTRATIOS
%   Slices must be in ascending order, only analyzes tracks number 1 at up
%   (i.e., if track 0 or < 0 exists, it will not be analyzed). It also must
%   be contained in column 1
%   X value must be in column 3, Y value must be in column 4 of the data
%   if distance traveled = 0 (t cell did not move), output = -1
%   ConfinementRatio must be between 1 and 0 (inclusive)

%   Initialize useful variables
outputData = [];
maxTrackIndex = getMaxTrack(data);

%   Loop over all possible tracks, note that not all track may exist, in
%   which case that track is empty and should not be included in the final
%   outputData
for i = 1:maxTrackIndex
   
    track = getTrack(data, i);
    
    %   Check that the track is not empty, that is, a valid track is found
    if ~isempty(track)
        
        %   Calculate the displacement for this track
        xinit = track(1, 2);
        yinit = track(1, 3);
        xfinal = track(end, 2);
        yfinal = track(end, 3);
        displacement = sqrt((xfinal - xinit)^2 + (yfinal - yinit)^2);
        distance = 0;
        
        %   Calculate the distance traveled for this track
        %   loop over the first column of slices
        for j = 1:size(track, 1) - 1
            %   Get the coords for the current slice and the next slice
            x1 = track(j, 2);
            x2 = track(j + 1, 2);
            y1 = track(j, 3);
            y2 = track(j + 1, 3);
            %   Compute their distance
            distance = distance + sqrt((x2 - x1)^2 + (y2 - y1)^2);
        end
        
        %   Calculate the confinement ratio and append it to outputData
        %   If cell did not move, or if there is only one slice of data,
        %   return -1 for that ratio
        if distance == 0
            ratio = -1;
        else
            ratio = displacement/distance;
        end
        outputData = [outputData; i, ratio];
    end
    
end
end

