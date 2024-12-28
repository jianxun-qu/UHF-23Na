% Calculate Signal Intensity Correction Map

voxel_size = [5.6, 5.6, 5.6];
corr_regulator = 10.0;
gauss_filter_radius = 10.0;
preview_flag = 1;
denoise_sigma = 2;  % [C2P: 2; Product: 10]

na_naa_nii = 'demo_data/c2p_naa_6.nii';
na_nav_nii = 'demo_data/c2p_nav_7.nii';

na_naa_img = auxil_nii_load_dimg(na_naa_nii);
na_nav_img = auxil_nii_load_dimg(na_nav_nii);


if 1 % [NAA-NAV-NAA] to reduce the influence from motion
    na_naa_2_nii = 'demo_data/c2p_naa_8.nii';
    na_naa_2_img = auxil_nii_load_dimg(na_naa_2_nii);
    na_naa_1_img = na_naa_img;
    na_naa_img = (na_naa_1_img + na_naa_2_img)/2;
end

corr_raw_map = (na_naa_img + corr_regulator) ./ (na_nav_img + corr_regulator);

% Preview
figure(1), imshow(mosaic(rot90(na_naa_img)), [0 300]);
figure(2), imshow(mosaic(rot90(na_nav_img)), [0 200]);
figure(3), imshow(mosaic(rot90(corr_raw_map)), [0 2]);

% Denoise
[na_naa_den_img, ~] = auxil_denoise_bm4d(na_naa_img, 'distribution', 'Rice', 'sigma', denoise_sigma);
[na_nav_den_img, ~] = auxil_denoise_bm4d(na_nav_img, 'distribution', 'Rice', 'sigma', denoise_sigma);

% Filter
filter_gauss = auxil_msk_gen_kernel_gaussian(voxel_size, gauss_filter_radius);

na_naa_den_flt_img = convn(na_naa_den_img, filter_gauss, 'same');
na_nav_den_flt_img = convn(na_nav_den_img, filter_gauss, 'same');

% Calculate Intensity Correction Map
corr_map = (na_naa_den_flt_img + corr_regulator) ./ (na_nav_den_flt_img + corr_regulator);
corr_map = convn(corr_map, filter_gauss, 'same');

% Export and Plot
corr_nii = 'c2p_corr';
auxil_nii_save_ref(corr_map * 100, na_naa_nii, corr_nii);

figure(1), imshow(mosaic(rot90(na_naa_den_img(:,:,5:end)), [5,5]), [20 400])
figure(2), imshow(mosaic(rot90(na_nav_den_img(:,:,5:end)), [5,5]), [10 200])
figure(3), imshow(mosaic(rot90(corr_map(:,:,5:end)), [5,5]), [0 6]);


