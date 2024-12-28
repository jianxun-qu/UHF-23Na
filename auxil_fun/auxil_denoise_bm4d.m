function [img_den, sigma_est] = auxil_denoise_bm4d(img_ori, varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   BM4D Default Parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distribution      = 'Rice'; % noise distribution
                             %  'Gauss' --> Gaussian distribution
                             %  'Rice ' --> Rician Distribution
sigma             = 10;      % noise standard deviation given as percentage of the
                             % maximum intensity of the signal, must be in [0,100]
profile           = 'mp';    % BM4D parameter profile
                             %  'lc' --> low complexity
                             %  'np' --> normal profile
                             %  'mp' --> modified profile
                             % The modified profile is default in BM4D. For 
                             % details refer to the 2013 TIP paper.
do_wiener         = 1;       % Wiener filtering
                             %  1 --> enable Wiener filtering
                             %  0 --> disable Wiener filtering
verbose           = 1;       % verbose mode

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Parsing Parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (nargin > 1)
    varlen = nargin - 1;
    try
        for idx = 1:2:varlen
            varstr = varargin{idx};
            switch varstr
                case 'distribution'
                    distribution = varargin{idx+1};
                case 'sigma'
                    sigma = varargin{idx+1};
                case 'profile'
                    profile = varargin{idx+1};
                case 'do_wiener'
                    do_wiener = varargin{idx+1};
                case 'verbose'
                    verbose = varargin{idx+1};
                otherwise
                    error('auxil_denoise_bm4d: unrecognized parameter!\n');
            end
        end
    catch
        error('auxil_denoise_bm4d: parsing parameter error!\n');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   BM4D Run
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[img_den, sigma_est] = bm4d(img_ori, distribution, sigma, profile, do_wiener, verbose);

end