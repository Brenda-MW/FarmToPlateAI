function data = loadData()

% get current path of filename
p = mfilename('fullpath');

% extract data file path
[path, ~, ~] = fileparts(p);
path = extractBefore(path, "+helper");

% load data
dataPath = fullfile(path, "HyperspectralFruitData.mat");
data = load(dataPath);

end