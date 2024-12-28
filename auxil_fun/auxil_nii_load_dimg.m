function img = auxil_nii_load_dimg(nii_file)

    img_nii = load_untouch_nii(nii_file);
    
    img = double(img_nii.img);

end