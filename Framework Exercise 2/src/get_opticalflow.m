%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Optical Flow Computation: Horn & Schunck Method
% img1 : second frame
% img2 : first frame
% alpha: regularization parameter for degree of smoothness
% iterations: number of iterations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [flow] = get_opticalflow(img1, img2, alpha, iterations)

img1=double(img1);
img2=double(img2);

%1. differentiate the first time & gradients              
[Fx,Fy,Ft] = getDerivatives(img1, img2);

%2. solve equation iteratively
% initial flow vectors
u = double(zeros(size(Fx)));
v = double(zeros(size(Fy)));

% iterations
for i=1:iterations
    % compute local averages of the flow vectors
    uAvg = getAvg(u);
    vAvg = getAvg(v);
    
    %----------------------------------------------------------------------
    % Task a: compute optical flow vectors 
    %----------------------------------------------------------------------

    u = uAvg - ( Fx .* ( ( Fx .* uAvg ) +( Fy .* vAvg ) + Ft ) ) ./ ( Fx.^2 + Fy.^2 + alpha);
    v = vAvg - ( Fy .* ( ( Fx .* uAvg ) + ( Fy .* vAvg ) + Ft ) ) ./ ( Fx.^2 + Fy.^2 + alpha);
    filterSize = 7;
    
    %not at last iteration?
    if (i < iterations)
        u = medfilt2(u, [filterSize filterSize]);
        v = medfilt2(v, [filterSize filterSize]);
    end
end

%3. return result
u(isnan(u))=0;
v(isnan(v))=0;
[h,w] = size(u);
flow = zeros(h,w,2);
flow(:,:,1)= u;
flow(:,:,2)= v;
end


function [Fx,Fy,Ft] = getDerivatives(img1, img2)
    %spatial and temporal derivatives
    Fx = conv2(img1,0.25* [-1 1; -1 1],'same') + conv2(img2, 0.25*[-1 1; -1 1],'same');
    Fy = conv2(img1, 0.25*[-1 -1; 1 1], 'same') + conv2(img2, 0.25*[-1 -1; 1 1], 'same');
    Ft = conv2(img1, 0.25*ones(2),'same') + conv2(img2, -0.25*ones(2),'same');
end

function avgMotion = getAvg(u)
  % for approximation of laplacian gradient: compute motion average of
  % neighbor pixels
  kernel_1=double([1/12 1/6 1/12;1/6 0 1/6;1/12 1/6 1/12]);
  avgMotion = conv2(u,kernel_1,'same');
end
    
