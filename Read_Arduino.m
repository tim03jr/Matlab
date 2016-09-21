%% Reads data from an Arduino 
% 512 values are read with the fread command.
% The baudrate drastically affects the data.
% A very fast baud rate only catches a small instance in time.


%% Close serial port (Only necessary for using the arduino support package)
% clear ard
% if ~isempty(instrfind)
%     fclose(instrfind);
%     delete(instrfind);
% end

%% START CODE
ard = serial('COM6','BaudRate',9600);

fopen(ard);
%Should send something to the arduino to start the motor
y = fread(ard)
fclose(ard);
plot(y);


