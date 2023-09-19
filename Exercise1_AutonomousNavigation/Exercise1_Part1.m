classdef Exercise1_Part1 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        UIAxes                       matlab.ui.control.UIAxes
        GridLayout                   matlab.ui.container.GridLayout
        LeftPanel                    matlab.ui.container.Panel
        CenterPanel                  matlab.ui.container.Panel
        RightPanel                   matlab.ui.container.Panel
        
        LoadPreBuiltScenarioLabel    matlab.ui.control.Label
        LoadRegularGridFarmButton    matlab.ui.control.Button
        LoadNonregularFarmButton     matlab.ui.control.Button
        DividerLabel1                matlab.ui.control.Label    
        DividerLabel2                matlab.ui.control.Label
        
        BuildYourOwnScenarioLabel    matlab.ui.control.Label
        AddTreesObstaclesButton      matlab.ui.control.Button
        AddWaypointsButton           matlab.ui.control.Button
        AddWaypointsLabel            matlab.ui.control.Label

        ResetScenarioLabel           matlab.ui.control.Label   
        ResettheScenarioButton       matlab.ui.control.Button

        RunSimulationLabel           matlab.ui.control.Label
        RunSimulationButton          matlab.ui.control.Button
        Exercise1Label               matlab.ui.control.Label
        NavigateMangoFarmLabel       matlab.ui.control.Label
        
        GHC2023FarmToPlateAILabel    matlab.ui.control.Label
        DigitalQuadcoptorImage       matlab.ui.control.Image
        DroneImage                   matlab.ui.control.Image
        MathWorksLogoImage           matlab.ui.control.Image
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
        twoPanelWidth = 768;
    end

    properties (Access = public)
        sData % Description
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            
            app.sData = SceneCreationData;

            app.UIFigure.Name = "Autonomous Navigation on a Farm";
            
            % Create UIAxes
            title(app.UIAxes," ")
            plot(app.UIAxes, 0,0, '+');
            grid(app.UIAxes, 'on');
            axis(app.UIAxes, 'equal');
            
            % Set axis
            xlim(app.UIAxes, [-20 20]);
            ylim(app.UIAxes, [-20 20]);
        end
        
        % Button pushed function: LoadRegularGridFarmButton
        function LoadRegularGridFarmButtonPushed(app, event)
            app.LoadRegularGridFarmButton.Enable = false;
            app.LoadNonregularFarmButton.Enable = false;
            app.AddTreesObstaclesButton.Enable = false;
            app.AddWaypointsButton.Enable = false;
            app.RunSimulationButton.Enable = true;
            
            % Add trees for regular grid farm scenario
            isFullScenarioLoad = 1;
            [xRegularFarmObstacles, yRegularFarmObstacles] = meshgrid(-12.5:12.5:12.5, -15:10:15);
            regularFarmObstacles.IntersectionPoint = [xRegularFarmObstacles(:) yRegularFarmObstacles(:)];
            updateObstacleLocation(app.UIAxes, regularFarmObstacles, app.sData, isFullScenarioLoad);
            
            % Add waypoints for regular grid farm scenario
            regularGridFarmWaypoints.IntersectionPoint = [-17.5 -17.5; -17.5 17.5;
                                                          -7.5 17.5; -7.5 -17.5;
                                                           7.5 -17.5; 7.5 17.5;
                                                           17.5 17.5; 17.5 -17.5];
            updateWaypointsLocation(app.UIAxes, regularGridFarmWaypoints, app.sData);
        end

        % Button pushed function: LoadIrregularGridFarmButton
        function LoadNonregularFarmButtonPushed(app, event)
            app.LoadNonregularFarmButton.Enable = false;
            app.LoadRegularGridFarmButton.Enable = false;
            app.AddTreesObstaclesButton.Enable = false;
            app.AddWaypointsButton.Enable = false;
            app.RunSimulationButton.Enable = true;
            
            % Add trees for non-regular farm scenario
            isFullScenarioLoad = 1;
            nonregularFarmObstacles.IntersectionPoint = [-15 9.8; -15.7 2.1;
                                                        -6.5 5.7; 7.8 4.9;
                                                         16.1 4.8; 10.3 -8;
                                                         3.7 -14.7; 14.4 -15.1];
            updateObstacleLocation(app.UIAxes, nonregularFarmObstacles, app.sData, isFullScenarioLoad);
            
            % Add waypoints for irregular grid farm scenario
            nonregularFarmWaypoints.IntersectionPoint = [-12 -9.4; -11.3 13.4;
                                                            2.9 13.9; 12.3 9.3;
                                                            11.1 -1.4; 16.3 -8.4;
                                                            8.3 -15.6];
            updateWaypointsLocation(app.UIAxes, nonregularFarmWaypoints, app.sData);
        end

        % Button pushed function: AddTreesObstaclesButton
        function AddTreesObstaclesButtonPushed(app, event)
            app.AddTreesObstaclesButton.Enable = false;
            app.LoadRegularGridFarmButton.Enable = false;
            app.LoadNonregularFarmButton.Enable = false;
            app.UIAxes.ButtonDownFcn = @(~,data)updateObstacleLocation(app.UIAxes, ...
                                                data, app.sData);
        end

        % Button pushed function: ResettheScenarioButton
        function ResettheScenarioButtonPushed(app, event)
            cla(app.UIAxes)
            app.LoadRegularGridFarmButton.Enable = true;
            app.LoadNonregularFarmButton.Enable = true;
            app.AddTreesObstaclesButton.Enable = true;
            app.AddWaypointsButton.Enable = true;
            app.RunSimulationButton.Enable = false;
            app.UIAxes.ButtonDownFcn = [];
            startupFcn(app);
        end

        % Button pushed function: AddWaypointsInterestPointsButton
        function AddWaypointsButtonPushed(app, event)
            app.AddTreesObstaclesButton.Enable = false;
            app.AddWaypointsButton.Enable = false;
            app.LoadRegularGridFarmButton.Enable = false;
            app.LoadNonregularFarmButton.Enable = false;
            app.RunSimulationButton.Enable = true;
            app.UIAxes.ButtonDownFcn = @(~,data)updateWaypointsLocation(app.UIAxes, data, app.sData);
        end

        % Button pushed function: CreatetheScenarioButton
        function CreatetheScenarioButtonPushed(app, event)
            assignin('base','sceneData',app.sData);
            app.RunSimulationButton.Enable = false;
            Exercise1_Part1_helper;
            evalin('base','Exercise1_Part2');
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 3x1 grid
                app.GridLayout.RowHeight = {474, 474, 474};
                app.GridLayout.ColumnWidth = {'1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 1;
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 3;
                app.RightPanel.Layout.Column = 1;
            elseif (currentFigureWidth > app.onePanelWidth && currentFigureWidth <= app.twoPanelWidth)
                % Change to a 2x2 grid
                app.GridLayout.RowHeight = {474, 474};
                app.GridLayout.ColumnWidth = {'1x', '1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = [1,2];
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 2;
            else
                % Change to a 1x3 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {220, '1x', 158};
                app.LeftPanel.Layout.Row = 1;
                app.LeftPanel.Layout.Column = 1;
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 2;
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 3;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 878 474];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {220, '1x', 158};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.BackgroundColor = [0.8 0.8 0.8];
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;
            
            % Create LoadRegularGridFarmLabel
            app.LoadPreBuiltScenarioLabel = uilabel(app.LeftPanel);
            app.LoadPreBuiltScenarioLabel.WordWrap = 'on';
            app.LoadPreBuiltScenarioLabel.FontWeight = 'bold';
            app.LoadPreBuiltScenarioLabel.Position = [12 350 195 44];%[12 344 195 44];
            app.LoadPreBuiltScenarioLabel.Text = "Load pre-built scenario:";

            % Create LoadRegularGridFarmButton
            app.LoadRegularGridFarmButton = uibutton(app.LeftPanel, 'push');
            app.LoadRegularGridFarmButton.ButtonPushedFcn = createCallbackFcn(app, @LoadRegularGridFarmButtonPushed, true);
            app.LoadRegularGridFarmButton.Tooltip = {'Load regular grid farm'};
            app.LoadRegularGridFarmButton.Position = [12 325 160 23];
            app.LoadRegularGridFarmButton.Text = 'Load Regular Grid Farm';

            % Create LoadIrregularGridFarmButton
            app.LoadNonregularFarmButton = uibutton(app.LeftPanel, 'push');
            app.LoadNonregularFarmButton.ButtonPushedFcn = createCallbackFcn(app, @LoadNonregularFarmButtonPushed, true);
            app.LoadNonregularFarmButton.Tooltip = {'Load non-regular farm'};
            app.LoadNonregularFarmButton.Position = [12 290 160 23];
            app.LoadNonregularFarmButton.Text = 'Load Non-Regular Farm';
            
            % Create ExerciseDividerLabel1
            app.DividerLabel1 = uilabel(app.LeftPanel);
            app.DividerLabel1.WordWrap = 'on';
            app.DividerLabel1.FontWeight = 'bold';
            app.DividerLabel1.Position = [12 240 195 44];
            app.DividerLabel1.Text = string(strcat(repmat('-',1,48)));

            % Create BuildYourOwnScenarioLabel
            app.BuildYourOwnScenarioLabel = uilabel(app.LeftPanel);
            app.BuildYourOwnScenarioLabel.WordWrap = 'on';
            app.BuildYourOwnScenarioLabel.FontWeight = 'bold';
            app.BuildYourOwnScenarioLabel.Position = [12 213 195 44];
            app.BuildYourOwnScenarioLabel.Text = "Build your own scenario:";

            % Create AddTreesObstaclesButton
            app.AddTreesObstaclesButton = uibutton(app.LeftPanel, 'push');
            app.AddTreesObstaclesButton.ButtonPushedFcn = createCallbackFcn(app, @AddTreesObstaclesButtonPushed, true);
            app.AddTreesObstaclesButton.Tooltip = {'Add trees'};
            app.AddTreesObstaclesButton.Position = [12 188 135 23];
            app.AddTreesObstaclesButton.Text = 'Add Trees (Obstacles)';

            % Create AddWaypointsButton
            app.AddWaypointsButton = uibutton(app.LeftPanel, 'push');
            app.AddWaypointsButton.ButtonPushedFcn = createCallbackFcn(app, @AddWaypointsButtonPushed, true);
            app.AddWaypointsButton.Tooltip = {'Add Waypoints'};
            app.AddWaypointsButton.Position = [8 153 184 23];
            app.AddWaypointsButton.Text = 'Add Waypoints (Interest Points)';

            % Create AddWaypointsLabel
            app.AddWaypointsLabel = uilabel(app.LeftPanel);
            app.AddWaypointsLabel.WordWrap = 'on';
            app.AddWaypointsLabel.FontSize = 10;
            app.AddWaypointsLabel.FontAngle = 'italic';
            app.AddWaypointsLabel.Position = [11 103 184 52];
            app.AddWaypointsLabel.Text = "Note - Start with ""Add Trees"", then click on the center plot to place your obstacles (trees). Repeat the steps for waypoints.";
            
            % Create DividerLabel2
            app.DividerLabel2 = uilabel(app.LeftPanel);
            app.DividerLabel2.WordWrap = 'on';
            app.DividerLabel2.FontWeight = 'bold';
            app.DividerLabel2.Position = [12 72 195 44];
            app.DividerLabel2.Text = string(strcat(repmat('-',1,48)));

            % Create ResetScenarioLabel
            app.ResetScenarioLabel = uilabel(app.LeftPanel);
            app.ResetScenarioLabel.WordWrap = 'on';
            app.ResetScenarioLabel.FontWeight = 'bold';
            app.ResetScenarioLabel.Position = [12 37 195 44];
            app.ResetScenarioLabel.Text = "Clear scenario to create a new one:";

            % Create ResettheScenarioButton
            app.ResettheScenarioButton = uibutton(app.LeftPanel, 'push');
            app.ResettheScenarioButton.ButtonPushedFcn = createCallbackFcn(app, @ResettheScenarioButtonPushed, true);
            app.ResettheScenarioButton.Tooltip = {'This option will clear the obstacles and waypoints from the space'};
            app.ResettheScenarioButton.Position = [37 11 124 23];
            app.ResettheScenarioButton.Text = 'Reset Scenario';

            % Create CenterPanel
            app.CenterPanel = uipanel(app.GridLayout);
            app.CenterPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.CenterPanel.Layout.Row = 1;
            app.CenterPanel.Layout.Column = 2;

            % Create UIAxes
            app.UIAxes = uiaxes(app.CenterPanel);
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @updateAppLayout, true);
            app.UIAxes.Position = [36 77 416 334];

            % Create RunSimulationButton
            app.RunSimulationButton = uibutton(app.CenterPanel, 'push');
            app.RunSimulationButton.ButtonPushedFcn = createCallbackFcn(app, @CreatetheScenarioButtonPushed, true);
            app.RunSimulationButton.BackgroundColor = [0.3922 0.8314 0.0745];
            app.RunSimulationButton.Enable = false;
            app.RunSimulationButton.FontSize = 15;
            app.RunSimulationButton.Tooltip = {'Click here if you are ready to run the simulation'};
            app.RunSimulationButton.Position = [145 15 195 35];
            app.RunSimulationButton.Text = 'Run Simulation!';

            % Create NavigateMangoFarmLabel
            app.NavigateMangoFarmLabel = uilabel(app.CenterPanel);
            app.NavigateMangoFarmLabel.FontName = 'Arial Black';
            app.NavigateMangoFarmLabel.FontSize = 20;
            app.NavigateMangoFarmLabel.Position = [129 435 290 27];
            app.NavigateMangoFarmLabel.Text = 'Navigate a Mango Farm';

            % Create Exercise1Label
            app.Exercise1Label = uilabel(app.CenterPanel);
            app.Exercise1Label.HorizontalAlignment = 'center';
            app.Exercise1Label.FontName = 'Arial Black';
            app.Exercise1Label.FontSize = 20;
            app.Exercise1Label.Position = [200 410 134 27];
            app.Exercise1Label.Text = 'Exercise 1';

            % Create RunSimulationLabel
            app.RunSimulationLabel = uilabel(app.CenterPanel);
            app.RunSimulationLabel.FontWeight = 'bold';
            app.RunSimulationLabel.Position = [110 35 363 52];
            app.RunSimulationLabel.WordWrap = true;
            app.RunSimulationLabel.Text = 'Once ready, click below to see your drone fly!';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.BackgroundColor = [0.8 0.8 0.8];
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 3;

            % Create MathWorksLogoImage
            app.MathWorksLogoImage = uiimage(app.RightPanel);
            app.MathWorksLogoImage.Position = [17 24 122 55];
            app.MathWorksLogoImage.ImageSource = fullfile(pathToMLAPP, 'mathworks.svg');

            % Create DroneImage
            app.DroneImage = uiimage(app.RightPanel);
            app.DroneImage.Position = [17 277 122 135];
            app.DroneImage.ImageSource = fullfile(pathToMLAPP, 'FarmDrone.jpg');

            % Create DigitalQuadcoptorImage
            app.DigitalQuadcoptorImage = uiimage(app.RightPanel);
            app.DigitalQuadcoptorImage.Position = [12 162 127 152];
            app.DigitalQuadcoptorImage.ImageSource = fullfile(pathToMLAPP, 'Quadcoptor_Sim.PNG');

            % Create GHC2023FarmToPlateAILabel
            app.GHC2023FarmToPlateAILabel = uilabel(app.RightPanel);
            app.GHC2023FarmToPlateAILabel.FontWeight = 'bold';
            app.GHC2023FarmToPlateAILabel.Position = [2 168 152 52];
            app.GHC2023FarmToPlateAILabel.Text = pad("GHC 2023",23,"left") + newline + pad("Farm-to-Plate AI",25,"left");

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Exercise1_Part1

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
