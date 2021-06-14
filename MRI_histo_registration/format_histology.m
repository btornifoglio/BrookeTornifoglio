BF = imread('2599-Sample01-VF-BF.png');
figure(1), imshow(BF,'displayrange',[])

SAF = imread('2599-Sample01-VF-SAF.png');
figure(2), imshow(SAF,'displayrange',[])

mask = SAF > 0;
figure(3), imshow(mask,'displayrange',[])

maskedBF = bsxfun(@times, BF, cast(mask, 'like', BF));
figure, imshow(maskedBF,'displayrange',[])

bg = ~mask;
bg = repmat(uint8(bg.*255),[1 1 3]);
figure(4), imshow(bg,'displayrange',[])

bg_maskedBF = bg + maskedBF;
% bg_maskedBF = flipud(bg + maskedBF); % use this option if required
figure(5), imshow(bg_maskedBF,'displayrange',[])
imwrite(bg_maskedBF,'histology_BF_masked.png')

SAF = im2uint8(SAF >1);
% SAF = flipud(im2uint8(SAF >1)); % use this option if required
figure(6), imshow(SAF,'displayrange',[])

imwrite(SAF,'histology_SAF_masked.png')
