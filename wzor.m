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