classdef SceneCreationData < handle
    %SceneCreationData 
    %   Class for creating UAV simulation scenario.

    properties
        ObstacleXY = zeros(0, 2);
        WaypointsXY = zeros(0, 2);
    end

    methods
        function reset(obj)
            obj.ObstacleXY = zeros(0,2);
            obj.WaypointsXY = zeros(0,2);
        end

    end
end

