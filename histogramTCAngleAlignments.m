%   Same as histogramTCAngleAlignmentSingle, but performs it over a folder
%   and saves the output images

%   Navigate, opens a UI for choosing input and output folder
inputFolder = uigetdir;
outputFolder = uigetdir;
oldFolder = cd(inputFolder);
fprintf('Running code...\n');
directory = dir('*.csv');

%   Turning off warning because it's annoying
warning('off', 'MATLAB:table:ModifiedAndSavedVarnames');

%   Creates a cell array of filenames from directory 
csvFileNames = {};
for i=1:length(directory)
    csvFileNames = [csvFileNames, directory(i).name];
end
%   Loops through the files, plotting each using getTCAngleAlignment
for i=1:size(csvFileNames, 2)
    cd(inputFolder);
    fileName = char(csvFileNames(i));
    name = char(extractBetween(fileName, 1, strfind(fileName, '_Position') - 1));
    results = getTCAngleAlignment(fileName);
    histogram(results);
    title(name);
    ylabel('Number of tracks');
    xlabel('Alignment Degree');
    cd(outputFolder);
    saveas(gcf, name, 'jpg'); 
end

fprintf('Finished running \n');
warning('on', 'MATLAB:table:ModifiedAndSavedVarnames');
cd(oldFolder);