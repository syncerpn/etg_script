%edit this
wpn_name = 'radgun';

%done, all others are auto
root_dir = 'E:\SYNCER STUDIO\YT\Enter The Gungeon\weapon_spr\';
save_dir = 'E:\SYNCER STUDIO\YT\Enter The Gungeon\wpn_glow\';

save_folder = [save_dir, wpn_name, '\'];
mkdir(save_folder);

file_list = dir([root_dir wpn_name]);
file_list = {file_list(3:end).name};
n_file = numel(file_list);

for k = 1:n_file
    image_name = file_list{k};

    [img, ~, img_alpha] = imread([root_dir wpn_name '\' image_name]);
    [h, w, c] = size(img);

    %reset texture; if no alpha, set white
    for i = 1:h
        for j = 1:w
            if img_alpha(i,j) == 0
                img(i,j,:) = 255;
            end
        end
    end

    stroked = zeros(h+2, w+2, c, 'uint8') + 255;
    stroked(2:h+1,2:w+1,:) = img;

    stroked2_alpha = zeros(h+4, w+4, 1, 'uint8');
    stroked2_alpha(3:h+2,3:w+2) = img_alpha;
    stroked2_alpha_copy = stroked2_alpha;

    for i = 2:h+3
        for j = 2:w+3
            if (stroked2_alpha_copy(i-1, j) || stroked2_alpha_copy(i+1, j) ...
             || stroked2_alpha_copy(i, j-1) || stroked2_alpha_copy(i, j+1) ...
             || stroked2_alpha_copy(i, j))
                stroked2_alpha(i, j) = 255;
            end
        end
    end
    stroked_alpha = stroked2_alpha(2:h+3, 2:w+3);
%     h = imshow(stroked);
%     set(h, 'AlphaData', stroked_alpha);
    stroked = imresize(stroked, 6, 'nearest');
    stroked_alpha = imresize(stroked_alpha, 6, 'nearest');
    imwrite(stroked,[save_folder image_name],'Alpha',stroked_alpha)
end