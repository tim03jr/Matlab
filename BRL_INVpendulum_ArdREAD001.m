%% Reads data from an Arduino 
% Plots:
%     Raw reading from Arduino vs. time
%     Acceleration vs. d(PWM)/dt
%     Force vs. d(PWM)/dt

clear
clc
 
%% Close serial port if open
clear ard
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

%% User Defined Properties 
serialPort = 'COM3';            % define COM port #
plotTitle_raw = 'Raw Reading vs. Time';  % plot title
plotTitle_accel = 'Acceleration vs. d(PWM)/dt';
plotTitle_force = 'Force vs. d(PWM)/dt';
xLabel_raw = 'Time (Seconds)';
xLabel = 'Rate of change of PWM per time d(PWM)/dt';    % x-axis label
yLabel_raw = 'Raw Data (0-255)';           % y-axis label for raw data plot
yLabel_accel = 'Acceleration (m/s^2)';      % y-axis label for accel plot
yLabel_force = 'Force (N)';             % y-axis label for force plot
max_raw = 255;                   % set y-max for raw data plot (0-1023)
max_accel = 30;                     % set y-max_1 for acelleration plot (m/s^2)
max_force = 5;                     % set y_max_2 for force plot (N)
min = 0;                        % set y-min
delay = .001;                    % make sure sample faster than resolution
mass = 0.45; 

%% Initialize variables
time = 0;
PWMchange = 0;
rawAccel = 0;
actualAccel = 0;
force = 0;
loopIteration = 0.00;
 
%% Set up Plot
%plot setup for val vs. time
subplot(3,1,1);
plotGraph_raw = plot(time,rawAccel,'-mo',...
                'LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',[.49 1 .63],...
                'MarkerSize',2);
             
title(plotTitle_raw,'FontSize',25);
xlabel(xLabel_raw,'FontSize',15);
ylabel(yLabel_raw,'FontSize',15);
axis([0 10 min max_raw]);
grid('on');

%plot setup for acceleration vs d(PWM)/dt
subplot(3,1,2);
plotGraph_accel = plot(PWMchange,actualAccel,'-mo',...
                'LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',[.49 1 .63],...
                'MarkerSize',2);
             
title(plotTitle_accel,'FontSize',25);
xlabel(xLabel,'FontSize',15);
ylabel(yLabel_accel,'FontSize',15);
axis([0 10 min max_accel]);
grid('on');

%plot setup for Force vs d(PWM)/dt
subplot(3,1,3)
plotGraph_force = plot(PWMchange,force,'-mo',...
                'LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',[.49 1 .63],...
                'MarkerSize',2);
             
title(plotTitle_force,'FontSize',25);
xlabel(xLabel,'FontSize',15);
ylabel(yLabel_force,'FontSize',15);
axis([0 10 min max_force]);
grid('on');

%% START CODE
ard = serial(serialPort,'BaudRate',115200);
fopen(ard);

tic%take note of time
 
while 1  %ishandle(plotGraph_raw) %Loop when Plot is Active

   %FYI A = fread(obj,SIZE,PRECISION)
   rawRead = fread(ard,1,'uint8'); %Read in data from the Arduino
   flushinput(ard);
   %Send a PWM to the robotic arm and take note of it
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %Set up an incrementation for the PWM
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
 %  if(~isempty(rawAccel) && isnumeric(rawAccel))%AKA if the array y is not empty AND the values in y are numeric
       loopIteration = loopIteration + 1;
       time(loopIteration) = toc;%Saves the current time into the indice of the time array specified by loopIteration
     
       %Plot rawAccel vs. time
        %Set(plot handle, property name, property val, etc.)
        %Resets the plot with new time and data property values.
        rawAccel(loopIteration) = rawRead;%Saves the current data into the indice of the data array specified by count
        subplot(3,1,1);
        set(plotGraph_raw,'XData',time,'YData',rawAccel);
        axis([0 time(loopIteration) min max_raw]);
     
        %Plot ActualAcell vs. d(PWM)/dt
        %Convert rawAccel (0-1023) to ActualAcell (0-30 m/s^2) 
        actualAccel(loopIteration) = (30/1023)*rawAccel(loopIteration);%30/1023 is the slope of the line that linearly interpolates 0-1023 on the abcissa and 0-30 on the ordinate
        subplot(3,1,2);
        set(plotGraph_accel,'XData',time,'YData',actualAccel);
        axis([0 time(loopIteration) min max_accel]);
        
        %Plot Force vs. d(PWM)/dt
        %Convert ActualAcell (0-30 m/s^2) to Force (0-20 N) via F = ma
        subplot(3,1,3);
        force = mass*actualAccel;%mass is the mass of everything that is on the end of the robotic arm.
        set(plotGraph_force,'XData',time,'YData',force);
        axis([0 time(loopIteration) min max_force]);
        
        %Allow MATLAB to Update Plot
        pause(delay);
 %  end
end
fclose(ard);
clear count ard delay max min plotGraph plotGrid plotTitle s ...
        scrollWidth serialPort xLabel yLabel;

