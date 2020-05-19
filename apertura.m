function [ I] = apertura (I,aperture,w,h)

%Circular aperture
    centerY=h/2;
    centerX=w/2;
    
    [columnsInImage rowsInImage] = meshgrid(1:w, 1:h);
    circlePixels = (rowsInImage - centerY).^2 + (columnsInImage - centerX).^2<= (aperture/2).^2;
    mapa=ones(h,w);
    map_aperture=circlePixels.*mapa;
    
    %Aperture addition
    I=map_aperture.*I;
    
end

