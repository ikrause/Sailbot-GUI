function Plot_Update(ser, Jannet)

global DataString status

%ser
%Jannet

DataAvailable = ser.BytesAvailable;
while(1)
if (status == 1) % If the Serial Port is conneted (The Toggle button value will be 1)
if (DataAvailable ~= 0) % If Data is being read in from the mbed
    fprintf('Data Available\n');
    % Read data from the serial object
    data = fscanf(ser,'$%f$%f$%f$%f$%f$%f$%f$%f$%f$%f$%f$%f',[1,12]);
    % Parse values
    time = data(1);
    lat  = data(2);
    lon  = data(3);
    speed = data(4);    
    heel = data(5);
    curr_head = data(6);
    des_head = data(7);
    wind = data(8);
    intensity = data(9);
    rudder = data(10);
    des_rudder = data(11);
    curr_sail = data(12); %%% GET THIS TO WORK
    
    
    % What didn't work in mbed because mixing strings & floats over serial
    % makes parsing impossible: Assigning the character value to random
    % generation of the sail position.
%     switch curr_sail
%         case 0
%             curr_string_sail = 'Close Haul';
%         case 1
%             curr_string_sail = 'Close Reach';
%         case 2
%             curr_string_sail = 'Beam Reach';
%         case 3
%             curr_string_sail = 'Broad Reach';
%         case 4
%             curr_string_sail = 'Run';
%     end
    
        % Detect RC Control; listen
        % Do we want it to clear the figures? 
    
    % Append data to global structure variable
    DataString.Time(end+1) = time;
    DataString.Lat(end+1) = lat;
    DataString.Lon(end+1) = lon;
    DataString.Speed(end+1) = speed;
    DataString.Heel(end+1) = heel;
    DataString.Curr_Heading(end+1) = curr_head;
    DataString.Des_Heading(end+1) = des_head;
    DataString.Wind(end+1) = wind;
    DataString.Intensity(end+1) = intensity;
    DataString.Rudder(end+1) = rudder;
    DataString.Des_Rudder(end+1) = des_rudder;
    DataString.Curr_Sail(end+1) = curr_sail;
    %fprintf('%s', curr_sail);
    
    % Save Data Stream coming in for future reference
    save_name_1 = 'Sailbot-Data-'; % Part 1 of Name
    save_name_2 = date; % Saving current date as string
    tot_name = strcat(save_name_1,save_name_2); % combining into one full string
    save(strrep(tot_name,'-','_'), 'DataString'); %Saving Data String with Today's Date, but only takes One take for the day..figure out a way to take multiple trials of data.
    
    
    % Assign values as strings
    lat_text_read = num2str(DataString.Lat(end));
    lon_text_read = num2str(DataString.Lon(end));
    speed_text_read = num2str(DataString.Speed(end));
    heel_text_read = num2str(DataString.Heel(end));
    curr_head_text_read = num2str(DataString.Curr_Heading(end));
    des_head_text_read = num2str(DataString.Des_Heading(end));
    wind_text_read = num2str(DataString.Wind(end)); % Direction
    intensity_text_read = num2str(DataString.Intensity(end)); % Intensity of wind
    rudder_text_read = num2str(DataString.Rudder(end));
    des_rud_text_read = num2str(DataString.Des_Rudder(end));
    curr_sail_text_read = (DataString.Curr_Sail(end)); % Should already be a string
    
    % Update plot
    % --> Graph 1: Latitude & Longitude
    %set(DataString.graph1,'xdata',DataString.Time,'ydata',DataString.Lat);
    set(DataString.graph1,'xdata',DataString.Lat,'ydata',DataString.Lon);
    % --> Graph 2: Wind 
    set(DataString.graph2,'xdata',DataString.Time,'ydata',DataString.Wind);
    % --> Graph 3: Heading
    set(DataString.graph3, 'xdata',DataString.Time,'ydata',DataString.Curr_Heading);
    
    
    
    % Update Text in GUI
    % --> Latitude
    set(DataString.lat_string,'String',lat_text_read);
    % --> Longitude
    set(DataString.lon_string,'String',lon_text_read);
    % --> Speed
    set(DataString.speed_string,'String',speed_text_read);
    % --> Heel
    set(DataString.heel_string,'String',heel_text_read);
    % --> Current Heading
    set(DataString.curr_head_string,'String',curr_head_text_read);
    % --> Desired Heading
    set(DataString.des_head_string,'String',des_head_text_read);
    % --> Wind
    set(DataString.wind_string,'String',wind_text_read);
    % --> Intensity
    set(DataString.intensity_string,'String',intensity_text_read);
    % --> Rudder
    set(DataString.rudder_string,'String',rudder_text_read);
    % --> Desired Rudder
    set(DataString.des_rudder_string,'String',des_rud_text_read);
    % --> Current Sail
    set(DataString.curr_sail_string,'String',curr_sail_text_read);
    
    drawnow
else
    msgbox('Data Not Available. Bad Serial Connection.');
    break % Breaks out of While loop without creating a zillion pop-ups
end
else
    msgbox('Serial Port is Off');
    break
end
end
end
