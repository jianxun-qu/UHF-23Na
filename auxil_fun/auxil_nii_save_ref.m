function auxil_nii_save_ref(img, nii_ref_file, nii_des_file)

    nii = load_untouch_nii(nii_ref_file);
    
    img_dim4 = size(img, 4);
    
    nii.img = img;
    
    nii.hdr.dime.dim(5) = img_dim4;
    nii.hdr.dime.glmin = min(nii.img(:));
    nii.hdr.dime.glmax = max(nii.img(:));
        
    save_untouch_nii(nii, nii_des_file);

end