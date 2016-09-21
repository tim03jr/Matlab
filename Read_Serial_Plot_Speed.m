%% Reads serial data and plots it. Plot changes dynamically.
%In CODE section, must change use appropriate
clear
clc

%% Define Function Variables
time = 0;
data = 0;
count = 0;
min = -1;
max = 15;

%% Set up Plot
%The use of a plot handle allows us to change the plot parameters
%dynamically. In this case only time and data are changed.
plotGraph = plot(time,data,'-mo',...
                'LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',[.49 1 .63],...
                'MarkerSize',2);
             
title('MotorSpeed','FontSize',25);
xlabel('Elapsed Time (s)','FontSize',15);
ylabel('Speed (rpm)','FontSize',15);
axis([0 10 min max]);
grid('on');
scrollWidth = 0;               % display period in plot, plot entire data log if <= 0
delay = .001;                    % (Sample rate) make sure sample faster than resolution
 

%% CODE
ard = serial('COM6','BaudRate',19200);

fopen(ard);%open the Serial port
tic%Start a timer

while ishandle(plotGraph)%AKA while plotGraph is a valid graphics handle 
    
   y = fscanf(ard, '%f')%Get data from serial object ard
   
   if(~isempty(y) )%&& isfloat(y))%AKA if the array y is not empty and the values in y are numeric
       count = count + 1;
       time(count) = toc;%Saves the currunt time into the indice of the time array specified by count
       data(count) = y(1);%Saves the current data into the indice of the data array specified by count
       
       if(scrollWidth > 0)%For use when the window of the plot is set to change
        
        %Set(plot handle, property name, property val, etc.)
        %Resets the plot with new time and data property values.
        set(plotGraph,'XData',time(time > time(count)-scrollWidth),'YData',data(time > time(count)-scrollWidth));
        
        %Resets the axis to a min of 10 minus the last indice of the time array and
        %a max of the last indice of the time array.
        axis([time(count)-scrollWidth, time(count), min, max]);
        
       else%For use when the window of the plot is set to not change.
        set(plotGraph,'XData',time,'YData',data);
        axis([0 time(count) min max]);
        end
         
        %Allow MATLAB to Update Plot
        pause(delay);
    end
end
fclose(ard);
clear count ard delay max min plotGraph plotGrid plotTitle s ...
        scrollWidth serialPort xLabel yLabel;




