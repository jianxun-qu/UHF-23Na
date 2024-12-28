function [mask] = auxil_mask_auto(img, scale)

    if nargin < 2
        scale = 1.0;
    end

    mask_threshold = sum(img(:).^2) / sum(img(:)) * scale;
    mask = ones(size(img));
    mask(img < mask_threshold) = 0;

    SE = strel("sphere",2);
    mask = imdilate(mask, SE);
    mask = imerode(mask, SE);

end