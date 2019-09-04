function [] = plotTurningAngles(data, trackNumber)
%PLOTTURNINGANGLES Plots a graph of data's slice # vs turning angle
%   
hold on
[x, y] = getTurningAngles(data, trackNumber);
xlabel('Slice');
ylabel('Turning Angle');
plot(x, y, ".-", 'MarkerSize', 25);
hold off
end

