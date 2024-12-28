function rsrc_cfile = auxil_spm_resample(src_cfile, varargin)

    funcname = 'auxil_spm_resample';

    if (nargin < 1)
        error([funcname, ': insufficient input parameter!\n']);
    end
    
    % default parameter
    vox = [1 1 1];
    interp = 1;
    prefix = 'r';
    
    log = 0;
    
    % user specific parameter
    var_rem = varargin;
    var_num = length(var_rem);
    try 
        while var_num
            varstr = var_rem{1};
            switch varstr
                case 'vox'
                    vox = var_rem{2};
                    var_rem([1,2]) = [];
                    var_num = length(var_rem);
                    continue
                case 'interp'
                    interp = var_rem{2};
                    var_rem([1,2]) = [];
                    var_num = length(var_rem);
                    continue
                case 'prefix'
                    prefix = var_rem{2};
                    var_rem([1,2]) = [];
                    var_num = length(var_rem);
                    continue
                case 'log'
                    log = var_rem{2};
                    var_rem([1,2]) = [];
                    var_num = length(var_rem);
                    continue
                otherwise
                    error([funcname, ': unidentified tag!\n']);
            end
        end
    catch
        error([funcname, ': parsing input failed!\n']);
    end
    
    vol = spm_vol(src_cfile{1});
    
    for idx = 1 : numel(vol)
        bb = spm_get_bbox(vol(idx));
        vvol(1:2) = vol(idx);
        vvol(1).mat = spm_matrix([bb(1, :), 0, 0, 0, vox]) * spm_matrix([-1 -1 -1]);
        vvol(1).dim = ceil(vvol(1).mat \ [bb(2,:) 1]' - 0.1)';
        vvol(1).dim = vvol(1).dim(1:3);
        if (log)
            spm_reslice(vvol, struct('mean', false, 'which' , 1, 'interp', interp, 'prefix', prefix) );
        else
            T=evalc('spm_reslice(vvol, struct(''mean'', false, ''which'' , 1, ''interp'', interp, ''prefix'', prefix) )');
        end
    end
    
    rsrc_cfile = auxil_cfile_prefix(src_cfile, prefix);
    
end