function [] = exportToExcel(filename, header,data)
%EXPORTTOEXCEL Exports a data matrix with corresponding column headers to
%excel file, it will overwrite any spreadsheet of its name, if it's a
%unique name, it will create a new file in your MATLAB folder. 
%   Filename must be a string, header must be a 1xN cell array, data must
%   be a matrix. 
%   For example, exportToExcel('newdata', {'Track', 'Value'}, data)

%   Concatenates the filename to filename.xlsx
newfile = strcat(filename, '.xlsx');

%   Exports the header and data to sheet 1. 
writecell(header, newfile, 'Sheet', 1, 'Range', 'A1');
writematrix(data, newfile, 'Sheet', 1, 'Range', 'A2');

end

