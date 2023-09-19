function showAllImages()
    p = mfilename('fullpath');
    path_to_data = erase(p, ['+helper' filesep 'showAllImages']);
    imds = imageDatastore([path_to_data filesep 'data']);
    
    images = imds.Files;
    
    tiledlayout(3,4);
    
    % Tile 1
    nexttile
    imshow(images{1})
    title("mango1")
    
    % Tile 2
    nexttile
    imshow(images{2})
    title("mango4")
    
    % Tile 3
    nexttile
    imshow(images{3})
    title("mango7")
    
    % Tile 4
    nexttile
    imshow(images{4})
    title("mango10")
    
    % Tile 5
    nexttile
    imshow(images{5})
    title("mango2")
    
    % Tile 6
    nexttile
    imshow(images{6})
    title("mango5")
    
    % Tile 7
    nexttile
    imshow(images{7})
    title("mango8")
    
    % Tile 8
    nexttile
    imshow(images{8})
    title("mango11")
    
    % Tile 9
    nexttile
    imshow(images{9})
    title("mango3")
    
    % Tile 10
    nexttile
    imshow(images{10})
    title("mango6")
    
    % Tile 11
    nexttile
    imshow(images{11})
    title("mango9")
    
    % Tile 12
    nexttile
    imshow(images{12})
    title("mango12")
end