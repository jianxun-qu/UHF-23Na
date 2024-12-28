function auxil_spm_realign(data_cfile, varargin)

    funcname = 'auxil_spm_realign';

    if (nargin < 1)
        error([funcname, ': insufficient input parameter!\n']);
    end
    
    nii = load_untouch_nii(data_cfile{1});
    
    measnum = nii.hdr.dime.dim(5);
    
    data_cfile_array = {};
    
    for idx = 1:measnum
        data_cfile_array{1}{idx} = [data_cfile{1}, ',', num2str(idx)];
    end
    
    data_cfile_array{1} = data_cfile_array{1}(:);

    clear matlabbatch

    spm('defaults','fmri');
    spm_jobman('initcfg');

    matlabbatch{1}.spm.spatial.realign.estwrite.data =data_cfile_array;
    
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
    
    spm_jobman('run',matlabbatch);
    clear matlabbatch

end