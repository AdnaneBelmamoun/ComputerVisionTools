function varargout = Interface_graphique_ATEO(varargin)
% INTERFACE_GRAPHIQUE_ATEO M-file for Interface_graphique_ATEO.fig
%      INTERFACE_GRAPHIQUE_ATEO, by itself, creates a new INTERFACE_GRAPHIQUE_ATEO or raises the existing
%      singleton*.
%
%      H = INTERFACE_GRAPHIQUE_ATEO returns the handle to a new INTERFACE_GRAPHIQUE_ATEO or the handle to
%      the existing singleton*.
%
%      INTERFACE_GRAPHIQUE_ATEO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE_GRAPHIQUE_ATEO.M with the given input arguments.
%
%      INTERFACE_GRAPHIQUE_ATEO('Property','Value',...) creates a new INTERFACE_GRAPHIQUE_ATEO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interface_graphique_ATEO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interface_graphique_ATEO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interface_graphique_ATEO

% Last Modified by GUIDE v2.5 11-Jul-2012 01:58:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interface_graphique_ATEO_OpeningFcn, ...
                   'gui_OutputFcn',  @Interface_graphique_ATEO_OutputFcn, ...
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


% --- Executes just before Interface_graphique_ATEO is made visible.
function Interface_graphique_ATEO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interface_graphique_ATEO (see VARARGIN)

% Choose default command line output for Interface_graphique_ATEO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interface_graphique_ATEO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interface_graphique_ATEO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
fullpath = fileread('cheminImage.txt');
handles.im_originale = imread(fullpath);
% Traitement anti-probléme des bordures:
handles.im = traitement_bordures(handles.im_originale);
[handles.m,handles.n,handles.nb_gs]= size(handles.im);
%handles.valeur_nppca = str2double(get(handles.valeur_nppca,'String'));
handles.nb_Q = str2double(get(handles.nb_Q_edit,'String'));

etat_chekbox_bruit = get(handles.checkbox_bruit,'Value');

%% ajout du bruit
if(etat_chekbox_bruit)
 handles.variance_bruit=str2double(get(handles.variance_edit,'String'));%double(0.25);
 handles.im(:,:,:) = double(handles.im(:,:,:))+ double(handles.variance_bruit*randn(size(handles.im(:,:,:))));

 %% pré-traitement DU BRUIT  dans images monochromatique bruitées
    nb_classe=handles.nb_Q;
        for s=1:handles.nb_gs
        pas = double(max(max(handles.im(:,:,s)))-min(min(handles.im(:,:,s))))/nb_classe;
          for i =1:handles.m
              for j = 1:handles.n
                 if(handles.im(i,j,s)<pas)
                     handles.im(i,j,s)=1;
                 end
                 for k = 2:nb_classe-1
                   if(handles.im(i,j,s)<k*pas && handles.im(i,j,s)>=(k-1)*pas )
                     handles.im(i,j,s)=2*k;
                   end
                 end
                 if(handles.im(i,j,s)>(nb_classe-1)*pas)
                    handles.im(i,j,s)=nb_classe; 
                 end
              end
          end
        end

end

etat_chekbox_FB = get(handles.checkbox_FB,'Value');

%% ajout du bruit
if(etat_chekbox_FB)
%% Configuration des paramétres du filtre bilaterale.
 handles.wwww = 1;%str2double(get(handles.W_FB_edit,'String'));       % Taille de la fenêtre ou du voisinage
 handles.sigma_c=str2double(get(handles.sigma_c_fb_edit,'String'));%double(0.0000001);
 handles.sigma_s=str2double(get(handles.sigma_s_fb_edit,'String'));%double(0.000000001);
 handles.sigma =[0.0000001 0.000000001];
 %[double(handles.sigma_c) double(handles.sigma_s)]; % Déviation standard du filtre sigma_c=3 et sigma_s=0.1
    % Application du filtrage bilatérale pour chaque image.
    for gs=1:handles.nb_gs
    handles.im(:,:,gs)=double(double(handles.im(:,:,gs)))/255;%double(max(max(im(:,:,gs))));
    handles.im(:,:,gs) = filtrageBilaterale(handles.im(:,:,gs),handles.wwww,handles.sigma);
    handles.im(:,:,gs)=double(double(handles.im(:,:,gs)))*255;
    end
end
%% Maintenant j'applique la détection avec ATEO et CANNY
for gs=1:handles.nb_gs
handles.contour_ATEO(:,:,gs) = ADA_TRE_ENT_OPERATOR(handles.im(:,:,gs),5,handles.nb_Q);
end
handles.contour_ATEO_inv = inversion_couleur(handles.contour_ATEO);
[handles.contour_canny,handles.canny_tresh] = canny_color(handles.im);


handles.canny_tresh(:)

%% Affichage des resultats.
handles.figure1;
figure;imshow(mat2gray(handles.im_originale));title('Image originale ');
handles.figure1;
figure;imshow(mat2gray(handles.contour_canny));title('Contour Avec Operateur Canny');
handles.figure1;
figure;imshow(mat2gray(handles.contour_ATEO));title('Contour Avec Operateur ATEO');



% --------------------------------------------------------------------
function ouvrir_image_Callback(hObject, eventdata, handles)
% hObject    handle to ouvrir_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%printdlg(handles.figure1)
[FileName,PathName,FilterIndex] = uigetfile('*.png;*.jpg;*.tiff;*.gif');
if ~isequal(FileName, 0)
    fullpath = strcat(PathName,FileName);
    fullpath = regexprep(fullpath, '\', '/');
     %handles.figure1;
    % figure;imshow(mat2gray(imread(fullpath)));
     handles.savefile = fopen('cheminImage.txt','wt');
     fprintf(handles.savefile,fullpath);
     fclose(handles.savefile);
end



function variance_edit_Callback(hObject, eventdata, handles)
% hObject    handle to variance_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of variance_edit as text
%        str2double(get(hObject,'String')) returns contents of variance_edit as a double


% --- Executes during object creation, after setting all properties.
function variance_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to variance_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_bruit.
function checkbox_bruit_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_bruit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_bruit


% --- Executes on button press in checkbox_canny_auto.
function checkbox_canny_auto_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_canny_auto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_canny_auto



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_FB.
function checkbox_FB_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_FB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_FB



function W_FB_edit_Callback(hObject, eventdata, handles)
% hObject    handle to W_FB_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of W_FB_edit as text
%        str2double(get(hObject,'String')) returns contents of W_FB_edit as a double


% --- Executes during object creation, after setting all properties.
function W_FB_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to W_FB_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nb_Q_edit_Callback(hObject, eventdata, handles)
% hObject    handle to nb_Q_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nb_Q_edit as text
%        str2double(get(hObject,'String')) returns contents of nb_Q_edit as a double


% --- Executes during object creation, after setting all properties.
function nb_Q_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nb_Q_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function sigma_c_fb_edit_Callback(hObject, eventdata, handles)
% hObject    handle to sigma_c_fb_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigma_c_fb_edit as text
%        str2double(get(hObject,'String')) returns contents of sigma_c_fb_edit as a double


% --- Executes during object creation, after setting all properties.
function sigma_c_fb_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma_c_fb_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sigma_s_fb_edit_Callback(hObject, eventdata, handles)
% hObject    handle to sigma_s_fb_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigma_s_fb_edit as text
%        str2double(get(hObject,'String')) returns contents of sigma_s_fb_edit as a double


% --- Executes during object creation, after setting all properties.
function sigma_s_fb_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma_s_fb_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
