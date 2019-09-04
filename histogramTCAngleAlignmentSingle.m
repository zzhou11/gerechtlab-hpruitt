%   Plots the results of a sinle getTCAngleAlignment on a histogram

[file, path] = uigetfile('*.csv');
oldFolder = cd(path);
results = getTCAngleAlignment(file);
histogram(results);
title(file);
ylabel('Number of tracks');
xlabel('Alignment Degree');
cd(oldFolder);