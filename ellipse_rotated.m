%% rotated elliptical focus
w=1920;
x=-w/2:1:w/2-1;
h=1080;
y=-h/2:1:h/2-1;

[X, Y]= meshgrid(x,y);

X=X*8e-6;
Y=Y*8e-6;
l=633e-9;

f=0.6;
    %{
map=mod(pi/l/f*(2*X.^2+Y.^2),2*pi);

[theta, rho]=cart2pol(X, Y);
map3=mod(pi/l/f*(rho),2*pi);
%figure()
%imshow(map3,[]);

%map=mod(fresnel(w,h,f,l,px),2*pi);
imshow(map,[])
    %}
amp=apertura(ones(h,w),2000,w,h);

%imshow(amp,[])

map2=imrotate(mod(pi/l/f*(((1.0025)*X.^2+0.95*Y.^2)),2*pi),90,'bilinear','crop');
map3=imrotate(mod(pi/l/f*(X.^2+Y.^2),2*pi),90,'bilinear','crop');

correction=mod(map2-map3,2*pi);
imwrite(mat2gray(correction),['correction_from_ellipse.bmp']);
figure()
imshow(correction,[])
%figure()
%imshow(map2,[])
%map2=imrotate(map2,i,'bilinear','crop'); 
   %imwrite(mat2gray(map2),['ellipse_rotated_' num2str(i) '.bmp']);

U=amp.*exp(1i.*map2);
U_FT=fftshift(fft2(U));
I=abs(U_FT).^2;
figure()

%{
%% transformata z elipsy, idealna elipsa
phase=zeros(w,h);
amp2=elipsa(ones(h,w),300,200,w,h);
uu=amp2.*exp(1i.*phase);
EE=fftshift(fft2(uu));
amplituda=abs(EE);
II=amplituda.^2;
imshow(II,[])

%% Nieidalna elipsa, transformata z soczewki fresnela przy kolowej aperturze
%map2=mod(pi/l/f*(((1.5)*X.^2+Y.^2)),2*pi);
map2=rand(h,w);
%map2=imrotate(map2,i,'bilinear','crop'); 
   %imwrite(mat2gray(map2),['ellipse_rotated_' num2str(i) '.bmp']);

U=amp.*exp(1i.*map2);
U_FT=fftshift(fft2(U));
I=abs(U_FT).^2;
figure()
imshow(I,[])
figure()
imshow(map2,[])
for i=1:1:200
U=amp.*exp(1i.*map2);
U_FT=fftshift(fft2(U));
phase_ft=angle(U_FT)+pi;
I=abs(U_FT).^2;
if i==200
figure()
imshow(I,[])
end
U_FT=amplituda.*exp(1i.*phase_ft);

U_iFFT=ifft2(ifftshift(U_FT));
map2=angle(U_iFFT)+pi;
end
figure()
imshow(map2,[])
%}

