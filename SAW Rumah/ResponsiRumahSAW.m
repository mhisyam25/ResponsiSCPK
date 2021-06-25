function varargout = ResponsiRumahSAW(varargin)
% RESPONSIRUMAHSAW MATLAB code for ResponsiRumahSAW.fig
%      RESPONSIRUMAHSAW, by itself, creates a new RESPONSIRUMAHSAW or raises the existing
%      singleton*.
%
%      H = RESPONSIRUMAHSAW returns the handle to a new RESPONSIRUMAHSAW or the handle to
%      the existing singleton*.
%
%      RESPONSIRUMAHSAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSIRUMAHSAW.M with the given input arguments.
%
%      RESPONSIRUMAHSAW('Property','Value',...) creates a new RESPONSIRUMAHSAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ResponsiRumahSAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ResponsiRumahSAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ResponsiRumahSAW

% Last Modified by GUIDE v2.5 25-Jun-2021 21:11:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ResponsiRumahSAW_OpeningFcn, ...
                   'gui_OutputFcn',  @ResponsiRumahSAW_OutputFcn, ...
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


% --- Executes just before ResponsiRumahSAW is made visible.
function ResponsiRumahSAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ResponsiRumahSAW (see VARARGIN)

% Choose default command line output for ResponsiRumahSAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ResponsiRumahSAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ResponsiRumahSAW_OutputFcn(hObject, eventdata, handles) 
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
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = {'NO','HARGA','LB','LT','KT','KM','GRS'};
data1 = readmatrix('DATA RUMAH.xlsx', opts); %membaca file .xlsx
data2 = data1(1:20,:); %menampilkan jumlah baris dan kolom dengan spesific
set(handles.uitable1,'data',data2); %menampilkannya didalam tabel

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uitable1, 'Data', {})
set(handles.uitable2, 'Data', {})


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%opts = detectImportOptions('DATA RUMAH.xlsx');
%opts.SelectedVariableNames = (3:8); 
%data3 = readmatrix('DATA RUMAH.xlsx',opts);
%data4 = data3(1:20,:); %menampilkan jumlah baris dan kolom dengan spesific
data4 = get(handles.uitable1, 'data'); %mengambil data yg ada didalam tabel
data5 =[0 0.3 0.2 0.23 0.1 0.07 0.1]; %bobot untuk masing-masing kriteria

%tahapan 1. normalisasi matriks
[m, n]=size (data4); %matriks m x n dengan ukuran sebanyak variabel x(input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
for j=1:n
    if isequal(data4,1) %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=data4(:,j)./max(data4(:,j));
    else
        R(:,j)=min(data4(:,j))./data4(:,j);
    end
end

%tahapan 2. perangkingan
for i=1:m
    V(i)= sum(data5.*R(i,:)); %menjumlahkan dari perkalian antara bobot kriteria dengan data kriteria
end

%tahapan 3. transpose
%karena data yg dihasilkan V berupa kolom maka harus ditranspose agar
%menjadi baris

Vt = V.';
Vt = num2cell(Vt);

opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (2);
data6 = readtable('DATA RUMAH.xlsx',opts);
data7 = data6(1:20,:);
data7 = table2cell(data7);
data7 = [data7 Vt];
data7 = sortrows(data7,-2);
data7 = data7(1:20,1);

set(handles.uitable2, 'data', data7);
