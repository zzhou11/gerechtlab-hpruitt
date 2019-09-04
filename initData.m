function [usableData] = initData(DataTitle, usableCols)
%   INITDATA Transforms a raw .xlsx into a processable matrix. usableCol
%   is a 1xN matrix indicating which columns are processd. If
%   usableCols is zero, all columns are used
%   First two column MUST be Track number and slice number
%   The same track numbers should be grouped together, NO ISOLATED TRACKS!
rawData = xlsread(DataTitle);

if usableCols == 0
    usableData = rawData;
else
    usableData = rawData(:,usableCols);
end

end