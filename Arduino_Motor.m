%% Interface with a dc motor which has a single encoder.

%Closes serial port
clear a s m 
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end


%SETUP
clf
%Motor object setup w/ Sheild object
a = arduino('COM6', 'Uno', 'Libraries', 'Adafruit/MotorShieldV2');
s = addon(a, 'Adafruit/MotorShieldV2');
m = dcmotor(s, 3, 'Speed', 0.8);%Speed: -1 to 1


%ADDITIONAL SETUP
configurePin(a, 'A0', 'AnalogInput');
%configurePin(a, 'D2', 'DigitalInput');%Read encoder
t = 1:0.1:100;
pulse = zeros(1,length(t));%1x10 %Pre-allocate matrix



%READ PULSES AND PLOT
start(m);
dcm.Speed = 1; %Speed btw -1 and 1

 for count = 1:length(t)
 pulse(count) = readVoltage(a,'A0');
 %pulse(count) = readDigitalPin(a,'D2');
 plot(t,pulse)
 xlim([0 20]);
 ylim([-1 5]);
 end
 
stop(m);


%Adjust the speed of the motor.


%Closes serial port
clear a s m 
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end