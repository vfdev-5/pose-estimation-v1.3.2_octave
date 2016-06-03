addpath("visualization");
if isunix()
  addpath("mex_unix");
elseif ispc()
  addpath("mex_pc");
end

compile;

% load and display model
load('PARSE_model');
%load('BUFFY_model');
%visualizemodel(model);
%disp('model template visualization');
%disp('press any key to continue'); 
%pause;
%visualizeskeleton(model);
%disp('model tree visualization');
%disp('press any key to continue'); 
%pause;

%data_path = '/home/osboxes/Documents/state-farm-distracted-driver-detection/input/train/c0/';
%data_path = '/home/osboxes/Downloads/20160409-pose-release-v1.3.2/code-full/BUFFY/images/buffy_s5e2_original/';
data_path = '/home/osboxes/Downloads/20160409-pose-release-v1.3.2/code-full/PARSE/';

imlist = dir(strcat(data_path,'*.jpg'));

count = 5;
for i = 1:count
    % load and display image
    im = imread([strcat(data_path, imlist(i).name)]);
    disp("Input image size : "); disp(size(im))
    if size(im, 1) > 150 && size(im, 2) > 150
        scale = 150.0/max(size(im, 1), size(im, 2));
        im = double(im);
        im = resize(im, scale);
        disp("Rescaled image size : "); disp(size(im))
        im = uint8(im);
    end
    
    clf; imagesc(im); axis image; axis off; drawnow;

    % call detect function
    tic;
    boxes = detect_fast(im, model, min(model.thresh,-1));
    dettime = toc; % record cpu time
    boxes = nms(boxes, .1); % nonmaximal suppression
    disp("Found boxes:"); disp(size(boxes));
    if size(boxes, 1) == 0 || size(boxes, 2) == 0
        disp("No human pose found");
    else
        colorset = {'g','g','y','m','m','m','m','y','y','y','r','r','r','r','y','c','c','c','c','y','y','y','b','b','b','b'};
        showboxes(im, boxes(1,:), colorset); % show the best detection
        %showboxes(im, boxes, colorset);  % show all detections
    end
    fprintf('detection took %.1f seconds\n',dettime);
    disp('press any key to continue');
    pause;
end

disp('done');
