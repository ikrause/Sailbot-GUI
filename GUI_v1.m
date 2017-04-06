function varargout = GUI_v1(varargin)
% GUI_V1 MATLAB code for GUI_v1.fig
%      GUI_V1, by itself, creates a new GUI_V1 or raises the existing
%      singleton*.
%
%      H = GUI_V1 returns the handle to a new GUI_V1 or the handle to
%      the existing singleton*.
%
%      GUI_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_V1.M with the given input arguments.
%
%      GUI_V1('Property','Value',...) creates a new GUI_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_v1

% Last Modified by GUIDE v2.5 18-Mar-2017 10:07:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_v1_OutputFcn, ...
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
    % Research Notes:
    % Linkdata, assignin()
    % Making Graphs REsponsive with Data Linking 
    % https://www.mathworks.com/help/matlab/creating_guis/write-callbacks-using-the-guide-workflow.html
    % How to automatically update plots MATLAB
    % Pulling in Variables from the Workspace
    %Test_Data = evalin('base','x_y_psi');
    %handles.xData= get(Test_Data(:,2));
    %handles.yData= get(Test_Data(:,3));

% Make sure that the serial port is closed
% NOTE: This is a cop-out, and it may cause issues in the future if we have
% other serial ports or other devices open that need to be open.
% a = instrfind;
% for i = 1:numel(a)
%     fclose(a(i));
%     delete(a(i));
% end
% clear a

% For wind plots
% quiver, wind_rose


% --- Executes just before GUI_v1 is made visible.
function GUI_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_v1 (see VARARGIN)
global graph1 graph2 graph3  DataString 
   
% Choose default command line output for GUI_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
graph1 = plot(handles.axes1,0,0,'*r');
graph2 = plot(handles.axes2,0,0,'g');
%set(handles.axes3, 'Parent', wind_rose());
graph3 = plot(handles.axes3,0,0,'b');
%wind_rose(DataString.Wind(end),DataString.Intensity(end), varargin)
%wind_plot = wind_rose(1,1, varargin);
%set(graph3, 'Axes',wind_plot);
% polar?
% Detect if there is anything in the Serial Port
port_open = instrfind;
if isempty(port_open) ==  0
       set(handles.text19,'String','On');
end


drawnow

% --- Outputs from this function are returned to the command line.
function varargout = GUI_v1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
disp('You pressed Button 6');
fprintf('Direct Station Keeping to Microprocessor\n');
global graph1 xdata 
xdata = get(graph1,'xdata');
ydata = get(graph1,'ydata');
set(graph1,'xdata',[xdata, xdata(end)+1],'ydata',[ydata, 2*xdata(end)]);
%set(line1,'xdata',[lat],'ydata',[lon]);
drawnow

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
disp('You pressed Button 7');
fprintf('Direct Fleet Race to Microprocessor\n');
global graph2
xdata = get(graph2,'xdata');
ydata = get(graph2,'ydata');
set(graph2,'xdata',[xdata, xdata(end)+1],'ydata',[ydata, sin(xdata(end))]);
drawnow
% Extra Info/Playing Around with Button 7
%fprintf('My name is "%s"\n',hObject.String); 
%hObject
%eventdata.Source

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
disp('You pressed Button 8');
fprintf('Direct Challenges to Microprocessor\n');
global graph3 lon time_stamp
%linkdata ON
%load('Plotting_Attempt1.mat', 'lon');
xdata = get(graph3,'xdata');
ydata = get(graph3,'ydata');
set(graph3,'xdata',[xdata, xdata(end)+1],'ydata',[ydata, (xdata(end)^17)]);

drawnow


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
disp('You pressed Button 9');
fprintf('Direct Endurance Challenge to Microprocessor\n');
figure;
plot(0,0);
title('Endurance Challenge');


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
global DataString graph3
disp('You pressed Button 10');
fprintf('Direct Navegation to Microprocessor\n');

% Change the Text to value
set(handles.text6,'String','Testingggggg');

% % Wind Rose Plot Testing
% d=0:10:350;
%      D=[];
%      V=[];
%      for i=1:length(d)
%        n=d(i)/10;
%        D=[D ones(1,n)*d(i)];
%        V=[V 1:n];
%      end
% 
% x = 0;
% y = 0;
% ax = graph3;
% wind_plot = wind_rose(D,V,'ax',{ax x y 1/3});
% wind_axes = get(wind_plot, 'Children'); % Get axes of wind plot
% wind_data = get(wind_axes, 'Children'); % Get data on axes of Wind Plot
% 
% set(graph3, 'XData',[wind_data.XData], 'YData', [wind_data.YData]);


drawnow


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
disp('You pressed Button 11: Update Guide');

global DataString graph1 graph2 graph3 ser status 
%plot(handles.axes2,0,0,'LineWidth',2);
%set(get(handles.axes2,'Children'),'XDataSource','handles.xData');
%set(get(handles.axes2,'Children'),'YDataSource','handles.yData');
%linkdata on;
if(status == 1)
    % Set the callback function for the serial object
    set(ser,'BytesAvailableFcnMode','Terminator');
    set(ser,'BytesAvailableFcn',@Plot_Update); %@ Whatever Function it's running
 
    % Create Structured Array for the Data... Prepare the MATLAB directories
    % for the Data that will be streaming in
    % Define data fields
    DataString.Time = [];
    DataString.Lat = [];
    DataString.Lon = [];
    DataString.Speed = [];
    DataString.Heel = [];
    DataString.Curr_Heading = [];
    DataString.Des_Heading = [];
    DataString.Wind = [];
    DataString.Intensity = [];
    DataString.Rudder = [];
    DataString.Des_Rudder =  [];
    DataString.Curr_Sail = [];

    
    % Define Text fields
    DataString.lat_string = handles.text20;
    DataString.lon_string = handles.text21;
    DataString.speed_string = handles.text31;
    DataString.heel_string = handles.text32;
    DataString.curr_head_string = handles.text38;
    DataString.des_head_string = handles.text40;
    DataString.wind_string = handles.text24;
    DataString.intensity_string = handles.text25;
    DataString.rudder_string = handles.text29;
    DataString.des_rudder_string = handles.text30;
    DataString.curr_sail_string = handles.text27;
    
    % Connect the graphs of GUI with Structured Array
    DataString.graph1 = graph1; %Right now this is the Lon Plot
    DataString.graph2 = graph2; %Right now this is the Lat Plot
    DataString.graph3 = graph3;
    
%     plot(handles.axes3,0,0,'LineWidth',2);
%     set(get(handles.axes3,'Parent'),wind_rose());
 
    
    % Set the callback function for the serial object
    set(ser,'BytesAvailableFcnMode','Terminator');
    flushinput(ser); 
    set(ser,'BytesAvailableFcn',@Plot_Update); %@ Whatever Function it's running
    % Call outside Function
    Plot_Update(ser)
    drawnow
else 
    set(ser,'BytesAvailableFcn',[]);
    msgbox({'Serial Connection not made.' 'Press Toggle Button "Serial Connection On/Off" to make connection'}, 'Unsucessful');
end




% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
switch hObject.String{ hObject.Value }
    case 'Autonomous'
        disp('I AM IN AUTONOMOUS MODE');
        % Werk werk werk
    case 'RC Control'
        disp('I AM IN RC CONTROL MODE');
        % Detect RC Control; listen
        % Do we want it to clear the figures? 
    otherwise
        fprintf('The STRING: "%f" does not match my fixed cases\n',hObject.String{ hObject.Value });
end
% handles Prints out every handle

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% To edit GUI, type guide in Command Window, and select existing project


% --- Executes on button press in togglebutton3. 
% This is the Serial On/Off Toggle
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3
clc;
global ser status

status = get(hObject,'Value'); % Assign the 0 (off) or 1 (on) to a variable

% For next time: check that status is continually updated, so like make it
% display an updating counter or keep updating a plot if status ==1 because
% my thought process is that it only checks once...
if (status == 1)
    disp('Serial Connection On');
    set(handles.text19,'String','On');
    % Establish Serial Port
    ser = serial('COM10');
    set(ser,'BaudRate',115200);
    set(ser,'DataBits',8);
    set(ser,'Parity','Even');
    set(ser,'StopBits',1);
    set(ser,'Terminator','LF');
    % Open the serial object
    fopen(ser);   
else
    msgbox({'Serial Connection not made.' 'Check port availability' 'Cannot connect/disconnect multiple times without shutting down MATLAB'}, 'Unsuccessful');
    set(handles.text19,'String','Off');
    
    % Close Serial Port
    
    fclose(ser);
    delete(ser);
    clear ser;
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global graph1 graph2 graph3 
clc;
disp('You pressed Button 13: Clear Guide');

cla(handles.axes1); % Clears the plot
cla(handles.axes2);
cla(handles.axes3);

% Re-plot the data so that other push-buttons can access data
graph1 = plot(handles.axes1,0,0,'*r');
graph2 = plot(handles.axes2,0,0,'g');
graph3 = plot(handles.axes3,0,0,'b');
