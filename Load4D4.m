%pad LF
function [ im_4D ] = Load4D4 ( folder, width ,height, view_u, view_v, factor, padfactorUV, padfactorXY)

w = width*factor;
h = height*factor; 

w_pad = w*padfactorXY;
h_pad = h*padfactorXY;

u_pad = floor(view_u*padfactorUV);
v_pad = floor(view_v*padfactorUV);

if mod(w_pad,2) ~= 0
    w_pad = w_pad+1;
end

if mod(h_pad,2) ~= 0
    h_pad = h_pad+1;
end

if mod(u_pad,2) ~= 0
    u_pad = u_pad+1;
end

if mod(v_pad,2) ~= 0
    v_pad = v_pad+1;
end

im_4D = zeros( h+h_pad, w+w_pad, view_v+v_pad, view_u+u_pad);

list = dir(folder);

num=1;

dims = size(im_4D);

for v = 1:view_v
    for u = 1:view_u 
% for v = 1:2
%     for u = 1:2 
         
        name = [folder '\' list(num+2).name];    
        fprintf('%s\n', name);
        im=imread(name);
        %im=double(im);
        %im=rgb2gray(im); % desconectado por imagenes gris
        im=imresize(im, factor, 'bilinear'); 
        
        for t = 1:h
            for s = 1:w
                im_4D(t+h_pad/2, s+w_pad/2, v+v_pad/2, u+u_pad/2)=im(t, s);
            end
        end
        num=num+1;
    end
end

end