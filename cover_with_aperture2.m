function [I] = cover_with_aperture2(I,aperture)
%Function covers hologram with circular apertue

%I - hologram
%aperture-aperture diameter

    %Coordination set up
    [h,w]=size(I);
    centerY=round(h/2);
    centerX=round(w/2);
    
    %Circular aperture
    [columnsInImage, rowsInImage] = meshgrid(1:w, 1:h);
    circlePixels = (rowsInImage - centerY).^2 + (columnsInImage - centerX).^2<= (aperture/2).^2;
   
    %Aperture addition
    I(~circlePixels) = 0;
    
end