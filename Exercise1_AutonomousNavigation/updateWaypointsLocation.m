function updateWaypointsLocation(ax, data, sceneData)
% Update location of waypoints in the UAV simulation scenario based on the
% app user selection.

sceneData.WaypointsXY = [sceneData.WaypointsXY; data.IntersectionPoint(:,1:2)];
delete(findobj(ax, 'tag', 'WaypointLine'));
hold(ax, 'on')
line = plot(ax, sceneData.WaypointsXY(:, 1), sceneData.WaypointsXY(:,2), '--kx');
line.Tag = 'WaypointLine';
hold(ax, 'off')
end