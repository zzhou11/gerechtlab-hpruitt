function [min] = getMinTrack(data)
%   GETMAXTRACK Returns the smallest track number in a set of data

%   loop through the first column of track numbers

min = intmax;
for i = 1:size(data, 1)
    if data(i) < min
        min = data(i);
    end
end

end