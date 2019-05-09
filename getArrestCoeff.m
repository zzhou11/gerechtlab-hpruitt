function [outputData] = getArrestCoeff(data, threshold)
%getArrestCoeff returns a matrix containing the arrest coefficient of each
%track in an Nx2 maxtrix. Column 1 is the track number, column 2 is the
%arrest coefficient.

outputData = [];
maxTrackIndex = getMaxTrack(data);

for i=1:maxTrackIndex;  %run through every track 
    velocities = getVelocities(data,i,1); %get a matrix with the velocities of the current track
    arrestCounter = 0; %this will count the number of time intervals where the cell is arrested
    velocitySize = size(velocities,1);
    if velocitySize == 0;
       continue
    end
    
    for j=1:velocitySize; %loop through every value of velocity        
        if  velocities(j,2) < threshold %if this velocity is considered arrested
            arrestCounter = arrestCounter+1;
        end
    end
    
    arrestCoeff = arrestCounter/velocitySize; %velocitySize is the number of slices minus 1-possible OBOB
    outputData = [outputData; i,arrestCoeff];
end
end
