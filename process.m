
corr_nii = 'c2p_corr.nii';

na_nii = 'c2p_hr.nii';

% Reslice correction map to high-resolution 23Na images.
auxil_spm_reslice({na_nii}, {corr_nii});

corr_nii = ['r', corr_nii];

% Load 
na_img = auxil_nii_load_dimg(na_nii);
corr_img = auxil_nii_load_dimg(corr_nii);

% Intensity correction map
corr_img = corr_img / 100;
corr_img(corr_img < 0.8) = 0.8;
corr_img(corr_img > 6.0) = 6.0;

% Denoise
na_den_img = na_img;

for idx = 1: size(na_img, 4)
    [na_den_img(:,:,:,idx), ~] = auxil_denoise_bm4d(na_img(:,:,:,idx), 'sigma', 2);
end

% Intensity Correction
na_den_corr_img = na_den_img;
for idx = 1: size(na_img, 4)
    na_den_corr_img(:,:,:,idx) = na_den_img(:,:,:,idx) ./ corr_img;
end

% Mask
msk = auxil_msk_auto(na_den_img(:,:,:,1), 0.5);
msk(1:3,:,:) = 0; msk(end-2:end,:,:) = 0;
msk(:,1:3,:) = 0; msk(:,end-2:end,:) = 0;
msk(:,:,1:3) = 0; msk(:,:,end-2:end) = 0;

msk = auxil_msk_auto(na_den_corr_img(:,:,:,1).*msk, 0.4);
msk = auxil_msk_auto(na_den_corr_img(:,:,:,1).*msk, 0.4);

na_den_corr_msk_img = na_den_img;
na_msk_img = na_img;

for idx = 1: size(na_den_img, 4)
    na_den_corr_msk_img(:,:,:,idx) = na_den_corr_img(:,:,:,idx) .* msk;
    na_msk_img(:,:,:,idx) = na_msk_img(:,:,:,idx) .* msk;
end

% Save and Plot
colormoc = parula;
colormoc(1, :) = [0, 0, 0];

figure(1), imshow(mosaic(rot90(na_img(:,:,12:end,1)), [6,6]), [10 500]); colormap(colormoc)
figure(2), imshow(mosaic(rot90(na_den_img(:,:,12:end,1)), [6,6]), [10 500]); colormap(colormoc)
figure(3), imshow(mosaic(rot90(na_den_corr_msk_img(:,:,12:end,1)), [6,6]), [10 300]); colormap(colormoc)

na_quant_nii = 'c2p_quant.nii';
na_den_nii = 'c2p_den.nii';

auxil_nii_save_ref(na_den_img, na_nii, na_den_nii);
auxil_nii_save_ref(na_den_corr_msk_img, na_nii, na_quant_nii);