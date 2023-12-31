function visualizeFalseColoredFruit(data, fruitNumber, bands)

% Extract indices of selected fruit over all days
if fruitNumber==4
    fruitNumber = 40;
end
fruitRowIdx = data.FruitNumber == sprintf("%02d", fruitNumber);
X = data.HypercubeStruct(fruitRowIdx);

% Convert hyperspectral data to falsified color images
numFruits = length(X);
bandNums = arrayfun(@(x) helper.getWavelength(x, X(1).Wavelength), bands);
% bandNums = [218 147 2];
X = arrayfun(@(idx) helper.bandVisualization(X(idx).DataCube, ...
    X(idx).Wavelength, bandNums, 'falseColored'), 1:numFruits, "UniformOutput",false);

% disply data in a figure
figure
montage(X,'BorderSize',[10 10],'Size',[1 numFruits])
title("Pseudo-colored Fruit " + fruitNumber + " on days " + ...
    join(extractAfter(string(data.Response(fruitRowIdx)), "day"), ", "))

end