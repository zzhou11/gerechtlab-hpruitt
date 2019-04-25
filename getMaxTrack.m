function [max] = getMaxTrack(data)
%   GETMAXTRACK Returns the maximum track number in a set of data

%   loop through the first column of track numbers

max = -1;
for i = 1:size(data,1)
    if data(i) > max
        max = data(i);
    end
end

end

