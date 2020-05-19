%{
Application to operate SLM of both types:
 Holoeye PLUTO
 Holoeye LC-R2500
 Hamamatsu
%} 


function varargout = SLM_application(varargin)
% SLM_APPLICATION MATLAB code for SLM_application.fig
%      SLM_APPLICATION, by itself, creates a new SLM_APPLICATION or raises the existing
%      singleton*.
%
%      H = SLM_APPLICATION returns the handle to a new SLM_APPLICATION or the handle to
%      the existing singleton*.
%
%      SLM_APPLICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLM_APPLICATION.M with the given input arguments.
%
%      SLM_APPLICATION('Property','Value',...) creates a new SLM_APPLICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SLM_application_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SLM_application_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SLM_application

% Last Modified by GUIDE v2.5 28-Aug-2019 17:47:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SLM_application_OpeningFcn, ...
                   'gui_OutputFcn',  @SLM_application_OutputFcn, ...
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

% --- Executes just before SLM_application is made visible.
function SLM_application_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SLM_application (see VARARGIN)

% Choose default command line output for SLM_application
handles.output = hObject;


guidata(hObject, handles);

% UIWAIT makes SLM_application wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end

% --- Outputs from this function are returned to the command line.
function varargout = SLM_application_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


function edit_width_Callback(hObject, eventdata, handles)
%Update handle value
handles.w=get_handles(hObject);

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
%Inicialize default handle value
handles.h=get_handles(hObject);

%Update handles
guidata(hObject, handles);
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
    
    %Set default value
    set(hObject,'String','768');
end

%Inicialize default handle value
handles.h=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end


function edit_pixel_size_Callback(hObject, eventdata, handles)
%Inicialize default handle value
handles.pixel_size=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end

function edit_pixel_size_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
    %Set default value
    set(hObject,'String','19e-6');
end

%Inicialize default handle value
handles.pixel_size=get_handles(hObject);

%Update handles
guidata(hObject, handles);
end


function do_it_Callback(hObject, eventdata, handles)
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
    
    %Sinusoidal grating with vortex
    if handles.value_sin_dg == 1
        handles.sin_grating=diff_grating(handles.w,handles.h,handles.nx,handles.ny);
        vortex_phase=vortex(handles.w, handles.h, handles.topological_charge);
        holo=exp(1i.*handles.grating)+exp(1i.*vortex_phase);
        hologram=abs(holo).^2;
        handles.grating=(hologram/max(max(hologram)))*2*pi; %normalized to unity 
    end
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

%Constant phase shift
if handles.value_phase_shift == 1
    handles.constant_phase=mod(zeros(handles.h,handles.w) + handles.phase_shift*2*pi/360,2*pi);
    
    
    handles.phase_map=add_holograms(handles.phase_map, handles.constant_phase);
           
end

%Zernike polynomials
if handles.value_zernike_polynomial == 1
   
   %Take data from uitable_zernike_polynomials
   ZernikeData = get(handles.uitable_zernike_polynomials, 'data');
   ZernikeNames = get(handles.uitable_zernike_polynomials, 'RowName');
   Values=ZernikeData(:,2);
   number_of_elements=length(Values);
   
   %Calculate all zernike polynomials
   for i=1:1:number_of_elements
       %Function will add each zernike polynomial, in case of 0 coefficient
       %value, function do_zernike will return 0  
       Polynomial_name=ZernikeNames{i};
       Polynomial_name=str2num(Polynomial_name);
       Zernike_polynomial=do_zernike(handles.w,handles.h,Polynomial_name(1),Polynomial_name(2),Values{i});
       
       %Add new polynomial to exhisting phase_map
       handles.phase_map=add_holograms(handles.phase_map, Zernike_polynomial );
   end
end 


%Translation
if or(handles.misalignment_h,handles.misalignment_w) ~= 0
handles.phase_map=imtranslate(handles.phase_map,[-handles.misalignment_h, -handles.misalignment_w]);
end

%Aperture cover
if handles.value_aperture == 1
    
    handles.phase_map2=cover_with_aperture(handles.phase_map,handles.aperture);
    %Display
    axes(handles.axes_hologram)
   
    imshow(handles.phase_map2,[])
    axis off
    %SLM display
    slm2(handles.phase_map2)
    
else
    
    %Display without aperture
    axes(handles.axes_hologram)
    imshow(handles.phase_map,[0 2*pi])
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


function slider1_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject, 'Max', 20, 'Min', -20, 'Value', 1, 'SliderStep', [1/39 1/39]);
end

% --- Executes on button press in checkbox_fresnel.
function checkbox_fresnel_Callback(hObject, eventdata, handles)

%Update value
handles.value_fresnel = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end

% --- Executes on button press in checkbox_dg.
function checkbox_dg_Callback(hObject, eventdata, handles)

%Update value
handles.value_dg = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end

% --- Executes on button press in check_sinusoidal_grating.
function check_sinusoidal_grating_Callback(hObject, eventdata, handles)
%Update value
handles.value_sin_dg = get(hObject, 'Value');

%Update handles
guidata(hObject, handles)
end

% --- Executes on button press in checkbox_vortex.
function checkbox_vortex_Callback(hObject, eventdata, handles)

%Update value
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

function slider_dg_x_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject, 'Max', 512, 'Min', 0, 'Value', 0, 'SliderStep', [1/256 1/256]);
end


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


function slider_dg_y_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject, 'Max', 384, 'Min', 0, 'Value', 0, 'SliderStep', [1/192 1/192]);
end


function edit_aperture_Callback(hObject, eventdata, handles)

%Inicialize handle value
handles.aperture=get_handles(hObject);

%Update aperture_g_s value
handles.aperture_g_s=handles.aperture;
set(handles.radiobutton8, 'Value', 1);
set(handles.edit_aperture_g_s, 'String', num2str(handles.aperture_g_s));

%Update handles
guidata(hObject, handles);
end


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

%Update value
handles.value_aperture = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


function axes_hologram2_CreateFcn(hObject, eventdata, handles)
axis off
end


function pushbutton_snap_Callback(hObject, eventdata, handles)

%Get snapshot
img=getsnapshot(handles.vid);

%Convert
if length(size(img))~= 2
img= im2double(rgb2gray(img));
end

%Save
[filename,pathname] = uiputfile('snap.bmp','Save file name');
imwrite(mat2gray(img), [pathname filename]);

%Update handles
guidata(hObject, handles);
end

function spatial_freq_x_CreateFcn(hObject, eventdata, handles)

end

% --- Executes on button press in check_plus_corr.
function check_plus_corr_Callback(hObject, eventdata, handles)

%Update value
handles.value_correction = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


function checkbox_dg_CreateFcn(hObject, eventdata, handles)
%Update value
handles.value_dg = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


function checkbox_fresnel_CreateFcn(hObject, eventdata, handles)

%Update value
handles.value_fresnel = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


function checkbox_vortex_CreateFcn(hObject, eventdata, handles)
%Update value
handles.value_vortex = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end

function checkbox_aperture_CreateFcn(hObject, eventdata, handles)

%Update value
handles.value_aperture = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


function check_plus_corr_CreateFcn(hObject, eventdata, handles)

%Update value
handles.value_correction = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


function check_hologram_CreateFcn(hObject, eventdata, handles)

%Update value
handles.value_hologram = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);

end


function snap_holo_Callback(hObject, eventdata, handles)

%Take image from axes
img = getimage(handles.axes_hologram);

%Save image
[filename,pathname] = uiputfile('holo.bmp','Save file name');
imwrite(mat2gray(img), [pathname filename])

%Update handles
guidata(hObject, handles);
end

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

function pushbutton_load_holo_Callback(hObject, eventdata, handles)

    %Open dialog box
    [filename, handles.pathname] = uigetfile({'*.jpg;*.bmp;*.png;','Graphics (*.jpg,*.bmp,*.png)'},'File Selector', 'MultiSelect','on');
  
    %Update listbox
    set(handles.listbox_hologram,'Value',1);
    set(handles.listbox_hologram, 'string', filename);

    %Update handles
    guidata(hObject, handles);
end


function axes_correction_CreateFcn(hObject, eventdata, handles)
axis off
end

function check_hologram_Callback(hObject, eventdata, handles)

%Update value
handles.value_hologram = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end

function axes_hologram_CreateFcn(hObject, eventdata, handles)
axis off
end

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

end


function edit_misalignment_w_Callback(hObject, eventdata, handles)

%Update value
handles.misalignment_w = str2double(get(hObject, 'String'));

%Update handles
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function edit_misalignment_w_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Inicialize value
handles.misalignment_w=0;

%Update handles
guidata(hObject, handles);
end


function edit_misalignment_h_Callback(hObject, eventdata, handles)

%Update value
handles.misalignment_h = str2double(get(hObject, 'String'));

%Update handles
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function edit_misalignment_h_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Inicialize value

handles.misalignment_h=0;
%Update handles
guidata(hObject, handles);
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
    %handles.hologram=mat2gray(imread([handles.pathname char(filenames(chosen_file))]))*2*pi;
     handles.hologram=mat2gray(imread([handles.pathname char(filenames(chosen_file))]),[0 255])*2*pi;
    %Case hologram is a RGB image
    if (length(size(handles.hologram))==3)
        handles.hologram=im2double(rgb2gray(imread([handles.pathname char(filenames(chosen_file))])))*2*pi;
    end
    
    %Display
    axes(handles.axes_hologram2)
    imshow(handles.hologram,[0 2*pi])
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


function pushbutton_1st_grating_Callback(hObject, eventdata, handles)

%Update values of 1st grating

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


function pushbutton_2nd_grating_Callback(hObject, eventdata, handles)

%Update values of 2nd grating
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


function pushbutton_g_s_Callback(hObject, eventdata, handles)
%Function performes G-S algorithm

%% Parameters 
Iterations=str2double(get(handles.edit_g_s_iterations,'String'));
set(handles.edit_g_s_iterations,'String',num2str(0));
set(handles.edit_g_s_iterations,'BackgroundColor','blue');
%% Final map size [px]

%Size to crop
w2=handles.w;
h2=handles.h;


%% Diameter of the amplitude aperture
aperture_diameter=str2double(get(handles.edit_aperture_g_s,'String'));

%% M_array size used for calculations
padsize=handles.padding;
w=padsize;
h=padsize;

%% Perfect vortex
x=-w/2:1:(w/2-1);y=-h/2:1:(h/2-1);
[X,Y]=meshgrid(x, y);
l=handles.topological_charge;
phi=angle(X+1i*Y);%%Azimuthal angle
vortex=mod(l*phi,2*pi); %Phase


%% Experimental source image of focused vortex
%Case hologram is a grayscale image
[row,col] = get_positon_2(handles.vid);

handles.half_side=round(abs(col(2)-col(1)));

handles.center=[row(1), col(1)];

source=im_crop(getsnapshot(handles.vid),handles.center,handles.half_side);

[sizey sizex]=size(source);


%% Zero padding of experimental source image
source=padarray(source,round([(handles.padding-sizey)/2 (handles.padding-sizex)/2]));

amp=apertura(ones(handles.padding,handles.padding),aperture_diameter,handles.padding,handles.padding);


%% G_S algorithm
H=vortex;
E=amp.*exp(1i.*H); %Exchanging phase
    E_FT=fftshift(fft2(E));
    I=abs(E_FT).^2;

clear phi l X Y x y
for i=1:1:Iterations
set(handles.edit_g_s_iterations,'String',num2str(i));

    E=amp.*exp(1i.*H); %Exchanging phase
    E_FT=fftshift(fft2(E));

    H=angle(E_FT)+pi; %Fourier domain
    
    E2=source.*exp(1i.*H); %Exchanging amplitude
    E2=ifft2(ifftshift(E2));
    
    H=angle(E2)+pi; %SLM domain

end

I=abs(E_FT).^2;
clear E E2 amp
    
%error = [error; sum(sum(abs(1.32*abs(E_FT) - source)))];  

clear E_FT
%% Preparing correction map
C=mod(H-vortex,2*pi);

C=apertura(C,aperture_diameter,padsize,padsize);

clear H

%C=imresize(C,4,'nearest');
C=imresize(C,convergent(handles.aperture/aperture_diameter),'nearest');
[p3, p4] = size(C);
q2 = w-1; 
q1 = h-1;
i3_start = floor((p3-q1)/2); 
i3_stop = i3_start + q1;

i4_start = floor((p4-q2)/2);
i4_stop = i4_start + q2;

C = C(i3_start:i3_stop, i4_start:i4_stop);
%C = C(1:i3_stop, 1:i4_stop);

C=apertura(C,handles.aperture,w,h);
C=imcrop(C,[(padsize/2-w2/2) (padsize/2-h2/2) w2-1 h2-1]);
%C=fliplr(C);

%% Display final map
handles.correction=C;
axes(handles.axes_correction)
imshow(handles.correction,[])
axis off

clear source

set(handles.edit_g_s_iterations,'BackgroundColor','white');

%Update handles
guidata(hObject, handles);

end


function pushbutton_set_up_values_Callback(hObject, eventdata, handles)
%Function will calculate size of matrix, required by g-s alogirthm, based
%on optical vortex image shift due to diffraction grating display and on
%aperture size

%Calculate grating vector difference [1/px]
handles.grating_vector_diff=abs(str2double(get(handles.text_grating_vector_2nd,'string')) - str2double(get(handles.text_grating_vector_1st,'string')));
%handles.aperture_g_s=str2double(get(handles.edit_aperture_g_s,'string'));

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
handles.aperture_g_s=str2double(get(handles.edit_aperture_g_s,'String'));
handles.padding=calculate_padding(handles.aperture_g_s, handles.grating_vector_diff, handles.position_diff, handles.aperture);

%Round to nearest even integer
handles.padding=round((handles.padding-2)/2)*2+2;

%Set padding value
set(handles.edit_padding,'string',num2str(handles.padding));

%Update handles
guidata(hObject, handles);
end

function text_1st_grating_CreateFcn(hObject, eventdata, handles)

end

function edit_aperture_g_s_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aperture_g_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aperture_g_s as text
%        str2double(get(hObject,'String')) returns contents of edit_aperture_g_s as a double
%Inicialize handle value
handles.aperture_g_s=str2double(get_handles(hObject));

set(handles.radiobutton11, 'Value', 1);
%Update handles
guidata(hObject, handles);
end

function edit_aperture_g_s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aperture_g_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Set default value
set(hObject,'String','1080');

%Update handles
guidata(hObject, handles);

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
end



function edit_padding_Callback(hObject, eventdata, handles)

%Update value
handles.padding=str2double(get(hObject,'String'));

%Update handles
guidata(hObject, handles);
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


% --- Executes on button press in pushbutton_set_up_zernike.
function pushbutton_set_up_zernike_Callback(hObject, eventdata, handles)
%Function will alow user to choose size of the image, later taken into
%Zernike correction algorithm. Function will look for a vortex, which size
%is comparable to source image

[row,col] = get_positon_2(handles.vid);

handles.half_side=round(abs(col(2)-col(1)));

handles.center=[row(1), col(1)];

source_zernike = im_crop(getsnapshot(handles.vid),handles.center,handles.half_side);

%Look for comparable vortex
handles.simulated=simulate(source_zernike,handles.topological_charge);

%Show results
figure()
imshowpair(handles.simulated,source_zernike,'montage')

%Update handles
guidata(hObject, handles);
end

function v=zernike_coefficient(coefficient,step, z, vid, simulated, phase_map, aperture, slm1)
% Function will collect correlation parameters for zernike polynomial
% multiplied by coefficient value
v =[];

for c=-coefficient:step:coefficient
    z2=z*c; %Multiplication
    
    %Join with current phase_map
    to_display=cover_with_aperture2(mod(phase_map+z2,2*pi),aperture);
    
    slm1.SetF(to_display,255);
    pause(0.1);
    %Get current camera image
    experimental_intensity = get_snap(vid);
    
    %Compare both imges
    if size(simulated) == size(experimental_intensity)
    comparison_parameter = corr2(simulated, experimental_intensity);
    else
        
    end
    v=[v comparison_parameter];
    
    clear z2 experimental_intensity comparison_parameter
end

end


function do_zernike_Callback(hObject, eventdata, handles)
try
% Function will perform Zernike correction algorithm
slm1=sdMatlabTools1.Slm; %SLM library initialization

% Scaling parameters
coefficient=str2num(get(handles.edit_coefficient,'String'));
step=str2num(get(handles.edit_coefficient_step,'String'));

delay=0.2;
correlations=[]; 

%Default correction hierarchy
zernike_vector=[2 2 4 4; 2 -2 2 -2];

% Preparation of coordinate system
x = linspace(-1,1,handles.h); 
[X,Y] = meshgrid(x,x); %Square of handles.h size
clear x
[theta,r] = cart2pol(X,Y);
idx = r<=1;
z1 = nan(size(X));


start(handles.vid)
stop(handles.vid) 

 

%Set up range of image to snap
handles.vid.ROIPosition=[handles.center(2)-handles.half_side handles.center(1)-handles.half_side size(handles.simulated)];

triggerconfig(handles.vid, 'manual');
start(handles.vid) %start is crucial in order to save triggerconfig parameters
% Now that the device is configured for manual triggering
% This will cause the device to send data back to MATLAB, but will not log
% frames to memory at this point.

%% Start of an algorithm


%Coefficient vector
c=-coefficient:step:coefficient;

%General loop for checking influence of each aberration

for i=1:length(zernike_vector);
    %Generation of Zernike polynomial 2d
    display(['Looking for main aberration ' num2str(i)]);
    z1(idx) = zernfun(zernike_vector(1,i),zernike_vector(2,i),r(idx),theta(idx));
    z = padarray(z1,[0 (handles.w-handles.h)/2], 0, 'both'); %padd with zeros to SLM size
    z(isnan(z))=0;
    
    v=zernike_coefficient(coefficient,step, z, handles.vid, handles.simulated, handles.phase_map, handles.aperture, slm1);
    [~, j] = max(v); % m - value, j - index
    coefficients(i)=c(j);
 
end

%Check maximum absolute value and rearrange order
[~,k] = max(abs(coefficients));

zernike_vector_new=zernike_vector(:,k:length(zernike_vector));
zernike_vector_new=[zernike_vector_new zernike_vector(:,1:k-1)];

display('Main aberration determined');

zernike_vector=zernike_vector_new;
clear zernike_vector_new largest

%Start with main aberration
display('Making final correction');

    z1(idx) = zernfun(zernike_vector(1,1),zernike_vector(2,1),r(idx),theta(idx));
    z = padarray(z1,[0 (handles.w-handles.h)/2], 0, 'both'); %padd with zeros to SLM size
    z(isnan(z))=0;
    z2=z*coefficients(k);
    handles.phase_map=cover_with_aperture2(mod(handles.phase_map+z2,2*pi),handles.aperture);
    imwrite(mat2gray(z2), 'Zernike_1.bmp');
    correction=z2;
    %Make final correction
    
display('1 Zernike polynomial correction done');

for i=2:length(zernike_vector);
    %Generation of Zernike polynomial 2d
    z1(idx) = zernfun(zernike_vector(1,i),zernike_vector(2,i),r(idx),theta(idx));
    z = padarray(z1,[0 (handles.w-handles.h)/2], 0, 'both'); %padd with zeros to SLM size
    z(isnan(z))=0;
    
    v=zernike_coefficient(coefficient,step, z, handles.vid, handles.simulated, handles.phase_map, handles.aperture, slm1);
    [~, j] = max(v); % m - value, j - index

    z2=z*c(j);
    correction=correction+z2;
    handles.phase_map=cover_with_aperture2(mod(handles.phase_map+z2,2*pi),handles.aperture);
    imwrite(mat2gray(z2), ['Zernike_' num2str(i) '.bmp']);
    display([ num2str(i) ' Zernike polynomial correction done']);
end

%% Show final correction
slm1.SetF(handles.phase_map,255);

handles.correction=mod(correction,2*pi);
axes(handles.axes_correction)
imshow(handles.correction,[])
axis off

stop(handles.vid)
triggerconfig(handles.vid, 'immediate');
handles.vid.ROIPosition=[0 0 handles.w handles.h];
start(handles.vid)

preview(handles.vid); 



%Update handles
guidata(hObject, handles);
display(['Whole correction done']);

catch
delete(handles.vid);
display('Error, please check do_zernike_callback function');
end
end

function axes_panel_CreateFcn(hObject, eventdata, handles)

end

function radiobutton9_CreateFcn(hObject, eventdata, handles)

end

function radiobutton9_Callback(hObject, eventdata, handles)

end

% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)

end


function aperture_g_s_panel_CreateFcn(hObject, eventdata, handles)

end


function aperture_g_s_panel_SelectionChangeFcn(hObject, eventdata, handles)
%Function will update aperture value, based on selected size

switch get(eventdata.NewValue,  'String' )
    case 'Original'
    %Radiobutton Original
    set(handles.edit_aperture_g_s,'String',num2str(handles.aperture)); 
    handles.aperture_g_s=handles.h;

    case 'Half'
    %Radiobutton Half
    set(handles.edit_aperture_g_s,'String',num2str(handles.aperture/2)); 
    handles.aperture_g_s=handles.h/2;
    
    case 'Quarter'
    %Radiobutton Quarter
    set(handles.edit_aperture_g_s,'String',num2str(handles.aperture/4)); 
    handles.aperture_g_s=handles.h/4;
    
    case 'Other'    
end

%Update handles
guidata(hObject, handles);
end


% --- Executes when selected object is changed in axes_panel.
function axes_panel_SelectionChangeFcn(hObject, eventdata, handles)

end


function checkbox_zernike_polynomial_Callback(hObject, eventdata, handles)

%Update value
handles.value_zernike_polynomial = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


function checkbox_zernike_polynomial_CreateFcn(hObject, eventdata, handles)

%Inicialize value
handles.value_zernike_polynomial = 0;

%Update handles
guidata(hObject, handles);
end


% --- Executes on button press in pushbutton_holotrap.
function pushbutton_holotrap_Callback(hObject, eventdata, handles)
%Function will calculate size of matrix, required by g-s alogirthm, based
%on optical vortex image shift due to diffraction grating display and on
%aperture size, but each image will be LOADED FROM FILE

%Calculate grating vector difference [1/px]
handles.grating_vector_diff=abs(str2double(get(handles.text_grating_vector_2nd,'string')) - str2double(get(handles.text_grating_vector_1st,'string')));

%Calculate position difference
switch(get(get(handles.axes_panel,'SelectedObject'), 'String'))
 
    case 'x' %Selected x button
                
                %Display 1st diffraction grating
                mapa=diff_grating(handles.w,handles.h,handles.n_1st,0);
                mapa=cover_with_aperture(mapa,handles.aperture);
                
                %Open dialog box
                [filename, pathname] = uigetfile({'*.bmp';'*.png';'*.jpg';},'File Selector');
    
                %Case hologram is a grayscale image
                image=mat2gray(imread([pathname filename]));
    
                %Case hologram is a RGB image
                if (length(size(image))==3)
                image=im2double(rgb2gray(imread([pathname filename])));
                end
                
                %Get position
                map=mod(handles.phase_map+mapa,2*pi);
                
                slm2(map)
                pause(3)
                
                figure()
                imshow(image)
                [col,row] = ginput(1)
                close()
                position_1=col;
                
                %Display 2ndt diffraction grating
                mapa=diff_grating(handles.w,handles.h,handles.n_2nd,0);
                mapa=cover_with_aperture(mapa,handles.aperture);
                
                %Open dialog box
                [filename, pathname] = uigetfile({'*.bmp';'*.png';'*.jpg';},'File Selector');
    
                %Case hologram is a grayscale image
                image=mat2gray(imread([pathname filename]));
    
                %Case hologram is a RGB image
                if (length(size(image))==3)
                image=im2double(rgb2gray(imread([pathname filename])));
                end
                
                %Get position
                map=mod(handles.phase_map+mapa,2*pi);
                
                slm2(map)
                pause(3)
                
                figure()
                imshow(image)
                [col,row] = ginput(1)
                close()
                position_2=col;
                
                %Calculate position difference
                handles.position_diff=abs(position_2-position_1);
                        
        case 'y' %Selected y button
            
                %Display 1st diffraction grating
                mapa=diff_grating(handles.w,handles.h,handles.n_1st,0);
                mapa=cover_with_aperture(mapa,handles.aperture);
                
                %Open dialog box
                [filename, pathname] = uigetfile({'*.bmp';'*.png';'*.jpg';},'File Selector');
    
                %Case hologram is a grayscale image
                image=mat2gray(imread([pathname filename]));
    
                %Case hologram is a RGB image
                if (length(size(image))==3)
                image=im2double(rgb2gray(imread([pathname filename])));
                end
                
                %Get position
                map=mod(handles.phase_map+mapa,2*pi);
                
                slm2(map)
                pause(3)
                
                figure()
                imshow(image)
                [col,row] = ginput(1)
                close()
                position_1=row;
                
                %Display 2ndt diffraction grating
                mapa=diff_grating(handles.w,handles.h,handles.n_2nd,0);
                mapa=cover_with_aperture(mapa,handles.aperture);
                
                %Open dialog box
                [filename, pathname] = uigetfile({'*.bmp';'*.png';'*.jpg';},'File Selector');
    
                %Case hologram is a grayscale image
                image=mat2gray(imread([pathname filename]));
    
                %Case hologram is a RGB image
                if (length(size(image))==3)
                image=im2double(rgb2gray(imread([pathname filename])));
                end
                
                %Get position
                map=mod(handles.phase_map+mapa,2*pi);
                
                slm2(map)
                pause(3)
                
                figure()
                imshow(image)
                [col,row] = ginput(1)
                close()
                position_2=row;
                
                %Calculate position difference
                handles.position_diff=abs(position_2-position_1);

         end


%Calculate padding value
handles.aperture_g_s=str2double(get(handles.edit_aperture_g_s,'String'));
handles.padding=calculate_padding(handles.aperture_g_s, handles.grating_vector_diff, handles.position_diff, handles.aperture);

%Round to nearest even integer
handles.padding=round((handles.padding-2)/2)*2+2;

%Set padding value
set(handles.edit_padding,'string',num2str(handles.padding));

%Update handles
guidata(hObject, handles);
end


% --- Executes on button press in pushbutton_g_s_trap.
function pushbutton_g_s_trap_Callback(hObject, eventdata, handles)
%Function performes G-S algorithm for loaded source image

%% Parameters 
Iterations=20;


%% Final map size [px]

%Size to crop
w2=handles.w;
h2=handles.h;


%% Diameter of the amplitude aperture
aperture_diameter=str2double(get(handles.edit_aperture_g_s,'String'));

%% M_array size used for calculations
padsize=handles.padding;
w=padsize;
h=padsize;

%% Perfect vortex
x=-w/2:1:(w/2-1);y=-h/2:1:(h/2-1);
[X,Y]=meshgrid(x, y);
l=handles.topological_charge;
phi=angle(X+1i*Y);%%Azimuthal angle
vortex=mod(l*phi,2*pi); %Phase


%% Experimental source image of focused vortex
%Case hologram is a grayscale image
%source=sqrt(mat2gray(imread('D:\OneDrive - Politechnika Wroclawska\Laboratorium\2018_11_19_Perfect_Optical_Vortex_2\snap_cropped.bmp')));
%[row,col] = get_positon_2(handles.vid);

                %Open dialog box
                [filename, pathname] = uigetfile({'*.bmp';'*.png';'*.jpg';},'File Selector');
    
                %Case hologram is a grayscale image
                image=mat2gray(imread([pathname filename]));
    
                %Case hologram is a RGB image
                if (length(size(image))==3)
                image=im2double(rgb2gray(imread([pathname filename])));
                end
                
                figure()
                imshow(image)
                [col,row] = ginput(2)
                close()

handles.half_side=round(abs(col(2)-col(1)));

handles.center=[row(1), col(1)];

%source= im_crop(handles.vid,handles.center,handles.half_side);
source=im_crop(image,handles.center,handles.half_side);
%{
    Case hologram is a RGB image
    if (length(size(source))==3)
        source=sqrt(im2double(rgb2gray(imread('D:\OneDrive - Politechnika Wroclawska\Laboratorium\2018_11_19_Perfect_Optical_Vortex_2\snap_cropped.bmp'))));
    end
%}
[sizey sizex]=size(source);


%% Zero padding of experimental source image
source=padarray(source,round([(handles.padding-sizey)/2 (handles.padding-sizex)/2]));

amp=apertura(ones(handles.padding,handles.padding),aperture_diameter,handles.padding,handles.padding);


%% G_S algorithm
%Prepare ideal vortex
    H=vortex;
    E=amp.*exp(1i.*H); %Exchanging phase
    E_FT=fftshift(fft2(E));
    I=abs(E_FT).^2;



clear phi l X Y x y

%G-S algorithm
for i=1:1:Iterations
i
    E=amp.*exp(1i.*H); %Exchanging phase
    E_FT=fftshift(fft2(E));

    H=angle(E_FT)+pi; %Fourier domain
    
    E2=source.*exp(1i.*H); %Exchanging amplitude
    E2=ifft2(ifftshift(E2));
    
    H=angle(E2)+pi; %SLM domain

end

%I=abs(E_FT).^2;
clear E E2 amp E_FT
 

%% Preparing correction map
C=mod(H-vortex,2*pi);
C=apertura(C,aperture_diameter,padsize,padsize);

clear H

%C=imresize(C,4,'nearest');
%{
C=imresize(C,convergent(handles.aperture/aperture_diameter),'nearest');
[p3, p4] = size(C);
q2 = w-1; 
q1 = h-1;
i3_start = floor((p3-q1)/2); % or round instead of floor; using neither gives warning
i3_stop = i3_start + q1;

i4_start = floor((p4-q2)/2);
i4_stop = i4_start + q2;

C = C(i3_start:i3_stop, i4_start:i4_stop);
%}

%C=apertura(C,handles.aperture,w,h);
%C=imcrop(C,[(padsize/2-w2/2) (padsize/2-h2/2) w2-1 h2-1]);

%% Display map
handles.correction=C;
axes(handles.axes_correction)
imshow(handles.correction,[])
axis off
C2=padarray(C,[0 355]);
C3=imcrop(C2,[0 65 1920 1079]);
clear source
imwrite(mat2gray(C3),['holo_trap_ ' num2str(Iterations) '.bmp'])
%Update handles
guidata(hObject, handles);
end


function edit_g_s_iterations_Callback(hObject, eventdata, handles)

end

% --- Executes during object creation, after setting all properties.
function edit_g_s_iterations_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function [ F ] = fresnel(k,w,f,l,pixel_size)
%Function returns hologram of fresnel lens

%[k w] - size of hologram
% f - focus [m]
% l - wavelength
% pixel_size - pixel size in [m]
step=pixel_size; 

%Coordination system
x_obr=0; %center of coordination system, missalignment of 19*10^(-6) means one pixel left
y_obr=0;
obrx=k*step;
obry=w*step;
bokx=x_obr-obrx/2;
boky=y_obr-obry/2;

for m=1:k
   for n=1:w
      x=bokx+m*step;
      y=boky+n*step;
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
    grating_vector_y=2*pi/(h/ny);
    
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
    centerY=round(h/2);
    centerX=round(w/2);
    
    %Circular aperture
    [columnsInImage rowsInImage] = meshgrid(1:w, 1:h);
    circlePixels = (rowsInImage - centerY).^2 + (columnsInImage - centerX).^2<= (aperture/2).^2;
    mapa=ones(h,w);
    map_aperture=circlePixels.*mapa;
    
    %Aperture addition
    I=map_aperture.*I;
    
end

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

function [m_array] = calculate_padding( aperture, grating_vector_diff, position_diff, m_holo)
%aperture - size of the aperture used in algorithm [px]
%grating_vector_diff - abs difference of two grating vectors [1/px]
%position_diff - distance between two position of the beam [px]
%m_holo - diameter of the hologram on slm [px]

grating_vector_diff=abs(grating_vector_diff);

%Calculate size of matrix to padd to
m_array=aperture*2*pi*position_diff/(m_holo*grating_vector_diff);
end


%% Zernike polynomial
function zernike_map = do_zernike(w,h,n,m,coefficient)
%Functon will calculate proper zernike polynomial Z_n_m and multiply it by
%specified coeffcient

if coefficient~=0 %In case of 0 value, return empty map
%% preparation of coordinate system
x = linspace(-1,1,h);
[X,Y] = meshgrid(x,x);
[theta,r] = cart2pol(X,Y);
idx = r<=1;
z = nan(size(X));

%% calculate polynomial
z(idx) = zernfun(m,n,r(idx),theta(idx));
%z = mod(z,2*pi);
z = padarray(z,[0 (w-h)/2], 0, 'both');
z(isnan(z))=0;
%zernike_map=mod(z*coefficient,2*pi);
zernike_map=z*coefficient;
else
    zernike_map=zeros(h,w);
end
end

%% Zernike correction
function [row,col] = get_positon_2(vid);
%Get two positions, first: center of the beam, second: half side length
%vid - video object

                %Get snapshot
                img=getsnapshot(vid);
                if length(size(img))~= 2
                img= im2double(rgb2gray(img));
                end
                
                %Get position
                figure()
                imshow(img)
                zoom on;
                pause() % you can zoom with your mouse and when your image is okay, you press any key
                zoom off; % to escape the zoom mode
                [col,row] = ginput(2);
                zoom out; % go to the original size of your image
                close()
                

end

function [img] = im_crop(img,center,half_side);
%Crop the image to desired size, with respect to its center
%vid - video object
%center - [x,y] center of the beam
%half_side - length of half side square that image will be cropped to

                %Get snapshot
                %img=getdata(vid,3,'uint8');
                %img=getsnapshot(vid);
                if length(size(img))~= 2
                img= im2double(rgb2gray(img));
                end
                
                %Prepare size
                
                x=center(2)-half_side;
                y=center(1)-half_side;

                side=2*half_side;
                
                %Crop image
                img=imcrop(img,[x y side+1 side+1]);
                %}
                % Zadbac o parzystosc

end

function [img] = get_snap(vid);
%Crop the image to desired size, with respect to its center
%vid - video object


                %Get snapshot
                
                img=getsnapshot(vid);
               
                if length(size(img))~= 2
                img= im2double(rgb2gray(img));
                end
                
end

function [I] = simulate(source,topological_charge)
%Simulate in order to obtain comparable beam size 

%Check size of image
side=length(source);

%Generate vortex phase
vortex_phase=vortex(side, side, topological_charge);

%Prepare variable
correlation_vector=[0];
amp_vector=[0];

for aperture_diameter=0.005*side:0.005*side:0.2*side
    %Create amplitude
    amp=apertura(ones(side,side),aperture_diameter,side,side);

    %Calculate FFT
    E=amp.*exp(1i.*vortex_phase);
    E_FT=fftshift(fft2(E));
    I=abs(E_FT).^2;
    
    %Check correlation
    correlation=corr2(I,source);
    
    %Store results
    correlation_vector=[correlation_vector correlation];
    amp_vector=[amp_vector aperture_diameter];
    
    %figure()
    %imshowpair(I,source,'montage')
end

%Find index of maximum correlation
maximum_correlation = max(correlation_vector);
[~,i]=find(correlation_vector==maximum_correlation);

%Create amplitude
amp=apertura(ones(side,side),amp_vector(i),side,side);

%Calculate FFT
E=amp.*exp(1i.*vortex_phase);
E_FT=fftshift(fft2(E));
I=abs(E_FT).^2;    
end


% --- Executes on slider movement.
function slider_phase_shift_Callback(hObject, eventdata, handles)
%Round slider value
value = round(get(hObject, 'Value'));
set(hObject, 'Value', value);

%Update topological charge
handles.phase_shift=get(hObject,'Value');
set(handles.text_phase_shift_dg,'String',[num2str(handles.phase_shift) ' deg']);
phase_rad=handles.phase_shift*2/360;
set(handles.text_phase_shift_rad,'String',[sprintf('%.3f',phase_rad) 'pi']);

%Update handles
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function slider_phase_shift_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_phase_shift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject, 'Max', 360, 'Min', 0, 'Value', 0, 'SliderStep', [1/360 1/360]);
handles.phase_shift=0;

%Update handles
guidata(hObject, handles);
end

% --- Executes on button press in checkbox_phase_shift.
function checkbox_phase_shift_Callback(hObject, eventdata, handles)
%Update value
handles.value_phase_shift = get(hObject, 'Value');

%Update handles
guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function checkbox_phase_shift_CreateFcn(hObject, eventdata, handles)
%Inicialize value
handles.value_phase_shift = 0;

%Update handles
guidata(hObject, handles);
end



function edit_coefficient_Callback(hObject, eventdata, handles)
% hObject    handle to edit_coefficient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_coefficient as text
%        str2double(get(hObject,'String')) returns contents of edit_coefficient as a double
end

% --- Executes during object creation, after setting all properties.
function edit_coefficient_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_coefficient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function edit_coefficient_step_Callback(hObject, eventdata, handles)
% hObject    handle to edit_coefficient_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_coefficient_step as text
%        str2double(get(hObject,'String')) returns contents of edit_coefficient_step as a double
end

% --- Executes during object creation, after setting all properties.
function edit_coefficient_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_coefficient_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
