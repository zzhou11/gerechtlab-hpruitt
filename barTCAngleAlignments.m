%   Plots all .csv Imaris T cell tracking files in a folder on a bar graph
%   using getTCAngleAlignment

%   Navigate, opens a UI for choosing folder
oldFolder = cd(uigetdir);
fprintf('Running code...\n');
directory = dir('*.csv');

%   Turning off warning because it's annoying
warning('off', 'MATLAB:table:ModifiedAndSavedVarnames');

%   Creates a cell array of filenames from directory 
csvFileNames = {};
for i=1:length(directory)
    csvFileNames = [csvFileNames, directory(i).name];
end

%   Sort alphabetically
csvFileNames = sort(csvFileNames);

%   Create mean and std and store in results, also renames the files for
%   labeling
results = [];
for i=1:size(csvFileNames, 2)
   thetaMatrix = getTCAngleAlignment(char(csvFileNames(i)));
   results = [results; mean(thetaMatrix), std(thetaMatrix)];
end


%   Plot the bar graph and error bars
bar(results(:,1));
axis tight;
hold on;
set(gca, 'XTickLabel',char(csvFileNames), 'XTick',1:numel(results(:,1)));
errorbar(1:numel(results(:,1)), results(:,1), results(:,2), '.');
xlabel('Samples');
ylabel('Alignment Degrees');
hold off;

%   Ending 
cd(oldFolder);
warning('on','MATLAB:table:ModifiedAndSavedVarnames');
fprintf('Finished running \n');


