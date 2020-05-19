%Funckja do zernike callback, 19.01.2019 13:13

%Function will perform Zernike correction algorithm
slm1=sdMatlabTools1.Slm;

%Scaling parameters
coefficient=3; %Wcz
step=0.025;
delay=0.2;
correlations=[];
%% preparation of coordinate system
x = linspace(-1,1,handles.h);
[X,Y] = meshgrid(x,x);
[theta,r] = cart2pol(X,Y);
idx = r<=1;
z = nan(size(X));
try
start(handles.vid)
end
stop(handles.vid)  
%handles.vid.ROIPosition=[handles.center(2)-handles.half_side handles.center(1)-handles.half_side 2*handles.half_side+1 2*handles.half_side+1];
handles.vid.ROIPosition=[handles.center(2)-handles.half_side handles.center(1)-handles.half_side size(handles.simulated)];
%% test snapshot speed up

triggerconfig(handles.vid, 'manual');
start(handles.vid) %start is crucial in order to save triggerconfig parameters

% Now that the device is configured for manual triggering, call START.
% This will cause the device to send data back to MATLAB, but will not log
% frames to memory at this point.
%start(handles.vid)

%% close preview to improve speed
try
%closepreview(handles.vid); 
catch
end    
%% Do FUNKCJI (coefficient,step, wielomian, z) gdzie wielomian to np [2; -2]
%% preparation of zernike polynomial 2d
z(idx) = zernfun(2,-2,r(idx),theta(idx));
%z = mod(z,2*pi);
z = padarray(z,[0 420], 0, 'both');
z(isnan(z))=0;

%% check best correction
i =0;
v = zeros(1,coefficient/step*2);
c2 = v;
tic
%for c= -coefficient:step:coefficient
c=1.9;    
%toc
    i=i+1;
    %z2=mod(z*c,2*pi);
    z2=z*c;
%toc
    %Check improvement
    to_display=cover_with_aperture2(mod(handles.phase_map+z2,2*pi),handles.aperture);
%toc

    slm1.SetF(to_display,255);
%toc
    pause(delay)
%toc
    experimental_intensity = get_snap(handles.vid);
%toc
    comparison_parameter = corr2(handles.simulated, experimental_intensity);
%toc
    %Store parameters
    v(i) = comparison_parameter;
    c2(i) = c;
%toc

%end

%determine comparison parameter
[m, j] = max(v) % m - value, j - index
c = c2(j);
correlations(1)=c;
z_corrected=z*c;
%z_corrected=mod(z_corrected,2*pi);

    to_display=cover_with_aperture2(mod(handles.phase_map+z_corrected,2*pi),handles.aperture);
    %slm1.SetF(handles.phase_map,255);
    slm1.SetF(to_display,255);
    pause(1)
%% KONIEC FUNKCJI
%stop(handles.vid)  

%triggerconfig(handles.vid, 'immediate');

 
    %slm2(to_display);
    imwrite(mat2gray(z_corrected), 'z_corrected1.bmp');
    imwrite(mat2gray(to_display), 'phase_map1.bmp');
    
handles.phase_map=to_display;  
toc
%% preparation of zernike polynomial 2d part 2
delete z z2 
z = nan(size(X));
z(idx) = zernfun(2,2,r(idx),theta(idx));
%z = mod(z,2*pi);
z = padarray(z,[0 420], 0, 'both');
z(isnan(z))=0;
%% check best correction
i =0;
for c= -coefficient:step:coefficient
    i=i+1;
    %z2=mod(z*c,2*pi);
    z2=z*c;
    %Check improvement
    to_display=cover_with_aperture2(mod(handles.phase_map+z2,2*pi),handles.aperture);

    slm1.SetF(to_display,255);
    pause(delay)
    experimental_intensity = get_snap(handles.vid);
    comparison_parameter = corr2(handles.simulated, experimental_intensity);
    
    %Store parameters
    v(i) = comparison_parameter;
    c2(i) = c;
end

%determine comparison parameter
[m, j] = max(v) % m - value, j - index
c = c2(j);
correlations(2)=c;
%z_corrected=mod(z*c,2*pi);
z_corrected=z*c;
    to_display=cover_with_aperture2(mod(handles.phase_map+z_corrected,2*pi),handles.aperture); 
    %slm1.SetF(handles.phase_map,255);
    slm1.SetF(to_display,255);
    pause(1)



    %slm2(to_display);
    imwrite(mat2gray(z_corrected), 'z_corrected2.bmp');
    imwrite(mat2gray(to_display), 'phase_map2.bmp');

handles.phase_map=to_display; 
toc
%% preparation of zernike polynomial 2d part 3
delete z z2
z = nan(size(X));
z(idx) = zernfun(4,-2,r(idx),theta(idx));
%z = mod(z,2*pi);
z = padarray(z,[0 420], 0, 'both');
z(isnan(z))=0;
%% check best correction
i =0;
for c= -coefficient:step:coefficient
    i=i+1;
    %z2=mod(z*c,2*pi);
    z2=z*c;
    %Check improvement
    to_display=cover_with_aperture2(mod(handles.phase_map+z2,2*pi),handles.aperture);
    
    slm1.SetF(to_display,255);
    pause(delay)
    experimental_intensity = get_snap(handles.vid);
    comparison_parameter = corr2(handles.simulated, experimental_intensity);
    
    %Store parameters
    v(i) = comparison_parameter;
    c2(i) = c;
end

%determine comparison parameter
[m, j] = max(v) % m - value, j - index
c = c2(j);
correlations(3)=c;
%z_corrected=mod(z*c,2*pi);
z_corrected=z*c;

    to_display=cover_with_aperture2(mod(handles.phase_map+z_corrected,2*pi),handles.aperture);
    %slm1.SetF(handles.phase_map,255);
    slm1.SetF(to_display,255);
    pause(1)

    %slm2(to_display);
    imwrite(mat2gray(z_corrected), 'z_corrected3.bmp');
    imwrite(mat2gray(to_display), 'phase_map3.bmp');
    handles.phase_map=to_display; 
toc    
    %% preparation of zernike polynomial 2d part 4
delete z z2
z = nan(size(X));
z(idx) = zernfun(4,2,r(idx),theta(idx));
z = mod(z,2*pi);
z = padarray(z,[0 420], 0, 'both');
z(isnan(z))=0;
%% check best correction
i =0;
for c= -coefficient:step:coefficient

    i=i+1;
    %z2=mod(z*c,2*pi);
    z2=z*c;
    %Check improvement
    to_display=cover_with_aperture2(mod(handles.phase_map+z2,2*pi),handles.aperture);
    
    slm1.SetF(to_display,255);
    pause(delay)
    experimental_intensity = get_snap(handles.vid);
    comparison_parameter = corr2(handles.simulated, experimental_intensity);
    
    %Store parameters
    v(i) = comparison_parameter;
    c2(i) = c;
end

%determine comparison parameter
[m, j] = max(v) % m - value, j - index
c = c2(j);
correlations(4)=c;
%z_corrected=mod(z*c,2*pi);
z_corrected=z*c;

    to_display=cover_with_aperture2(mod(handles.phase_map+z_corrected,2*pi),handles.aperture);
    %slm1.SetF(handles.phase_map,255);
    slm1.SetF(to_display,255);
    pause(1)
toc    

    imwrite(mat2gray(z_corrected), 'z_corrected4.bmp');
    imwrite(mat2gray(to_display), 'phase_map4.bmp');
    handles.phase_map=to_display; 
%%

%Na koncu wyrzuca korekcje
stop(handles.vid)
triggerconfig(handles.vid, 'immediate');
handles.vid.ROIPosition=[0 0 handles.w handles.h];
start(handles.vid)

try
preview(handles.vid); 
catch
end 

correlations
%Update handles
guidata(hObject, handles);