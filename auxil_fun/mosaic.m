function data = mosaic(data, shape)
%     data = gccdata;
%     shape = [5,3];
    data = data(:,:,:);
    [Nx, Ny, Nc] = size(data);
    
    if nargin < 2
        shape(1) = ceil( sqrt(Nc) );
        shape(2) = ceil( sqrt(Nc) );
    end
    
    if Nc < shape(1) * shape(2)
        data = cat(3, data, zeros(Nx, Ny, shape(1)*shape(2)-Nc));
    end
    
    Nc = shape(1) * shape(2);
    data = data(:,:,1:Nc);
   
    
    data = reshape(data, Nx, Ny*Nc);
    data = permute(data, [2,3,1]);
    data = reshape(data, Ny*shape(2),shape(1),Nx);
    data = permute(data, [3,2,1]);
    data = reshape(data, Nx*shape(1),Ny*shape(2));

end

