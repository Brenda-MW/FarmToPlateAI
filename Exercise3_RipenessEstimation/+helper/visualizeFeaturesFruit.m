function visualizeFeaturesFruit(data, fruitNumber)

% Extract indices of selected fruit over all days
fruitRowIdx = data.FruitNumber == sprintf("%02d", fruitNumber) & ...
    data.FruitDirection == "front";

figure, plot(data{fruitRowIdx,"feature"+string(1:249)}');
title("Mean of hyperspectral image over all wavelengths for fruit " + fruitNumber);
xlabel("Wavelengths (nm)")
ylabel("Mean of hyperspectral image")
legend(data.Response(fruitRowIdx), "location", "best")

end