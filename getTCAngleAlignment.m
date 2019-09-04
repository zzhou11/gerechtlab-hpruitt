function [results] = getTCAngleAlignment(DataTitle)
%   GETIMARISTCALIGNMENT Uses a .CSV file from Imaris to calculate all T
%   cell track alignment. Computes a vector of all tracks using a track's
%   start and end points. Computes the angle the vector makes with respect
%   to the positive x axis. Does this for all tracks, returns the results
%   of the angles as a 1xN matrix. Only considers tracks that
%   end at max time. 

%   Requirements: Col 1: X, Col 2: Y, Col 7: Time, Col 8: Track ID, and time
%   must be in ascending order


rawData = readtable(DataTitle);
%   Extracts usable data
newData = [rawData{:,1}, rawData{:,2}, rawData{:,7}, rawData{:,8}];
%   Finds max time
maxTime = newData(size(newData, 1), 3); 
validTracksEnd = [];
%   Loops through all data rows and adds all tracks with maxTime
for i = 1:size(newData, 1)
    if newData(i, 3) == maxTime
        validTracksEnd = [validTracksEnd; newData(i, 1), newData(i, 2), newData(i, 4)];
    end
end

%   Loops through data rows again
validTracksStart = [];
for i = 1:size(validTracksEnd, 1)
    for j = 1:size(newData, 1)
        %   The data's ID must match an ID in validTracksEnd,
        if newData(j,4) == validTracksEnd(i, 3)
            validTracksStart = [validTracksStart; newData(j, 1), newData(j, 2), newData(j, 4)];
            break;
        end
    end
end

%   Calculates the angle of each track velocity relative to positive x axis
%   using law of cosines
vectorMatrix = [validTracksEnd(:, 1:2)] - [validTracksStart(:, 1:2)];
magnitudeMatrix = [sqrt(vectorMatrix(:,1).^2 + vectorMatrix(:,2).^2)];
thetaMatrix = [];

for i=1:size(magnitudeMatrix, 1)
    theta = 0;
    if magnitudeMatrix(i) ~= 0
        theta = round(acosd(dot(vectorMatrix(i,:), [1,0]) / (magnitudeMatrix(i))), 2);
    end
    thetaMatrix = [thetaMatrix, theta]; 
end
results = thetaMatrix;
end