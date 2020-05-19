%{
Application to operate SLM of both types:
 Holoeye PLUTO
 Holoeye LC-R2500
%} 


function varargout = SLM_app(varargin)
% SLM_APP MATLAB code for SLM_app.fig
%      SLM_APP, by itself, creates a new SLM_APP or raises the existing
%      singleton*.
%
%      H = SLM_APP returns the handle to a new SLM_APP or the handle to
%      the existing singleton*.
%
%      SLM_APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLM_APP.M with the given input arguments.
%
%      SLM_APP('Property','Value',...) creates a new SLM_APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SLM_app_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SLM_app_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SLM_app

% Last Modified by GUIDE v2.5 07-Nov-2018 12:19:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SLM_app_OpeningFcn, ...
                   'gui_OutputFcn',  @SLM_app_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SLM_app is made visible.
function SLM_app_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SLM_app (see VARARGIN)

% Choose default command line output for SLM_app
handles.output = hObject;
value_camera=get(handles.popup_camera,'Value');

%fig=figure();
%fig=imshow(zeros(1208,1928));
if value_camera==1
%{
    axes(handles.axes_camera)
vid = videoinput('winvideo', 3, 'RGB32_2048x1536');
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;
hImage=image(zeros(2048,1536,3),'Parent',handles.axes_camera);
preview(vid,hImage);
%preview(vid);
%}
 
handles.vid = videoinput('winvideo', 3, 'Y800_1928x1208');
vid = videoinput('winvideo', 3, 'Y800_1024x768');
src = getselectedsource(handles.vid);
handles.vid.FramesPerTrigger = 1;
handles.vid.ReturnedColorspace = 'rgb';
%vid.ReturnedColorspace = 'rgb';
preview(handles.vid);

elseif value_camera==2
    
handles.vid  = videoinput('winvideo', 1, 'YUY2_160x120');
src = getselectedsource(handles.vid );
handles.vid.FramesPerTrigger = 1;
preview(handles.vid);

elseif value_camera==3
handles.vid  = videoinput('winvideo', 3, 'Y800_1928x1208');
src = getselectedsource(vid);
handles.vid .FramesPerTrigger = 1;
%vid.ReturnedColorspace = 'rgb';
src.Exposure = -6;
src.FrameRate = '25.0000';
preview(handles.vid);
end


guidata(hObject, handles);

% UIWAIT makes SLM_app wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SLM_app_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_width_Callback(hObject, eventdata, handles)
%Inicialize handle value
%handles.w=get_handles(hObject);

%Update handles
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_width_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
 
    %Set default value
    set(hObject,'String','1024');
end

%Inicialize default handle value
handles.w=get_handles(hObject);

%Update handles
guidata(hObject, handles);


function edit_focus_Callback(hObject, eventdata, handles)

%Inicialize handle value
handles.focus=get_handles(hObject);

%Update handles
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_focus_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
    %Set default value
    set(hObject,'String','0.5');
end
%Inicialize default handle value
handles.focus=get_handles(hObject);

%Update handles
guidata(hObject, handles);




function edit_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of edit_height as text
%        str2double(get(hObject,'String')) returns contents of edit_height as a double


% --- Executes during object creation, after setting all properties.
function edit_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pixel_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pixel_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pixel_size as text
%        str2double(get(hObject,'String')) returns contents of edit_pixel_size as a double


% --- Executes during object creation, after setting all properties.
function edit_pixel_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pixel_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in do_it.
function do_it_Callback(hObject, eventdata, handles)
% hObject    handle to do_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Pobranie wartosci z komorek
handles.w=str2double(get(handles.edit_width,'String'));
handles.h=str2double(get(handles.edit_height,'String'));
pixel_size=str2double(get(handles.edit_pixel_size,'String'));
w=handles.w;
h=handles.h;
handles.aperture=str2double(get(handles.edit_aperture,'String'));

handles.lambda=632.8e-9;
misalignment_w=str2double(get(handles.edit_misalignment_w,'String'));
misalignment_h=str2double(get(handles.edit_misalignment_h,'String'));
%Prepare size of holograms
x=-w/2:1:(w/2-1);y=-h/2:1:(h/2-1);
%[X,Y]=meshgrid(x+misalignment_w, y+misalignment_h);
[X,Y]=meshgrid(x, y);
%Checkboxes
value_fresnel = get(handles.checkbox_fresnel, 'Value');
value_dg = get(handles.checkbox_dg, 'Value');
value_vortex = get(handles.checkbox_vortex, 'Value');
value_aperture = get (handles.checkbox_aperture, 'Value');
value_check_plus_corr = get (handles.check_plus_corr, 'Value');
value_check_hologram = get(handles.check_hologram, 'Value');
value_fresnel_corr= get(handles.check_fresnel_corr, 'Value');
sum_of_maps=zeros(h,w); %Final hologram variable

if value_fresnel == 1
    %handles.fresnel=mod(fresnel(handles.w,handles.h,handles.focus,handles.lambda,pixel_size),2*pi)
    sum_of_maps=mod(sum_of_maps+handles.fresnel,2*pi);
end

if value_dg == 1
    % Diffraction grating hologram
    %Number of grooves
    nx=str2num(get(handles.edit_dg_x,'String'))
    ny=str2num(get(handles.edit_dg_y,'String'))
    
    gx=nx/w; gy=ny/h; %Spatial freq
    grating_vector_x=2*pi/(w/nx); %Grating vectors 2pi/period
    grating_vector_y=2*pi/(w/ny);
    map_dg=mod(2*pi*(Y*gy+X*gx),2*pi); %Grating

    sum_of_maps=mod(sum_of_maps+map_dg,2*pi);
    handles.siatka=map_dg;
    
    set(handles.spatial_freq_x,'string',num2str(grating_vector_x)); %Change spatial freq text
    set(handles.spatial_freq_y,'string',num2str(grating_vector_y)); %Change spatial freq text
end
if value_vortex == 1
    
    %Vortex hologram
    l=str2double(get(handles.edit_vortex,'String'));
    phi=angle(X+1i*Y); %Az. angle
    map_vortex=mod(l*phi,2*pi);
    sum_of_maps=mod(sum_of_maps+map_vortex,2*pi);
    handles.vortex=map_vortex;

end
if value_check_hologram == 1
   sum_of_maps=mod(sum_of_maps+handles.hologram,2*pi); 
end
%Jesli zadna opcja nie jest zaznaczona to biala mapa
%{
if value_vortex ~= 1  && value_fresnel ~= 1 && value_dg ~= 1 && value_d
   sum_of_maps=ones(h,w);
   handles.hologram=sum_of_maps;
end
%}

handles.map=sum_of_maps;
%Jesli zaznaczono dodanie korekcji
if  value_check_plus_corr == 1
    %handles.map=mod(handles.map+handles.correction,2*pi)  
    handles.map=mod(handles.map-handles.correction,2*pi);
end

%Wyswietlanie mapy z uwzglednieniem apertury
%apertura kolowa
if value_aperture == 1
    handles.amp=apertura(ones(handles.h,handles.w), handles.aperture,handles.w,handles.h); %do FT  
    u1=apertura(handles.map,aperture,w,h);
    %Display
    axes(handles.axes_hologram)
     u1=imtranslate(u1,[-misalignment_h, -misalignment_w]);
    imshow(u1,[])
    axis off
    slm2(u1)   
else
    %Display without aperture
    axes(handles.axes_hologram)
    handles.map=imtranslate(handles.map,[-misalignment_h, -misalignment_w])
    imshow(handles.map,[])
    axis off
    slm2(handles.map)
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function do_it_CreateFcn(hObject, eventdata, ~)
% hObject    handle to do_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_vortex_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vortex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vortex as text
%        str2double(get(hObject,'String')) returns contents of edit_vortex as a double
vortex=str2double(get(handles.edit_vortex,'String'));
set(handles.slider1,'Value',vortex);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_vortex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vortex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dg_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dg_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dg_x as text
%        str2double(get(hObject,'String')) returns contents of edit_dg_x as a double
x=str2double(get(handles.edit_dg_x,'String'));
set(handles.slider_dg_x,'Value',x);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_dg_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dg_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dg_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dg_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dg_y as text
%        str2double(get(hObject,'String')) returns contents of edit_dg_y as a double
y=str2double(get(handles.edit_dg_y,'String'));
set(handles.slider_dg_y,'Value',y);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_dg_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dg_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value = round(get(handles.slider1, 'Value'));
    set(handles.slider1, 'Value', value);
    
vortex=get(handles.slider1,'Value');
set(handles.edit_vortex,'String',num2str(vortex));

guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%
%vortex=str2double(get(handles.edit_vortex,'String'));
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject, 'Max', 20, 'Min', -20, 'Value', 1, 'SliderStep', [1/39 1/39]);


% --- Executes on button press in checkbox_fresnel.
function checkbox_fresnel_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_fresnel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_fresnel


% --- Executes on button press in checkbox_dg.
function checkbox_dg_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_dg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_dg


% --- Executes on button press in checkbox_vortex.
function checkbox_vortex_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_vortex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_vortex


% --- Executes on slider movement.
function slider_dg_x_Callback(hObject, eventdata, handles)
% hObject    handle to slider_dg_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

value = get(handles.slider_dg_x, 'Value');
    set(handles.slider_dg_x, 'Value', value);
    
x=get(handles.slider_dg_x,'Value');
set(handles.edit_dg_x,'String',num2str(x));

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_dg_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_dg_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject, 'Max', 512, 'Min', 0, 'Value', 0, 'SliderStep', [1/256 1/256]);


% --- Executes on slider movement.
function slider_dg_y_Callback(hObject, eventdata, handles)
% hObject    handle to slider_dg_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

value = get(handles.slider_dg_y, 'Value');
    set(handles.slider_dg_y, 'Value', value);
    
y=get(handles.slider_dg_y,'Value');
set(handles.edit_dg_y,'String',num2str(y));

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider_dg_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_dg_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject, 'Max', 384, 'Min', 0, 'Value', 0, 'SliderStep', [1/192 1/192]);



function edit_aperture_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aperture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aperture as text
%        str2double(get(hObject,'String')) returns contents of edit_aperture as a double


% --- Executes during object creation, after setting all properties.
function edit_aperture_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aperture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_aperture.
function checkbox_aperture_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_aperture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_aperture


% --- Executes during object creation, after setting all properties.
function axes_camera_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_camera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off

% --- Executes during object creation, after setting all properties.
function axes_hologram2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_hologram2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes_hologram2


% --- Executes during object creation, after setting all properties.
function axes_snap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_snap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes_snap


% --- Executes on button press in pushbutton_snap.
function pushbutton_snap_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_snap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%vid=handles.vid;

%img = getimage(handles.axes_camera);
img=getsnapshot(handles.vid);
%img= im2double(rgb2gray(img));
%img= rgb2gray(img);
[filename,pathname] = uiputfile('snap.bmp','Save file name');
imwrite(img,hsv,[pathname filename]);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function spatial_freq_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spatial_freq_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes_ft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_ft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes_ft


% --- Executes on button press in checkbox_correction.
function checkbox_correction_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_correction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_correction


% --- Executes on button press in check_plus_corr.
function check_plus_corr_Callback(hObject, eventdata, handles)
% hObject    handle to check_plus_corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_plus_corr


% --- Executes on button press in snap_holo.
function snap_holo_Callback(hObject, eventdata, handles)
% hObject    handle to snap_holo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes_hologram);

[filename,pathname] = uiputfile('holo.bmp','Save file name');
imwrite(mat2gray(img), [pathname filename])
guidata(hObject, handles);


% --- Executes on selection change in popupmenu_slm.
function popupmenu_slm_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_slm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Change SLM parameters
val=get(handles.popupmenu_slm,'Value')
switch val;
case 1 % User selects peaks.
   set(handles.edit_width,'string',num2str(1024)); 
   set(handles.edit_height,'string',num2str(768)); 
   set(handles.edit_pixel_size,'string',num2str(19e-6)); 
case 2 % User selects membrane.
   set(handles.edit_width,'string',num2str(1920)); 
   set(handles.edit_height,'string',num2str(1080)); 
   set(handles.edit_pixel_size,'string',num2str(8e-6));
case 3 % User selects membrane.
   set(handles.edit_width,'string',num2str(792)); 
   set(handles.edit_height,'string',num2str(600)); 
   set(handles.edit_pixel_size,'string',num2str(20e-6));
end
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_slm contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_slm


% --- Executes during object creation, after setting all properties.
function popupmenu_slm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_slm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_correction.
function push_correction_Callback(hObject, eventdata, handles)
% hObject    handle to push_correction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
[filename, pathname] = uigetfile({'*.bmp';'*.png';'*.jpg';},'File Selector');
    handles.correction=im2double(imread([pathname filename]))*2*pi;
    %handles.correction=mat2gray(rgb2gray(imread([pathname filename])))*2*pi;
    axes(handles.axes_correction)
    imshow(handles.correction,[])
    axis off
guidata(hObject, handles);
% --- Executes on button press in pushbutton_load_holo.
function pushbutton_load_holo_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_holo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  [filename, pathname] = uigetfile({'*.bmp';'*.png';'*.jpg';},'File Selector');
    %handles.hologram=im2double(rgb2gray(imread([pathname filename])))*2*pi;
    handles.hologram=mat2gray(imread([pathname filename]))*2*pi;
    axes(handles.axes_hologram2)
    imshow(handles.hologram,[])
    axis off
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function axes_correction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_correction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_correction
axis off


% --- Executes on button press in check_hologram.
function check_hologram_Callback(hObject, eventdata, handles)
% hObject    handle to check_hologram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_hologram


% --- Executes during object creation, after setting all properties.
function axes_hologram_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_hologram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_hologram


% --- Executes on selection change in popup_camera.
function popup_camera_Callback(hObject, eventdata, handles)
% hObject    handle to popup_camera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value_camera=get(handles.popup_camera,'Value');

if value_camera==1
axes(handles.axes_camera)
vid = videoinput('winvideo', 2, 'RGB32_2048x1536');
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;
hImage=image(zeros(2048,1536,3),'Parent',handles.axes_camera);
preview(vid,hImage);   
elseif value_camera==2
axes(handles.axes_camera)
vid = videoinput('winvideo', 1, 'YUY2_160x120');
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;
hImage=image(zeros(160,120,3),'Parent',handles.axes_camera);
preview(vid,hImage);   
end     
% --- Executes during object creation, after setting all properties.
function popup_camera_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_camera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_load_rgb.
function push_load_rgb_Callback(hObject, eventdata, handles)
% hObject    handle to push_load_rgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  [filename, pathname] = uigetfile({'*.bmp';'*.png';'*.jpg';},'File Selector');
    handles.hologram=im2double(rgb2gray((imread([pathname filename]))))*2*pi;
    axes(handles.axes_hologram2)
    imshow(handles.hologram,[])
    axis off
guidata(hObject, handles);



function edit_fresnel_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fresnel_x as text
%        str2double(get(hObject,'String')) returns contents of edit_fresnel_x as a double


% --- Executes during object creation, after setting all properties.
function edit_fresnel_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fresnel_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fresnel_y as text
%        str2double(get(hObject,'String')) returns contents of edit_fresnel_y as a double


% --- Executes during object creation, after setting all properties.
function edit_fresnel_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fresnel_angle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fresnel_angle as text
%        str2double(get(hObject,'String')) returns contents of edit_fresnel_angle as a double


% --- Executes during object creation, after setting all properties.
function edit_fresnel_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_minus_correction.
function check_minus_correction_Callback(hObject, eventdata, handles)
% hObject    handle to check_minus_correction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_minus_correction



function edit_misalignment_w_Callback(hObject, eventdata, handles)
% hObject    handle to edit_misalignment_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_misalignment_w as text
%        str2double(get(hObject,'String')) returns contents of edit_misalignment_w as a double


% --- Executes during object creation, after setting all properties.
function edit_misalignment_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_misalignment_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_misalignment_h_Callback(hObject, eventdata, handles)
% hObject    handle to edit_misalignment_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_misalignment_h as text
%        str2double(get(hObject,'String')) returns contents of edit_misalignment_h as a double


% --- Executes during object creation, after setting all properties.
function edit_misalignment_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_misalignment_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_focus_corr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_focus_corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_focus_corr as text
%        str2double(get(hObject,'String')) returns contents of edit_focus_corr as a double


% --- Executes during object creation, after setting all properties.
function edit_focus_corr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_focus_corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fresnel_x_corr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_x_corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fresnel_x_corr as text
%        str2double(get(hObject,'String')) returns contents of edit_fresnel_x_corr as a double


% --- Executes during object creation, after setting all properties.
function edit_fresnel_x_corr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_x_corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fresnel_y_corr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_y_corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fresnel_y_corr as text
%        str2double(get(hObject,'String')) returns contents of edit_fresnel_y_corr as a double


% --- Executes during object creation, after setting all properties.
function edit_fresnel_y_corr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_y_corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fresnel_angle_corr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_angle_corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fresnel_angle_corr as text
%        str2double(get(hObject,'String')) returns contents of edit_fresnel_angle_corr as a double


% --- Executes during object creation, after setting all properties.
function edit_fresnel_angle_corr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_angle_corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_fresnel_corr.
function check_fresnel_corr_Callback(hObject, eventdata, handles)
% hObject    handle to check_fresnel_corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_fresnel_corr



function edit_fresnel_angle_phi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_angle_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fresnel_angle_phi as text
%        str2double(get(hObject,'String')) returns contents of edit_fresnel_angle_phi as a double


% --- Executes during object creation, after setting all properties.


function [handle_value] = get_handles(hObject)
    %Function will return value of input handle
handle_value=str2double(get(hObject,'String'));
