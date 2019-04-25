function [usableData] = initData(DataTitle, usableCols)
%   INITDATA Transforms a raw .xlsx into a processable matrix. usableCol
%   indicates which columns are processed
%   First two column MUST be Track number and slice number
%   The same track numbers should be grouped together, NO ISOLATED TRACKS!
rawData = xlsread(DataTitle);
usableData = rawData(:,1:usableCols);

end