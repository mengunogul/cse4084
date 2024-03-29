clear all
close all

%% Simulate 1-D blur and noise
image_original = im2double(imread('Cameraman256.bmp', 'bmp'));
[H, W] = size(image_original);
blur_impulse = fspecial('motion', 7, 0);
image_blurred = imfilter(image_original, blur_impulse, 'conv', 'circular');
noise_power = 1e-4;
randn('seed', 1);
noise = sqrt(noise_power) * randn(H, W);
image_noisy = image_blurred + noise;
 
figure; imshow(image_original, 'border', 'tight');
figure; imshow(image_blurred, 'border', 'tight');
figure; imshow(image_noisy, 'border', 'tight');

%% CLS restoration
alpha = 100;  % you should try different values of alpha
image_cls_restored = cls_restoration(image_noisy, blur_impulse, alpha);
figure; imshow(image_cls_restored, 'border', 'tight');

%% computation of ISNR

noisy_snr = sum((image_original(:) - image_noisy(:)).^ 2, "all");
restored_snr = sum((image_original(:) - image_cls_restored(:)).^ 2, "all");
noisy_isnr = num2str(10*log10(noisy_snr/restored_snr), '%05.2f')
