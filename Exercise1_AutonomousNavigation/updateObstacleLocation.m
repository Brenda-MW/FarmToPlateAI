function updateObstacleLocation(ax, data, sceneData, isFullScenarioLoad)
% Update location of trees in the UAV simulation scenario based on the app
% user selection.

arguments
    ax
    data
    sceneData
    isFullScenarioLoad = [];
end

sceneData.ObstacleXY = [sceneData.ObstacleXY; data.IntersectionPoint(:,1:2)];
alpha = linspace(0, 2*pi, 20);

if isFullScenarioLoad
    for k = 1:length(sceneData.ObstacleXY)
        circle = 1*[cos(alpha') sin(alpha')]+sceneData.ObstacleXY(k, :);
        hold(ax, 'on')
        plot(ax, circle(:,1), circle(:,2));
        hold(ax, 'off')
    end
else
    circle = 1*[cos(alpha') sin(alpha')]+sceneData.ObstacleXY(end, :);
    hold(ax, 'on')
    plot(ax, circle(:,1), circle(:,2));
    hold(ax, 'off')
end

end