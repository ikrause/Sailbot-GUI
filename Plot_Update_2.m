function Plot_Update(ser,Jannet)

global DataString status

ser
Jannet

DataAvailable = ser.BytesAvailable;
%while(1)
%if (status == 1) % If the Serial Port is conneted (The Toggle button value will be 1)
if (DataAvailable ~= 0) % If Data is being read in from the mbed
    %fprintf('Data Available\n');
    % Read data from the serial object
    data = fscanf(ser,'$%f$%f$%f',[1,3]);
    % Parse values
    time = data(1);
    lat  = data(2);
    lon  = data(3);
    % Append data to global structure variable
    DataString.Time(end+1) = time;
    DataString.Lat(end+1) = lat;
    DataString.Lon(end+1) = lon;
    
    % Assign values as strings
    lat_text_read = num2str(DataString.Lat(end));
    lon_text_read = num2str(DataString.Lon(end));
    
    % Update plot
    % --> Latitude
    set(DataString.graph1,'xdata',DataString.Time,'ydata',DataString.Lat);
    % --> Longitude
    set(DataString.graph2,'xdata',DataString.Time,'ydata',DataString.Lon);
    
    % Update Text
    % --> Latitude
    set(DataString.lat_string,'String',lat_text_read);
    % --> Longitude
    set(DataString.lon_string,'String',lon_text_read);
    
    drawnow
else
    msgbox('Data Not Available. Bad Serial Connection.');
    break % Breaks out of While loop without creating a zillion pop-ups
end
%else
%    msgbox('Serial Port is Off');
%    break
%end
%end
end
