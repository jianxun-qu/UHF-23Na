% Register 23Na image to anatomical image

t1_nii = 't1.nii';
gre_ref_nii = 'gre_ref.nii';
na_hr_nii = 'c2p_hr.nii';

auxil_spm_reslice({gre_ref_nii}, {na_hr_nii}, 'prefix', 'rslc_');

na_hr_nii = ['rslc_', na_hr_nii];

auxil_spm_coreg({t1_bravo_nii}, {gre_ref_nii, na_hr_nii}, 'prefix', 'reg_');

na_hr_nii = ['reg_', na_hr_nii];
