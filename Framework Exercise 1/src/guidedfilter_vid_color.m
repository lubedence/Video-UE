%   GUIDEDFILTER_COLOR   O(1) time implementation of guided filter using a color image as the guidance.
%
%   - guidance image: I (should be a color (RGB) video)
%   - filtering input image: p (should be a gray-scale/single channel video)
%   - local window radius: r
%   - regularization parameter

function q = guidedfilter_vid_color(I_vid, p_vid, r, rt, eps)
    [hei, wid, dim, time] = size(I_vid);
    N=boxfilter_vid(ones(hei,wid,time),r,rt);
    % the size of each local patch; N=(2r+1)^3 except for boundary pixels.

    I_vid_r(:,:,:)=I_vid(:,:,1,:);
    I_vid_g(:,:,:)=I_vid(:,:,2,:);
    I_vid_b(:,:,:)=I_vid(:,:,3,:);

    % mean for image
    mean_I_r = boxfilter_vid(I_vid_r, r, rt) ./ N;
    mean_I_g = boxfilter_vid(I_vid_g, r, rt) ./ N;
    mean_I_b = boxfilter_vid(I_vid_b, r, rt) ./ N;

    % mean for guidance
    mean_p = boxfilter_vid(p_vid, r, rt) ./ N;

    mean_Ip_r = boxfilter_vid(I_vid_r.*p_vid, r, rt) ./ N;
    mean_Ip_g = boxfilter_vid(I_vid_g.*p_vid, r, rt) ./ N;
    mean_Ip_b = boxfilter_vid(I_vid_b.*p_vid, r, rt) ./ N;

    % covariance of (I_vid, p_vid) in each local patch.
    cov_Ip_r = mean_Ip_r - mean_I_r .* mean_p;
    cov_Ip_g = mean_Ip_g - mean_I_g .* mean_p;
    cov_Ip_b = mean_Ip_b - mean_I_b .* mean_p;

    % variance of I in each local patch: the matrix Sigma in Eqn (14).
    var_I_rr = boxfilter_vid(I_vid_r.*I_vid_r, r, rt) ./ N - mean_I_r .*  mean_I_r; 
    var_I_rg = boxfilter_vid(I_vid_r.*I_vid_g, r, rt) ./ N - mean_I_r .*  mean_I_g; 
    var_I_rb = boxfilter_vid(I_vid_r.*I_vid_b, r, rt) ./ N - mean_I_r .*  mean_I_b; 
    var_I_gg = boxfilter_vid(I_vid_g.*I_vid_g, r, rt) ./ N - mean_I_g .*  mean_I_g; 
    var_I_gb = boxfilter_vid(I_vid_g.*I_vid_b, r, rt) ./ N - mean_I_g .*  mean_I_b; 
    var_I_bb = boxfilter_vid(I_vid_b.*I_vid_b, r, rt) ./ N - mean_I_b .*  mean_I_b; 
    % Note the variance in each local patch is a 3x3 symmetric matrix:
    %           rr, rg, rb
    %   Sigma = rg, gg, gb
    %           rb, gb, bb

    a_r = zeros(hei, wid, time);
    a_g = zeros(hei, wid, time);
    a_b = zeros(hei, wid, time);
    temp = eps * eye(3);
    for t=1:time
        for y=1:hei
            for x=1:wid        
                %get variance of each window
                Sigma = [var_I_rr(y, x, t), var_I_rg(y, x, t), var_I_rb(y, x, t);
                    var_I_rg(y, x, t), var_I_gg(y, x, t), var_I_gb(y, x, t);
                    var_I_rb(y, x, t), var_I_gb(y, x, t), var_I_bb(y, x, t)];

                cov_Ip = [cov_Ip_r(y, x, t), cov_Ip_g(y, x, t), cov_Ip_b(y, x, t)];        

                as = cov_Ip/(Sigma + temp); 

                a_r(y,x,t)= as(1);
                a_g(y,x,t)= as(2);
                a_b(y,x,t)= as(3);  
            end
        end
    end

    b = mean_p - a_r .* mean_I_r - a_g .* mean_I_g - a_b .* mean_I_b; 

    q = (boxfilter_vid(a_r, r, rt).* I_vid_r + boxfilter_vid(a_g, r, rt).* I_vid_g + boxfilter_vid(a_b, r, rt).* I_vid_b + boxfilter_vid(b, r, rt)) ./ N;  
end