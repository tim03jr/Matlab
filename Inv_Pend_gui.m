function varargout = Inv_Pend_gui(varargin)
% INV_PEND_GUI MATLAB code for Inv_Pend_gui.fig
%      INV_PEND_GUI, by itself, creates a new INV_PEND_GUI or raises the existing
%      singleton*.
%
%      H = INV_PEND_GUI returns the handle to a new INV_PEND_GUI or the handle to
%      the existing singleton*.
%
%      INV_PEND_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INV_PEND_GUI.M with the given input arguments.
%
%      INV_PEND_GUI('Property','Value',...) creates a new INV_PEND_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Inv_Pend_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Inv_Pend_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Inv_Pend_gui

% Last Modified by GUIDE v2.5 02-Aug-2016 23:32:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Inv_Pend_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Inv_Pend_gui_OutputFcn, ...
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


% --- Executes just before Inv_Pend_gui is made visible.
function Inv_Pend_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Inv_Pend_gui (see VARARGIN)

% Choose default command line output for Inv_Pend_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Inv_Pend_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Inv_Pend_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Tim Mitchell
% 8/2/2016
% For the Genmark SCARA in the Biomechatronics lab at SFSU

% Reads data from an accelerometer via an Arduino.
% The Arduino sends 8-bit data through its serial port.
% The Arduion reads its analog inputs with 10-bit resolution (0-1023)
% The serial data from the Arduino is truncated via the map command to make serial data transmission easier.
%     A better solution would be to send the entire 10-bit value broken up into 8-bit characters so that
%     a higher resolution of accelerometer readings can be obtained.

% Plots:
%     Raw reading(0-255) from Arduino vs. time
%     Acceleration vs. time
%     Force vs. time

% Use the data Cursor on the plot to find the data at a given time


%% Close serial port if open
clear
clc
clear ard
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

%% Open Serial port
ard = serial('COM3','BaudRate',115200);
fopen(ard);

%% Plot Properties 
plotTitle_raw = 'Raw Reading vs. Time';        
plotTitle_accel = 'Acceleration vs. Time';
plotTitle_force = 'Force vs. Time';
xLabel = 'Time (Seconds)';                       
yLabel_raw = 'Raw 8-bit Data (0-255)';       
yLabel_accel = 'Acceleration (m/s^2)';         
yLabel_force = 'Force (N)';                     
max_raw = 255;                      % set y-max for raw data plot (0-255)
max_accel = 30;                     % set y-max_1 for acelleration plot (m/s^2)   max is 3g or ~27 m/s^2
max_force = 15;                     % set y_max_2 for force plot (N)   F = ma   if mass = 0.5 kg, Fmax = (0.5 kg)*(30 m/s^2) = 15 N
min_raw = 0;                        % set y-min
min_accel = -30;
min_force = -15;
delay = .001;                       % make sure to sample faster than resolution
mass = 0.5; %%%%%%%%%%%%%%%%%%%%%%%%%THIS IS THE MASS OF THE HARDWARE ON THE ROBOTIC ARM%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define variables
 time = 0;
 PWMchange = 0;
 rawAccel = 0;
 actualAccel = 0;
 force = 0;
 loopIteration = 0.00;
 
%% Set up Plot
%plot setup for raw reading vs. time
subplot(3,1,1);
plotGraph_raw = plot(time,rawAccel,'-mo','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',[.49 1 .63],'MarkerSize',2);
title(plotTitle_raw,'FontSize',25);
ylabel(yLabel_raw,'FontSize',15);
axis([0 10 min_raw max_raw]);
grid('on');

%plot setup for Acceleration vs time
subplot(3,1,2);
plotGraph_accel = plot(PWMchange,actualAccel,'-mo','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',[.49 1 .63],'MarkerSize',2);
title(plotTitle_accel,'FontSize',25);
ylabel(yLabel_accel,'FontSize',15);
axis([0 10 min_accel max_accel]);
grid('on');

%plot setup for Force vs time
subplot(3,1,3)
plotGraph_force = plot(PWMchange,force,'-mo','LineWidth',1,'MarkerEdgeColor','k','MarkerFaceColor',[.49 1 .63],'MarkerSize',2);
title(plotTitle_force,'FontSize',25);
xlabel(xLabel,'FontSize',15);
ylabel(yLabel_force,'FontSize',15);
axis([0 10 min_force max_force]);
grid('on');

%% Plot loop

tic%Take not of current time
 
while 1  %ENTER CTRL-C IN THE COMMAND WINDOW TO STOP CODE EXECUTION

   %FYI A = fread(obj,SIZE,PRECISION)
   rawRead = fread(ard,1,'uint8'); %Read in data from the Arduino
   flushinput(ard);%this gets rid of all of the 511 bytes transmitted from the Arduino
                   %This is to insure that the next time through this loop, fread is reading the most current data. This can be
                   %optimized such that all the data from the Arduino is plotted.

        loopIteration = loopIteration + 1;%Counts the current loop iteration 
        time(loopIteration) = toc;%Saves the current time into the indice of the time array specified by loopIteration
     
        %Plot rawAccel vs. Time
        %FYI: Set(plot handle, property name, property val, etc.)
        rawAccel(loopIteration) = rawRead;%Saves the current data into the indice of the data array specified by count
        subplot(3,1,1);
        set(plotGraph_raw,'XData',time,'YData',rawAccel);
        axis([0 time(loopIteration) min_raw max_raw]);
     
        %Plot ActualAcell vs. Time
        %Converts rawAccel (0-255) to ActualAcell (0-30 m/s^2) NOTE: 3G = 29.43 m/s^2
        actualAccel(loopIteration) = (29.43/125)*rawAccel(loopIteration)-30;%29.43/125 is the slope of the line that linearly interpolates 0-1023 on the abcissa and 0-30 on the ordinate
        subplot(3,1,2);
        set(plotGraph_accel,'XData',time,'YData',actualAccel);
        axis([0 time(loopIteration) min_accel max_accel]);
        
        %Plot Force vs. Time
        %Convert ActualAcell (0-30 m/s^2) to Force (0-15 N) via F = ma
        subplot(3,1,3);
        force = mass*actualAccel;%mass is the mass of everything that is on the end of the robotic arm.
        set(plotGraph_force,'XData',time,'YData',force);
        axis([0 time(loopIteration) min_force max_force]);
        
        %Allow MATLAB to Update Plot
        pause(delay);
end


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function com_Callback(hObject, eventdata, handles)
% hObject    handle to com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of com as text
%        str2double(get(hObject,'String')) returns contents of com as a double


% --- Executes during object creation, after setting all properties.
function com_CreateFcn(hObject, eventdata, handles)
% hObject    handle to com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
