% This is the code for checking workshop folder
% as part of the Farm-to-Plate AI Workshop presented
% at the GHC 2023

% Run this file to check your environment


% Check permissions for Exercise1
fileName = 'Exercises';
[fid,errmsg] = fopen(fileName, 'w');
if ~isempty(errmsg)&&strcmp(errmsg,'Permission denied') 
    fprintf('\nError: You do not have write permission in the folder containing (%s).\n',fileName);
    fprintf('\nPlease make a copy of the original workshop folder and navigate to it.\n');
    fprintf('You will run the exercises out of the folder copy you created.\n');
else
    fprintf('\nWelcome to the Farm-to-Plate AI Workshop at GHC23!\n');
    fprintf('\nYou have write permission in this folder.\n');
    fprintf('\nInitializing the exercises...\n');
    % Add files to path
    addpath(fullfile(pwd,'Exercise1_AutonomousNavigation'));
    addpath(genpath('Exercise1_AutonomousNavigation'));
    addpath(fullfile(pwd,'Exercise2_CountMangoes'));
    addpath(genpath('Exercise2_CountMangoes'));
    addpath(fullfile(pwd,'Exercise3_RipenessEstimation'));
    addpath(genpath('Exercise3_RipenessEstimation'));
    % These lines initialize the Simulink model for Exercise 1
    load_system('ObstacleAvoidanceDemo.slx');
    %bdclose('ObstacleAvoidanceDemo.slx');
    fprintf('\nEnvironment Check is Complete!\n');
    fprintf('\nEnjoy the workshop!\n');
end
