function auxil_spm_reslice(ref_cfile, source_cfile, varargin)

    if (nargin < 2)
        error('auxil_spm_reslice: insufficient input parameter!\n');
    end

    % default parameter
    interp = 4;
    wrap = [0 0 0];
    mask = 0;
    prefix = 'r';
    
    % user specific parameter
    if (nargin > 2)
        varlen = nargin-2;
        try
            for idx = 1:2:varlen
                varstr = varargin{idx};
                switch varstr
                    case 'interp'
                        interp = varargin{idx+1};
                    case 'wrap'
                        wrap = varargin{idx+1};
                    case 'mask'
                        mask = varargin{idx+1};
                    case 'prefix'
                        prefix = varargin{idx+1};
                    otherwise
                        error('auxil_spm_reslice: unrecognised parameter!\n');
                end
            end
        catch
            error('auxil_spm_reslice: parsing parameter error!\n');
        end
    end 

    % spm process
    clear matlabbatch
    
    matlabbatch{1}.spm.spatial.coreg.write.ref = ref_cfile;
    matlabbatch{1}.spm.spatial.coreg.write.source = source_cfile;
    matlabbatch{1}.spm.spatial.coreg.write.roptions.interp = interp;
    matlabbatch{1}.spm.spatial.coreg.write.roptions.wrap = wrap;
    matlabbatch{1}.spm.spatial.coreg.write.roptions.mask = mask;
    matlabbatch{1}.spm.spatial.coreg.write.roptions.prefix = prefix;

    spm('defaults','fmri');
    spm_jobman('initcfg');
    spm_jobman('run',matlabbatch);
    clear matlabbatch

end