function im_2D = FourierSlice4D3( im_4D, alpha, width, height, radius)
Basis = [ 1 0 -alpha 0 ; 0 1 0 alpha ; 0 0 1 0 ; 0 0 0 1 ]; Basis_f = inv(Basis);
Basis_f = transpose(Basis_f);
d = det(Basis_f); Basis_f= Basis_f/d;
im_4D = ifftshift(im_4D); im_f=fftn( im_4D ); im_f=fftshift( im_f );         
dims=size( im_4D ); 
[m n u v]=size( im_4D ); 
im_f_2D=zeros([height, width]);
offset = [0; 0; u/2; v/2]-Basis_f*[m/2; n/2; 0 ; 0];
offset(1,1)=0; offset(2,1)=0; i = 1;
for T=1:height
   % fprintf('%d/%d\n', T, height);
    for S=1:width
        vc=double(zeros(4,1));
        vc(1,1)=T; vc(2,1)=S; vc(3,1)=1; vc(4,1)=1;
        vc = Basis_f*vc; vc = vc+offset; 
       [vc, flag] = cvIn(vc,dims);
       if flag==0
         % U(i) = vc(3,1); V(i) = vc(4,1);
          im_f_2D(T,S) = SampleGaussian(im_f, vc(1,1), vc(2,1), vc(3,1), vc(4,1),radius);
          % im_f_2D(T,S) = SampleGaussian(im_f, vc(1,1), vc(2,1), 14, 14,radius);
       else
         % U0(i) = vc(3,1); V0(i) = vc(4,1);
          im_f_2D(T,S)=0;
        end  
        i = i + 1; 
    end 
end
%figure; imshow(log(abs(im_f_2D)), []);  

im_f_2D = ifftshift( im_f_2D );
imf2Difftn = ifft2(im_f_2D);  im_2D=fftshift(imf2Difftn);
% figure; imshow(im_2D, []); 

end    
function clr = SampleGaussian( im, fy, fx, fv, fu, radius)
total_clr = 0; total_weight = 0; dims = size(im);
startu = max(1, uint32(fu)-radius); startv = max(1, uint32(fv)-radius);
endu = min(dims(4), startu+radius); endv = min(dims(3), startv+radius); 
for v = startv:endv
    for u = startu:endu
                distance = (fv-double(v))*(fv-double(v))+(fu-double(u))*(fu-double(u));
                weight = exp(-distance);
                total_weight = total_weight+weight;
            tmpX = floor(fy+0.5);
            tmpY = floor(fx+0.5);
                current_clr = im(tmpX, tmpY, v, u);
                total_clr = total_clr+current_clr*weight;
  
    end
end 
clr = total_clr/total_weight;
end 