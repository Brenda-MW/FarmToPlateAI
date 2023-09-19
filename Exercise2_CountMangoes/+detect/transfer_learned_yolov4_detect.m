function [outImg, Bboxes] = transfer_learned_yolov4_detect(I, threshold)
    [outImg,Bboxes] = detect.yolov4_detection_mex(I, threshold);
end