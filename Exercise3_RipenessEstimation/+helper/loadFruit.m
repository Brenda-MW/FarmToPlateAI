function hcubeStruct = loadFruit(data, fruitNumber, day)

% Retrieve data for this day
data = data(data.Response=="day"+sprintf("%02d", day),:);

% retrieve data for this fruit
hcubeStruct = data.HypercubeStruct(fruitNumber);
end