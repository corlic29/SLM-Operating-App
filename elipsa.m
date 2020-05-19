function [ I] = elipsa (I,a,b,w,h)

%Circular aperture
    centerY=h/2;
    centerX=w/2;
    
    [columnsInImage rowsInImage] = meshgrid(1:w, 1:h);
    circlePixels = (rowsInImage - centerY).^2 / a.^2 + (columnsInImage - centerX).^2 / b.^2 <= 1;
    mapa=ones(h,w);
    map_aperture=circlePixels.*mapa;
    
    %Aperture addition
    I=map_aperture.*I;
    
end

