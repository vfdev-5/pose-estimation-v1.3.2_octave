function res = rgb_imrotate(IMGPRE, varargin)
#
# imrotate on RGB images
#
if length(size(IMGPRE)) != 3 || size(IMGPRE, 3) != 3
    error("imrotate: IMGPRE must be RGB image");
endif
    # rotate first channel to get total output size
    b1 = builtin("imrotate", IMGPRE(:,:,1), varargin{:});
    res = zeros(size(b1,1), size(b1,2), size(IMGPRE,3));
    res(:,:,1) = b1;
    for i = 2:size(IMGPRE, 3)
        res(:,:,i) = builtin("imrotate", IMGPRE(:,:,i), varargin{:});
    end 
    res = uint8(res);
endfunction
