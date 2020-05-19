%{
Application to operate SLM of both types:
 Holoeye PLUTO
 Holoeye LC-R2500
 Hamamatsu
%} 


function varargout = SLM_app2(varargin)
% SLM_APP2 MATLAB code for SLM_app2.fig
%      SLM_APP2, by itself, creates a new SLM_APP2 or raises the existing
%      singleton*.
%
%      H = SLM_APP2 returns the handle to a new SLM_APP2 or the handle to
%      the existing singleton*.
%
%      SLM_APP2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLM_APP2.M with the given input arguments.
%
%      SLM_APP2('Property','Value',...) creates a new SLM_APP2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SLM_app2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SLM_app2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SLM_app2

% Last Modified by GUIDE v2.5 07-Nov-2018 16:30:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SLM_app2_OpeningFcn, ...
                   'gui_OutputFcn',  @SLM_app2_OutputFcn, ...
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


% --- Executes just before SLM_app2 is made visible.
function SLM_app2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SLM_app2 (see VARARGIN)

% Choose default command line output for SLM_app2
handles.output = hObject;

%Camera 
value_camera=get(handles.popup_camera,'Value');

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

    %{
handles.vid = videoinput('winvideo', 3, 'Y800_1928x1208');
vid = videoinput('winvideo', 3, 'Y800_1024x768');
src = getselectedsource(handles.vid);
handles.vid.FramesPerTrigger = 1;
handles.vid.ReturnedColorspace = 'rgb';
%vid.ReturnedColorspace = 'rgb';
preview(handles.vid);

elseif value_camera==2
%}    
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

% UIWAIT makes SLM_app2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = SLM_app2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


function edit_width_Callback(hObject, eventdata, handles)
%Inicialize handle value
%handles.w=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end

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
end

function edit_focus_Callback(hObject, eventdata, handles)

%Inicialize handle value
handles.focus=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end

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
end



function edit_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of edit_height as text
%        str2double(get(hObject,'String')) returns contents of edit_height as a double
end

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
end

function edit_pixel_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pixel_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pixel_size as text
%        str2double(get(hObject,'String')) returns contents of edit_pixel_size as a double
end

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
end

% --- Executes on button press in do_it.
function do_it_Callback(hObject, eventdata, handles)
% hObject    handle to do_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Pobranie wartosci z komorek
%handles.w=str2double(get(handles.edit_width,'String'));
%handles.h=str2double(get(handles.edit_height,'String'));

w=handles.w;
h=handles.h;
handles.aperture=str2double(get(handles.edit_aperture,'String'));

handles.lambda=632.8e-9;
misalignment_w=str2double(get(handles.edit_misalignment_w,'String'));
misalignment_h=str2double(get(handles.edit_misalignment_h,'String'));

%Checkboxes
value_fresnel = get(handles.checkbox_fresnel, 'Value');
value_dg = get(handles.checkbox_dg, 'Value');
value_vortex = get(handles.checkbox_vortex, 'Value');
value_aperture = get (handles.checkbox_aperture, 'Value');
value_check_plus_corr = get (handles.check_plus_corr, 'Value');
value_check_hologram = get(handles.check_hologram, 'Value');

handles.phase_map=zeros(handles.h,handles.w);
if value_fresnel == 1
    handles.fresnel=mod(fresnel(handles.w,handles.h,handles.focus,handles.lambda,handles.pixel_size),2*pi)

    handles.phase_map=add_holograms(handles.phase_map, handles.fresnel);
end

if value_dg == 1
    handles.grating=diff_grating(handles.w,handles.h,handles.nx,handles.ny);
    
    handles.phase_map=add_holograms(handles.phase_map, handles.grating);
    %set(handles.spatial_freq_x,'string',num2str(grating_vector_x)); %Change spatial freq text
    %set(handles.spatial_freq_y,'string',num2str(grating_vector_y)); %Change spatial freq text
end

if value_vortex == 1
    handles.vortex=vortex(handles.w, handles.h, handles.topological_charge)
    
    handles.phase_map=add_holograms(handles.phase_map, handles.vortex);
end

if value_check_hologram == 1
   handles.phase_map=add_holograms(handles.phase_map, handles.hologram);
end

%Jesli zaznaczono dodanie korekcji
if  value_check_plus_corr == 1
    %{
    control=get(handles.correction_panel,'tag')
    switch control;
    case 1 %   
    handles.phase_map=add_holograms(handles.phase_map, handles.correction);
        
    case 2
    handles.phase_map=substract_holograms(handles.phase_map, handles.correction);
    end
    %}
end
end


%Wyswietlanie mapy z uwzglednieniem apertury
%apertura kolowa
if value_aperture == 1
    handles.phase_map=cover_with_aperture(handles.phase_map,handles.aperture)
    %handles.amp=apertura(ones(handles.h,handles.w), handles.aperture,handles.w,handles.h); %do FT  
    %u1=apertura(handles.map,aperture,w,h);
    %Display
    axes(handles.axes_hologram)
    %u1=imtranslate(u1,[-misalignment_h, -misalignment_w]);
    imshow(handles.phase_map,[])
    axis off
    
    slm2(handles.phase_map)   
else
    %Display without aperture
    axes(handles.axes_hologram)
    %handles.phase_map=imtranslate(handles.phase_map,[-misalignment_h, -misalignment_w])
    %imshow(handles.map,[])
    imshow(handles.phase_map,[])
    axis off
    slm2(handles.phase_map)
end

guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function do_it_CreateFcn(hObject, eventdata, ~)
% hObject    handle to do_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
end

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

end


function edit_vortex_Callback(hObject, eventdata, handles)

%Inicialize handle value
handles.topological_charge=get_handles(hObject);

%Set slider value
set(handles.slider1,'Value',handles.topological_charge);

%Update handles
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function edit_vortex_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
%Set default value
    set(hObject,'String','1');
end
%Inicialize default handle value
handles.topological_charge=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end

function edit_dg_x_Callback(hObject, eventdata, handles)
%Inicialize handle value
handles.nx=get_handles(hObject);

%Set slider value
set(handles.slider_dg_x,'Value',handles.nx);

%Set spatial frequency
%grating_vector_x=
%set(handles.spatial_freq_x,'string',num2str(grating_vector_x));

%Update handles
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function edit_dg_x_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
    %Set default value
    set(hObject,'String','0');
end

%Inicialize handle value
handles.nx=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end

function edit_dg_y_Callback(hObject, eventdata, handles)
%Inicialize handle value
handles.ny=get_handles(hObject);

%Set slider value
set(handles.slider_dg_y,'Value',handles.ny);

%Update handles
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function edit_dg_y_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    %Set default value
    set(hObject,'String','0');
end

%Inicialize handle value
handles.ny=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% Vortex slider

%Round slider value
value = round(get(handles.slider1, 'Value'));
    set(handles.slider1, 'Value', value);

%Update topological charge
handles.topological_charge=get(handles.slider1,'Value');
set(handles.edit_vortex,'String',num2str(handles.topological_charge));

%Update handles
guidata(hObject, handles);
end

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
end

% --- Executes on button press in checkbox_fresnel.
function checkbox_fresnel_Callback(hObject, eventdata, handles)
end


% --- Executes on button press in checkbox_dg.
function checkbox_dg_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_dg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_dg
end

% --- Executes on button press in checkbox_vortex.
function checkbox_vortex_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_vortex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_vortex
end

% --- Executes on slider movement.
function slider_dg_x_Callback(hObject, eventdata, handles)
%Slider value set up
value = get(hObject, 'Value');
    set(hObject, 'Value', value);

%Update of number of grooves and edit field    
handles.nx=get(hObject,'Value');
set(handles.edit_dg_x,'String',num2str(handles.nx));

%Handles update
guidata(hObject, handles);
end
% --- Executes during object creation, after setting all properties.
function slider_dg_x_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject, 'Max', 512, 'Min', 0, 'Value', 0, 'SliderStep', [1/256 1/256]);
end

% --- Executes on slider movement.
function slider_dg_y_Callback(hObject, eventdata, handles)
%Slider value set up
value = get(hObject, 'Value');
    set(hObject, 'Value', value);

%Update of number of grooves and edit field    
handles.ny=get(hObject,'Value');
set(handles.edit_dg_y,'String',num2str(handles.ny));

%Handles update
guidata(hObject, handles);
end
% --- Executes during object creation, after setting all properties.
function slider_dg_y_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject, 'Max', 384, 'Min', 0, 'Value', 0, 'SliderStep', [1/192 1/192]);
end


function edit_aperture_Callback(hObject, eventdata, handles)
%Inicialize handle value
handles.aperture=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end
% --- Executes during object creation, after setting all properties.
function edit_aperture_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    %Set default value
    set(hObject,'String','1080');
end

%Inicialize default handle value
handles.aperture=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end


% --- Executes on button press in checkbox_aperture.
function checkbox_aperture_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_aperture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_aperture
end

% --- Executes during object creation, after setting all properties.
function axes_camera_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_camera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
end

% --- Executes during object creation, after setting all properties.
function axes_hologram2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_hologram2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes_hologram2
end

% --- Executes during object creation, after setting all properties.
function axes_snap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_snap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes_snap
end

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
end

% --- Executes during object creation, after setting all properties.
function spatial_freq_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spatial_freq_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end

% --- Executes during object creation, after setting all properties.
function axes_ft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_ft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes_ft
end

% --- Executes on button press in checkbox_correction.
function checkbox_correction_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_correction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_correction
end

% --- Executes on button press in check_plus_corr.
function check_plus_corr_Callback(hObject, eventdata, handles)
% hObject    handle to check_plus_corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_plus_corr
end

% --- Executes on button press in snap_holo.
function snap_holo_Callback(hObject, eventdata, handles)
% hObject    handle to snap_holo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes_hologram);

[filename,pathname] = uiputfile('holo.bmp','Save file name');
imwrite(mat2gray(img), [pathname filename])
guidata(hObject, handles);
end

% --- Executes on selection change in popupmenu_slm.
function popupmenu_slm_Callback(hObject, eventdata, handles)
%Change SLM parameters
val=get(handles.popupmenu_slm,'Value')
switch val
case 1 % User selects Holoeye LC-R2500.
   %Defining parameters
   w=1024;
   h=768;
   pixel_size=19e-6;
case 2 % User selects Holoeye Pluto.
   w=1920;
   h=1080;
   pixel_size=8e-6;
case 3 % User selects Hamamatsu.
   w=792;
   h=600;
   pixel_size=20e-6;
end

   %Update of handles and edit fields
   handles.w=w;
   handles.h=h;
   handles.pixel_size=pixel_size;
   
   set(handles.edit_width,'string',num2str(w));
   set(handles.edit_height,'string',num2str(h));
   set(handles.edit_pixel_size,'string',num2str(pixel_size));

   %Update handles
    guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function popupmenu_slm_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%Defining parameters
   w=1024;
   h=768;
   pixel_size=19e-6;
%Update of handles and edit fields
   handles.w=w;
   handles.h=h;
   handles.pixel_size=pixel_size;

%Update handles
    guidata(hObject, handles);
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
    end
    
% --- Executes on button press in pushbutton_load_holo.
function pushbutton_load_holo_Callback(hObject, eventdata, handles)
  [filename, pathname] = uigetfile({'*.bmp';'*.png';'*.jpg';},'File Selector');
    %handles.hologram=im2double(rgb2gray(imread([pathname filename])))*2*pi;
    handles.hologram=mat2gray(imread([pathname filename]))*2*pi;
    axes(handles.axes_hologram2)
    imshow(handles.hologram,[])
    axis off
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function axes_correction_CreateFcn(hObject, eventdata, handles)
axis off
end

% --- Executes on button press in check_hologram.
function check_hologram_Callback(hObject, eventdata, handles)
end
% --- Executes during object creation, after setting all properties.
function axes_hologram_CreateFcn(hObject, eventdata, handles)
axis off
end

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
end

% --- Executes during object creation, after setting all properties.
function popup_camera_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

% --- Executes on button press in push_load_rgb.
function push_load_rgb_Callback(hObject, eventdata, handles)
  [filename, pathname] = uigetfile({'*.bmp';'*.png';'*.jpg';},'File Selector');
    handles.hologram=im2double(rgb2gray((imread([pathname filename]))))*2*pi;
    axes(handles.axes_hologram2)
    imshow(handles.hologram,[])
    axis off
guidata(hObject, handles);
end


function edit_fresnel_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fresnel_x as text
%        str2double(get(hObject,'String')) returns contents of edit_fresnel_x as a double
end

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
end


function edit_fresnel_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fresnel_y as text
%        str2double(get(hObject,'String')) returns contents of edit_fresnel_y as a double
end

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
end


function edit_fresnel_angle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fresnel_angle as text
%        str2double(get(hObject,'String')) returns contents of edit_fresnel_angle as a double
end

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

end

% --- Executes on button press in check_minus_correction.
function check_minus_correction_Callback(hObject, eventdata, handles)
% hObject    handle to check_minus_correction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_minus_correction
end


function edit_misalignment_w_Callback(hObject, eventdata, handles)
% hObject    handle to edit_misalignment_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_misalignment_w as text
%        str2double(get(hObject,'String')) returns contents of edit_misalignment_w as a double
end

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

end

function edit_misalignment_h_Callback(hObject, eventdata, handles)
% hObject    handle to edit_misalignment_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_misalignment_h as text
%        str2double(get(hObject,'String')) returns contents of edit_misalignment_h as a double
end

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

end

function edit_fresnel_angle_phi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fresnel_angle_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fresnel_angle_phi as text
%        str2double(get(hObject,'String')) returns contents of edit_fresnel_angle_phi as a double


% --- Executes during object creation, after setting all properties.
end


    


% --- Executes during object creation, after setting all properties.
function correction_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to correction_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end

% --- Executes when selected object is changed in correction_panel.
function correction_panel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in correction_panel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
end

function [handle_value] = get_handles(hObject)
    %Function will return value of input handle
handle_value=str2double(get(hObject,'String'));
end

function [ F ] = fresnel(k,w,f,l,pixel_size)
%Function returns hologram of fresnel lens

%[k w] - size of hologram
% f - focus [m]
% l - wavelength

krok=pixel_size; %pixel size [m]
%Coordination system
x_obr=0; %wspolrzedne srodka przesuniecie o 19*10^(-6) to jeden pixel w lewo
y_obr=0;
obrx=k*krok;
obry=w*krok;
bokx=x_obr-obrx/2;
boky=y_obr-obry/2;

for m=1:k
   for n=1:w
      x=bokx+m*krok;
      y=boky+n*krok;
      r=sqrt(x.^2+y.^2);
F(n,m)=mod((1*pi*r^2)/(l*f),2*pi);
   end
end

end

    function [ grating_hologram ] = diff_grating(w,h,nx,ny)
%Function returns hologram of fresnel lens

%[w h] - size of hologram
% [nx ny] - number of grooves
    %Coordination system set up
    x=-w/2:1:(w/2-1);
    y=-h/2:1:(h/2-1);
    
    [X,Y]=meshgrid(x, y);
    
    %Spatial freq
    gx=nx/w; gy=ny/h; 
    
    %Grating vectors = 2pi/period
    grating_vector_x=2*pi/(w/nx); 
    grating_vector_y=2*pi/(w/ny);
    
    %Grating hologram
    grating_hologram=mod(2*pi*(Y*gy+X*gx),2*pi); 

    end
    
    function [vortex_hologram] = vortex(w, h, m)
    %Function returns hologram of optical vortex with proper topological charge
    %[w h] - size of hologram
    %m - topological charge value
    x=-w/2:1:(w/2-1);
    y=-h/2:1:(h/2-1);
    
    [X,Y]=meshgrid(x, y);
    phi=angle(X+1i*Y);
    vortex_hologram=mod(m*phi,2*pi);
    end
    
function [phase_map] = add_holograms (phase_map, A)
%Function adds two holograms
%phase_map, A - holograms to add

phase_map=mod(phase_map+A,2*pi);
end

function [phase_map] = substract_holograms (phase_map, A)
%Function substracts two holograms
%phase_map, A - holograms to substract

phase_map=mod(phase_map-A,2*pi);
end

function [I] = cover_with_aperture(I,aperture)
%Function covers hologram with circular apertue

%I - hologram
%aperture-aperture diameter

    %Coordination set up
    [h,w]=size(I);
    centerY=h/2;
    centerX=w/2;
    
    %Circular aperture
    [columnsInImage rowsInImage] = meshgrid(1:w, 1:h);
    circlePixels = (rowsInImage - centerY).^2 + (columnsInImage - centerX).^2<= (aperture/2).^2;
    mapa=ones(h,w);
    map_aperture=circlePixels.*mapa;
    
    %Aperture addition
    I=map_aperture.*I;
end