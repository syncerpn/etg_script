file = 'D:\Programs\obs-studio\presets\sc2_key_overlay_x.png';
[im, ~, img_alpha] = imread(file);
k_h = 32;
k_w = 32;

[im_h, im_w, ~] = size(im);
kbp_h = im_h / 2;
kbp_w = im_w;

n_h = kbp_h / k_h;
n_w = kbp_w / k_w;

out_h = n_h * 2 * k_h + (n_h * 2 - 1) * 3 + 1;
out_w = n_w * k_w + (n_w - 1) * 3 + 1;

out = 255*ones(out_h, out_w, 3, 'uint8');
out_alpha = zeros(out_h, out_w, 'uint8');

for i = 1:n_h
    for j = 1:n_w
        ii = k_h * (i-1);
        ij = k_w * (j-1);
        oi = (k_h + 3) * (i-1) * 2;
        oj = (k_w + 3) * (j-1);
        out(oi+1:oi+k_h, oj+1:oj+k_w, :) = im(ii+1:ii+k_h, ij+1:ij+k_w, :);
        out_alpha(oi+1:oi+k_h, oj+1:oj+k_w) = img_alpha(ii+1:ii+k_h, ij+1:ij+k_w);
        
        ii = k_h * (i-1) + kbp_h;
        ij = k_w * (j-1);
        oi = (k_h + 3) * (i-1) * 2 + k_h + 3;
        oj = (k_w + 3) * (j-1);
        out(oi+1:oi+k_h, oj+1:oj+k_w, :) = im(ii+1:ii+k_h, ij+1:ij+k_w, :);
        out_alpha(oi+1:oi+k_h, oj+1:oj+k_w) = img_alpha(ii+1:ii+k_h, ij+1:ij+k_w);
    end
end
imshow(out);
imwrite(out,'D:\Programs\obs-studio\presets\sc2_key_overlay.png','Alpha',out_alpha)