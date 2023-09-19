function [outImg, Bboxes] = yolov4_detect(I, threshold)
    [outImg, Bboxes] = detect.vanilla_yolov4_detection_mex(I, threshold);
end