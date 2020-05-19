%{
Application to operate SLM of both types:
 Holoeye PLUTO
 Holoeye LC-R2500
 Hamamatsu
%} 


function varargout = App_G_S(varargin)
% APP_G_S MATLAB code for App_G_S.fig
%      APP_G_S, by itself, creates a new APP_G_S or raises the existing
%      singleton*.
%
%      H = APP_G_S returns the handle to a new APP_G_S or the handle to
%      the existing singleton*.
%
%      APP_G_S('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APP_G_S.M with the given input arguments.
%
%      APP_G_S('Property','Value',...) creates a new APP_G_S or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before App_G_S_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to App_G_S_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help App_G_S

% Last Modified by GUIDE v2.5 15-Nov-2018 22:10:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @App_G_S_OpeningFcn, ...
                   'gui_OutputFcn',  @App_G_S_OutputFcn, ...
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
end

% --- Executes just before App_G_S is made visible.
function App_G_S_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to App_G_S (see VARARGIN)

% Choose default command line output for App_G_S
handles.output = hObject;
%{
%Camera 
value_camera=get(handles.popup_camera,'Value');

if value_camera==1

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

%{
handles.vid  = videoinput('winvideo', 1, 'YUY2_160x120');
src = getselectedsource(handles.vid );
handles.vid.FramesPerTrigger = 1;
%h=figure()
%hImage=image(zeros(2048,1536,3));
%handles.vid.ROIPosition = [0 0 100 100]
preview(handles.vid);
%hImage(preview(handles.vid));
%handles.vid = imrect

elseif value_camera==3
handles.vid  = videoinput('winvideo', 3, 'Y800_1928x1208');
src = getselectedsource(vid);
handles.vid .FramesPerTrigger = 1;
%vid.ReturnedColorspace = 'rgb';
src.Exposure = -6;
src.FrameRate = '25.0000';
preview(handles.vid);
end

%}
guidata(hObject, handles);

% UIWAIT makes App_G_S wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end

% --- Outputs from this function are returned to the command line.
function varargout = App_G_S_OutputFcn(hObject, eventdata, handles) 
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


function do_it_Callback(hObject, eventdata, handles)
misalignment_w=str2double(get(handles.edit_misalignment_w,'String'));
misalignment_h=str2double(get(handles.edit_misalignment_h,'String'));

%Phase map definition
handles.phase_map=zeros(handles.h,handles.w);

%Fresnel lens additon
if handles.value_fresnel == 1
    handles.fresnel=mod(fresnel(handles.w,handles.h,handles.focus,handles.lambda,handles.pixel_size),2*pi);

    handles.phase_map=add_holograms(handles.phase_map, handles.fresnel);
end

%Diffraction grating additon
if handles.value_dg == 1
    handles.grating=diff_grating(handles.w,handles.h,handles.nx,handles.ny);
    
    
    handles.phase_map=add_holograms(handles.phase_map, handles.grating);
           
end

%Vortex addition
if handles.value_vortex == 1
    handles.vortex=vortex(handles.w, handles.h, handles.topological_charge);
    
    handles.phase_map=add_holograms(handles.phase_map, handles.vortex);
end

%Bessel beam addition
if handles.value_bessel ==1
   handles.bessel=bessel(handles.w, handles.h, handles.pixel_size, handles.lambda, handles.bessel_n, handles.bessel_alpha);
   
   handles.phase_map=add_holograms(handles.phase_map, handles.bessel);
end

%Hologram addition
if handles.value_hologram == 1
   handles.phase_map=add_holograms(handles.phase_map, handles.hologram);
end

%Correction map
if  handles.value_correction == 1
    switch(get(get(handles.correction_panel,'SelectedObject'), 'String'))
        case '+' %Selected + button
                handles.phase_map=add_holograms(handles.phase_map, handles.correction);
        case '-' %Selected i button
                handles.phase_map=substract_holograms(handles.phase_map, handles.correction);
    end
end
    
%Aperture cover
if handles.value_aperture == 1
    
    handles.phase_map=cover_with_aperture(handles.phase_map,handles.aperture);
    %Display
    axes(handles.axes_hologram)
    %u1=imtranslate(u1,[-misalignment_h, -misalignment_w]);
    imshow(handles.phase_map,[])
    axis off
    %SLM display
    slm2(handles.phase_map)
    
else
    
    %Display without aperture
    axes(handles.axes_hologram)
    imshow(handles.phase_map,[])
    axis off
    %SLM display
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
period=handles.w/handles.nx;
handles.grating_vector_x=2*pi/period;
set(handles.spatial_freq_x,'string',num2str(handles.grating_vector_x));

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

%Set spatial frequency
period=handles.h/handles.ny;
handles.grating_vector_y=2*pi/period;
set(handles.spatial_freq_y,'string',num2str(handles.grating_vector_y));

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
handles.value_fresnel = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end

% --- Executes on button press in checkbox_dg.
function checkbox_dg_Callback(hObject, eventdata, handles)
handles.value_dg = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end

% --- Executes on button press in checkbox_vortex.
function checkbox_vortex_Callback(hObject, eventdata, handles)
handles.value_vortex = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end

% --- Executes on slider movement.
function slider_dg_x_Callback(hObject, eventdata, handles)
%Slider value set up
value = get(hObject, 'Value');
    set(hObject, 'Value', value);

%Update of number of grooves and edit field    
handles.nx=get(hObject,'Value');
set(handles.edit_dg_x,'String',num2str(handles.nx));

%Set spatial frequency
period=handles.w/handles.nx;
handles.grating_vector_x=2*pi/period;
set(handles.spatial_freq_x,'string',num2str(handles.grating_vector_x));

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

%Set spatial frequency
period=handles.h/handles.ny;
handles.grating_vector_y=2*pi/period;
set(handles.spatial_freq_y,'string',num2str(handles.grating_vector_y));

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
handles.value_aperture = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function axes_hologram2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_hologram2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes_hologram2
end

% --- Executes on button press in pushbutton_snap.
function pushbutton_snap_Callback(hObject, eventdata, handles)

%Get snapshot
img=getsnapshot(handles.vid);

%Convert
if length(size(img))~= 2
img= im2double(rgb2gray(img));
end


[filename,pathname] = uiputfile('snap.bmp','Save file name');

imwrite(mat2gray(img), [pathname filename]);

guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function spatial_freq_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spatial_freq_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end

% --- Executes on button press in check_plus_corr.
function check_plus_corr_Callback(hObject, eventdata, handles)
handles.value_correction = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function checkbox_dg_CreateFcn(hObject, eventdata, handles)
handles.value_dg = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function checkbox_fresnel_CreateFcn(hObject, eventdata, handles)
handles.value_fresnel = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function checkbox_vortex_CreateFcn(hObject, eventdata, handles)
handles.value_vortex = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function checkbox_aperture_CreateFcn(hObject, eventdata, handles)
handles.value_aperture = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function check_plus_corr_CreateFcn(hObject, eventdata, handles)
%set(hObject, 'Value')=0;
handles.value_correction = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function check_hologram_CreateFcn(hObject, eventdata, handles)
%set(hObject, 'Value')=0;
handles.value_hologram = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);

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
switch val;
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
   handles.lambda=632.8e-9; 
%Update handles
    guidata(hObject, handles);
end
    
% --- Executes on button press in push_correction.
function push_correction_Callback(hObject, eventdata, handles)
    %Open dialog box
    [filename, pathname] = uigetfile({'*.bmp';'*.png';'*.jpg';},'File Selector');
    
    %Case hologram is a grayscale image
    handles.correction=mat2gray(imread([pathname filename]))*2*pi;
    
    %Case hologram is a RGB image
    if (length(size(handles.correction))==3)
        handles.correction=im2double(rgb2gray(imread([pathname filename])))*2*pi;
    end
    
    %Display
    axes(handles.axes_correction)
    imshow(handles.correction,[])
    axis off
    

guidata(hObject, handles);
end

% --- Executes on button press in pushbutton_load_holo.
function pushbutton_load_holo_Callback(hObject, eventdata, handles)

    %Open dialog box
    [filename, handles.pathname] = uigetfile({'*.jpg;*.bmp;*.png;','Graphics (*.jpg,*.bmp,*.png)'},'File Selector', 'MultiSelect','on');
  
    %Update listbox
    set(handles.listbox_hologram,'Value',1);
    set(handles.listbox_hologram, 'string', filename);
    
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function axes_correction_CreateFcn(hObject, eventdata, handles)
axis off
end

% --- Executes on button press in check_hologram.
function check_hologram_Callback(hObject, eventdata, handles)
handles.value_hologram = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function axes_hologram_CreateFcn(hObject, eventdata, handles)
axis off
end

% --- Executes on selection change in popup_camera.
function popup_camera_Callback(hObject, eventdata, handles)

%Close preview if preview exist
try
closepreview(handles.vid); 
catch
end

%Check selected camera info
%Value camera, gets index of device in image acquisition tool, -1 because
%first line is empty
handles.value_camera=get(handles.popup_camera,'Value')-1;
dev_info = imaqhwinfo('winvideo', handles.value_camera);
format=dev_info.DefaultFormat;

%Inicialize video
handles.vid  = videoinput('winvideo', handles.value_camera, format);
src = getselectedsource(handles.vid );
handles.vid.FramesPerTrigger = 1;

%Check if it's possible to change colorspace to RGB
try
    handles.vid.ReturnedColorspace = 'rgb';
catch
end

preview(handles.vid);

%List another available resolutions
possible_formats=dev_info.SupportedFormats;

%Update formats lists
set(handles.popup_camera_resolution,'String',possible_formats);
set(handles.popup_camera_resolution,'Value',1);
%Update handles
guidata(hObject, handles);
end


function popup_camera_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Check available camera devices
info = imaqhwinfo('winvideo');
num_of_devices=length(info.DeviceInfo);


%List all of available devices
names_cellstr={};
for i=1:1:num_of_devices
dev_info = imaqhwinfo('winvideo', i);
name=dev_info.DeviceName;
names_cellstr{i+1} = name;
end

%Update camera lists
set(hObject,'String',names_cellstr);

%Update handles
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
%Funkcja returns hologram of fresnel lens

%[k w] - size of hologram
% f - focus [m]
% l - wavelength
% pixel_size - pixel size in [m]
krok=pixel_size; 
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
%Funkcja returns hologram of fresnel lens

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

function [bessel_hologram] = bessel(w, h, pixel_size, l, n, alpha)
%Function returns hologram of optical vortex with proper topological charge
%[w h] - size of hologram
%l - wavelength
%n - refractive index
%alpha - axicon angle
x=-w/2:1:(w/2-1);
y=-h/2:1:(h/2-1);
x=x*pixel_size;
y=y*pixel_size;

[X,Y]=meshgrid(x, y);
rho = sqrt(X.^2+Y.^2);
alpha=alpha*pi/180; %angle in [rad]
k=2*pi/l;

kr=k*alpha*(n-1);
bessel_hologram=mod(kr*rho,2*pi);
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

function list_holograms(filenames,pathnames)
%filenames - vector containing list of file names
%pathnames - vector containing list of file paths

number=length(filenames);

end



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
%Close camera preview
try
closepreview(handles.vid); 
catch
end
delete(hObject);
end



function edit_bessel_n_Callback(hObject, eventdata, handles)
%Inicialize handle value
handles.bessel_n=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function edit_bessel_n_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
%Set default value
    set(hObject,'String','1.5');
end
%Inicialize default handle value
handles.bessel_n=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end


function edit_bessel_alpha_Callback(hObject, eventdata, handles)
%Inicialize handle value
handles.bessel_alpha=get_handles(hObject);

%Update handles
guidata(hObject, handles); as a double
end


function edit_bessel_alpha_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
%Set default value
    set(hObject,'String','0.2');
end
%Inicialize default handle value
handles.bessel_alpha=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end

% --- Executes on button press in check_bessel.
function check_bessel_Callback(hObject, eventdata, handles)
handles.value_bessel = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function check_bessel_CreateFcn(hObject, eventdata, handles)
handles.value_bessel = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


% --- Executes on selection change in listbox_hologram.
function listbox_hologram_Callback(hObject, eventdata, handles)

filenames=cellstr(get(hObject,'String'));
chosen_file=get(hObject,'Value');

    %Case hologram is a grayscale image
    handles.hologram=mat2gray(imread([handles.pathname char(filenames(chosen_file))]))*2*pi;
    
    %Case hologram is a RGB image
    if (length(size(handles.hologram))==3)
        handles.hologram=im2double(rgb2gray(imread([handles.pathname char(filenames(chosen_file))])))*2*pi;
    end
    
    %Display
    axes(handles.axes_hologram2)
    imshow(handles.hologram,[])
    axis off
    
    %Update handles
    guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function listbox_hologram_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function edit_rotation_angle_Callback(hObject, eventdata, handles)
%Inicialize handle value
handles.rotation_angle=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function edit_rotation_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rotation_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
%Set default value
    set(hObject,'String','0');
end
%Inicialize default handle value
handles.rotation_angle=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end


% --- Executes on selection change in popup_camera_resolution.
function popup_camera_resolution_Callback(hObject, eventdata, handles)

%Close current preview if exist
try 
closepreview(handles.vid) 
catch
end

%Check selected format
available_formats=cellstr(get(hObject,'String'));
value_fromat=get(handles.popup_camera_resolution,'value');

%Inicialize video
handles.vid  = videoinput('winvideo', handles.value_camera, available_formats{value_fromat});
src = getselectedsource(handles.vid );
handles.vid.FramesPerTrigger = 1;

%Check if it's possbile to change colorspace to rgb
try
    handles.vid.ReturnedColorspace = 'rgb';
catch
end


preview(handles.vid);

%Update handles
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function popup_camera_resolution_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end


% --- Executes on button press in pushbutton_1st_grating.
function pushbutton_1st_grating_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_1st_grating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    switch(get(get(handles.axes_panel,'SelectedObject'), 'String'))
        case 'x' %Selected x button
                set(handles.text_1st_grating,'string',num2str(handles.nx));
                set(handles.text_grating_vector_1st,'string',num2str(handles.grating_vector_x));
                
                handles.n_1st=handles.nx;
        case 'y' %Selected y button
                set(handles.text_1st_grating,'string',num2str(handles.ny));
                set(handles.text_grating_vector_1st,'string',num2str(handles.grating_vector_y));
   
                handles.n_1st=handles.ny;
        end
    
%Update handles
guidata(hObject, handles);
end

% --- Executes on button press in pushbutton_2nd_grating.
function pushbutton_2nd_grating_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_2nd_grating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    switch(get(get(handles.axes_panel,'SelectedObject'), 'String'))
        case 'x' %Selected x button
                set(handles.text_2nd_grating,'string',num2str(handles.nx));
                set(handles.text_grating_vector_2nd,'string',num2str(handles.grating_vector_x));
            
                handles.n_2nd=handles.nx;
        case 'y' %Selected y button
                set(handles.text_2nd_grating,'string',num2str(handles.ny));
                set(handles.text_grating_vector_2nd,'string',num2str(handles.grating_vector_y));
    
                handles.n_2nd=handles.ny;
    end
    
%Update handles
guidata(hObject, handles);    
end

% --- Executes on button press in pushbutton_g_s.
function pushbutton_g_s_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_g_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in pushbutton_set_up_values.
function pushbutton_set_up_values_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set_up_values (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Calculate grating vector difference [1/px]
handles.grating_vector_diff=abs(str2double(get(handles.text_grating_vector_2nd,'string')) - str2double(get(handles.text_grating_vector_1st,'string')));
handles.aperture_g_s=str2double(get(handles.edit_aperture_g_s,'string'));

pause(2); 
%Calculate position difference
switch(get(get(handles.axes_panel,'SelectedObject'), 'String'))
 
   
    case 'x' %Selected x button
                
                %Display 1st diffraction grating
                mapa=diff_grating(handles.w,handles.h,handles.n_1st,0);
                mapa=cover_with_aperture(mapa,handles.aperture);
                [row,col]=get_positon(handles.vid, mapa, handles.phase_map);
                position_1=col;
                
                %Display 2ndt diffraction grating
                mapa=diff_grating(handles.w,handles.h,handles.n_2nd,0);
                mapa=cover_with_aperture(mapa,handles.aperture);
                [row,col]=get_positon(handles.vid, mapa, handles.phase_map);
                position_2=col;
                
                %Calculate position difference
                handles.position_diff=abs(position_2-position_1);
                        
        case 'y' %Selected y button
            try
                %Display 1st diffraction grating
                mapa=diff_grating(handles.w,handles.h,0,handles.n_1st);
                mapa=cover_with_aperture(mapa,handles.aperture);               
                [row,col]=get_positon(handles.vid, mapa, handles.phase_map);
                
                position_1=row;
                
                %Display 2ndt diffraction grating
                mapa=diff_grating(handles.w,handles.h,0,handles.n_2nd);
                mapa=cover_with_aperture(mapa,handles.aperture);
                [row,col]=get_positon(handles.vid, mapa, handles.phase_map);
                
                position_2=row;
                
                %Calculate position difference
                handles.position_diff=abs(position_2-position_1);
            catch
            end
         end


%Calculate padding value
handles.padding=calculate_padding(handles.aperture_g_s, handles.grating_vector_diff, handles.position_diff, handles.aperture);

%Round to nearest even integer
handles.padding=round((handles.padding-2)/2)*2+2;

%Set padding value
set(handles.edit_padding,'string',num2str(handles.padding));

%Update handles
guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function text_1st_grating_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_1st_grating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end

function [m_array] = calculate_padding( aperture, grating_vector_diff, position_diff, m_holo)
%aperture - size of the aperture used in algorithm [px]
%grating_vector_diff - abs difference of two grating vectors [1/px]
%position_diff - distance between two position of the beam [px]
%m_holo - diameter of the hologram on slm [px]

grating_vector_diff=abs(grating_vector_diff);

%Calculate size of matrix to padd to
m_array=aperture*2*pi*position_diff/(m_holo*grating_vector_diff);
end



function edit_aperture_g_s_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aperture_g_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aperture_g_s as text
%        str2double(get(hObject,'String')) returns contents of edit_aperture_g_s as a double
end

% --- Executes during object creation, after setting all properties.
function edit_aperture_g_s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aperture_g_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function [row,col] = get_positon(vid, map, phase_map);
%vid - video object
%map - phase map to display on slm

                %display phase map
                map=mod(phase_map+map,2*pi);
                slm2(map)
                pause(3)
                %Get snapshot
                img=getsnapshot(vid);
                if length(size(img))~= 2
                img= im2double(rgb2gray(img));
                end
                
                %Get position
                figure()
                imshow(img)
                [col,row] = ginput(1)
                close()
                %Convert
                %if length(size(img))~= 2
                %img= im2double(rgb2gray(img));
                %end
                
                %Find max value
                %[Value,Ind]=max(img(:));
                %[row,col]=ind2sub(size(img),Ind);
end



function edit_padding_Callback(hObject, eventdata, handles)
% hObject    handle to edit_padding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_padding as text
%        str2double(get(hObject,'String')) returns contents of edit_padding as a double
end

% --- Executes during object creation, after setting all properties.
function edit_padding_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_padding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
