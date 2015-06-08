clear all
close all
clc
 
%% CONSTANTS
count = 0;
laplace_matrix = fspecial('laplacian');
%N IS GIVEN AN ARBITRARY VALUE GREATER THAN 10 SO THAT WE CAN ENTER THE WHILE LOOP
n = 11;
 
%% IMAGE INPUT
img = imread('blob_detection_input1.jpg');
img = rgb2gray(img);
%img = img(:,:,1);
pyr_down_img = img; %% HOLDS THE CURRENT PYRAMID LEVEL PICTURE
 
%% PYRDOWN ALGORITHM AND SPOT DETECTION
%RUN THE LOOP TILL LESS THAT 10 GOOD SPOTS ARE PRESENT
while(n > 10)
 
    % COUNTS THE LEVEL OF THE PYRAMID AND FINALLY HAS THE HEIGHT
    count = count + 1
    pyr_down_img = impyramid(pyr_down_img,'reduce');
    % EDGE DETECTOR TO FIND THE SPOTS
    Spot_img = imfilter(pyr_down_img,laplace_matrix);
    n = 0;
    [M N] = size(Spot_img);
%     for i = 1:M
%         for j = 1:N
%             if(Spot_img(i,j) >= 0.6*max(max(Spot_img))) % FINDING PROMINANT SPOTS
% 
%                 %SAVE THE No. OF SPOTS IN n , COMPARE n TO SEE IF THE WHILE LOOP SHOULD CONTINUE
%                 n = n+1;
%             end
%         end
%     end
    vals = (Spot_img >= 0.6*max(Spot_img(:)));
    n = sum(vals(:));
end % END OF WHILE LOOP
imshow(pyr_down_img);
 
%% FINDING THE BEST (BRIGHTEST) SPOT
figure,imshow(Spot_img,[]);
[M N] = size(Spot_img);
% for i = 1:M
%     for j = 1:N
%         if(Spot_img(i,j) == max(max(Spot_img)))
%             x_cord = i;
%             y_cord = j;
%         end
%     end
% end
[~,ind] = max(Spot_img(:));
[x_cord y_cord] = ind2sub(size(Spot_img),ind);
%% FINDING THAT SPOT ON THE ORIGINAL IMAGE, WE TRY TO FIND A REGION IN
%%WHICH THE OBJECT MIGHT BE PRESENT
 
[M N] = size(img); % SIZE OF ORIGINAL IMAGE
 
% IF THE CALCULATED PIXEL IS OUT OF BOUND,USE THE SIZE VALUE OF %IMAGE
orig_x = min([x_cord*(2^count),M]);
orig_y = min([y_cord*(2^count),N]);
top_left_x = orig_x - ((2^(count-1))-1);
top_left_y = orig_y - ((2^(count-1))-1) ;
 
% ESTIMATED REGION IN WHICH OBJECT MAY BE PRESENT
ROI = img(top_left_x:orig_x,top_left_y:orig_y);
 
%% INITIAL ESTIMATE FOR THE THRESHOLD IS AVERAGE OF THE GREYSCALE VALUES IN THE ROI
initial_estimate_thresh = uint8(mean(ROI(:)));
background_estimate = uint8(mean(img(:)));
 
%% DEPENDING UPON THE KIND OF OBJECT AND BACKGROUNG , THE INITIAL OR BACKGROUND ESTIMATE MAY BE HIGHER THAN THE OTHER
%%HERE IS A METHOD TO MAKE THE CODE WORK IN BOTH THE CONDITIONS
upper_level = max([initial_estimate_thresh, background_estimate]);
lower_level = min([initial_estimate_thresh, background_estimate]);
 
%CAN'T LET ANY INDEX BE ZERO
lower_level = max([lower_level,1]);
 
%% ACCEPTING THE HISTOGRAM VALUES OF THE IMAGE IN AN ARRAY AND
%%SLICING IT IN THE TWO THRESHOLD RANGES
plot_array = imhist(img);
plot_array = plot_array(lower_level:upper_level);
plot(plot_array);
 
% THE LOWEST VALLEY CORRESPONDS TO THE THRESHOLD VALUE
[amount thresh_value] = min(plot_array);
 
%% FINAL THRESH VALUE IS
thresh = lower_level + thresh_value;
 
%% COMPLETE THRESHOLD OF THE IMAGE
thresh_img = zeros(M,N);
for i = 1:M
    for j = 1:N
        if(img(i,j) >= thresh)
            thresh_img(i,j) = 0;
            else thresh_img(i,j) = 255;
        end
    end
end
figure,imshow(thresh_img,[]);