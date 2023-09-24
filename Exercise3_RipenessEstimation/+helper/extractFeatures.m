function data = extractFeatures(data)

warning('off', 'MATLAB:table:RowsAddedNewVars');
for i = 1:height(data)
    data{i,"feature"+string(1:249)} = ...
        squeeze(mean(data.HypercubeStruct(i).DataCube, [1 2]))';
end
warning('on', 'MATLAB:table:RowsAddedNewVars');
end