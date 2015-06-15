H = csvread('H.data');
R = csvread('R.data');
G = csvread('G.data');
B = csvread('B.data');
L = csvread('L.data')
img = cat(3,R,G,B);
figure; imshow(img/255);
figure; imshow(H/255);
[nH,~,~] = rgb2hsv(img);
nH = floor(nH*255+1);
figure; imshow(nH/255);
figure; imshow(L+1,parula(3));
label = label_image(H,treeset(1));
figure; imshow(label+1,parula(3));