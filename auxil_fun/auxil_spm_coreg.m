function rsrc_otr_cfile = auxil_spm_coreg(ref_cfile, src_otr_cfile, varargin)

    if (nargin < 2)
        error('auxil_spm_coreg: insufficient input parameter!\n');
    end

    % Input cfile separate
    source_cfile = src_otr_cfile(1);
    other_cfile = {''};
    if length(src_otr_cfile) > 1
        other_cfile = src_otr_cfile(2:end);
    end
    other_cfile = other_cfile(:);
    
    % default parameter
    cost_fun = 'nmi';
    sep = [4 2];
    tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    fwhm = [7 7];
    interp = 4;
    wrap = [0 0 0];
    mask = 0;
    prefix = 'r';
    
    log = 0;
    
    % user specific parameter
    if (nargin > 2)
        varlen = nargin-2;
        try
            for idx = 1:2:varlen
                varstr = varargin{idx};
                switch varstr
                    case 'cost_fun'
                        cost_fun = varargin{idx+1};
                    case 'sep'
                        sep = varargin{idx+1};
                    case 'tol'
                        tol = varargin{idx+1};
                    case 'fwhm'
                        fwhm = varargin{idx+1};
                    case 'interp'
                        interp = varargin{idx+1};
                    case 'wrap'
                        wrap = varargin{idx+1};
                    case 'mask'
                        mask = varargin{idx+1};
                    case 'prefix'
                        prefix = varargin{idx+1};
                    case 'log'
                        log = varargin{idx+1};
                    otherwise
                        error('auxil_spm_coreg: unrecognised parameter!\n');
                end
            end
        catch
            error('auxil_spm_coreg: parsing parameter error!\n');
        end
    end

    clear matlabbatch

    spm('defaults','fmri');
    spm_jobman('initcfg');

    matlabbatch{1}.spm.spatial.coreg.estwrite.ref = ref_cfile;
    matlabbatch{1}.spm.spatial.coreg.estwrite.source = source_cfile;
    matlabbatch{1}.spm.spatial.coreg.estwrite.other = other_cfile;
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = cost_fun;
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = sep;
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = tol;
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = fwhm;
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = interp;
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = wrap;
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = mask;
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = prefix;
    
    if (log)
        spm_jobman('run',matlabbatch);
        clear matlabbatch
    else
        T = evalc('spm_jobman(''run'',matlabbatch)');
        clear matlabbatch
    end
    
    rsrc_otr_cfile = auxil_cfile_prefix(src_otr_cfile, prefix);
    
end