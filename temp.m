L = csvread('phone_data/LAB_L.data');
A = csvread('phone_data/LAB_A.data');
B = csvread('phone_data/LAB_B.data');

R = csvread('phone_data/RGB_R.data');
G = csvread('phone_data/RGB_G.data');
B = csvread('phone_data/RGB_B.data');
phone_labels = csvread('phone_data/labels.data');
img = cat(3,R,G,B);
figure; imshow(img/255);

img_LAB = rgb2lab(img);
figure; imshow(mat2gray(LABdist(img_LAB,[64 64])));
phone_LAB = cat(3,L,A,B);
max(img_LAB(:))
min(img_LAB(:))
max(phone_LAB(:))
min(phone_LAB(:))
test = data(:,:,:,1);
max(test(:))
min(test(:))
%phone_LAB
figure; imshow(mat2gray(LABdist(phone_LAB,[64 64])));
figure; imshow(label_image_tree(test,treeset_lab_20)+1,parula(3));
figure; imshow(phone_labels+1,parula(3));