function bandNum = getWavelength(bands, wv)

% get wavelength (in nm) for various bands

switch bands
    case "violet"
        wavelengthRange = [380 450]; % in nm
    case "blue"
        wavelengthRange = [450 495]; % in nm
    case "green"
        wavelengthRange = [495 570]; % in nm
    case "yellow"
        wavelengthRange = [570 580]; % in nm
    case "orange"
        wavelengthRange = [580 620]; % in nm
    case "red"
        wavelengthRange = [630 750]; % in nm
    case "IR"
        wavelengthRange = [750 1000]; % in nm

end

idx = find(wv>=wavelengthRange(1) & wv<=wavelengthRange(2));
bandNum = idx(randi(length(idx),1,1));

end