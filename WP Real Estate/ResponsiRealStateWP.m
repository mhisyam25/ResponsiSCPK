function varargout = ResponsiRealStateWP(varargin)
% RESPONSIREALSTATEWP MATLAB code for ResponsiRealStateWP.fig
%      RESPONSIREALSTATEWP, by itself, creates a new RESPONSIREALSTATEWP or raises the existing
%      singleton*.
%
%      H = RESPONSIREALSTATEWP returns the handle to a new RESPONSIREALSTATEWP or the handle to
%      the existing singleton*.
%
%      RESPONSIREALSTATEWP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSIREALSTATEWP.M with the given input arguments.
%
%      RESPONSIREALSTATEWP('Property','Value',...) creates a new RESPONSIREALSTATEWP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ResponsiRealStateWP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ResponsiRealStateWP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ResponsiRealStateWP

% Last Modified by GUIDE v2.5 25-Jun-2021 21:29:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ResponsiRealStateWP_OpeningFcn, ...
                   'gui_OutputFcn',  @ResponsiRealStateWP_OutputFcn, ...
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


% --- Executes just before ResponsiRealStateWP is made visible.
function ResponsiRealStateWP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ResponsiRealStateWP (see VARARGIN)

% Choose default command line output for ResponsiRealStateWP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ResponsiRealStateWP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ResponsiRealStateWP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = {'X2','X3','X4','Y'};
data1 = readmatrix('Real estate valuation data set.xlsx', opts); %membaca file .xlsx
data2 = data1(1:50,:); %menampilkan jumlah baris dan kolom dengan spesific
set(handles.uitable1,'data',data2); %menampilkannya didalam tabel

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uitable1, 'Data', {})
set(handles.uitable2, 'Data', {})
set(handles.text2, 'string', ' ')


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data3 = get(handles.uitable1,'data'); %mengambil seluruh data dari uitable1
k = [1 1 1 1]; %nilai atribut, yang dimana 1 berarti benefit
w = [3 5 4 1]; %bobot per kriteria secara urut

[m, n] = size(data3); %inisilisasi ukuran m
w = w./sum(w); %membagi bobot per kriteria dengan jumlah total

%tahapan 2. perhitungan vektor
for j=1:n
    if k(j)==0
        w(j)=-1*w(j);
    end
end

for i=1:m
    S(i)=prod(data3(i,:).^w);
end
set(handles.uitable2,'data',S);

%mencari nilai maximum dari data yg sudah dihitung
[~,hasil] = max(S);
hasil2 = num2str(hasil);
set(handles.text2,'string',hasil2);
