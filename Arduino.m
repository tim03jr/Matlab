%CONTAINS SETUP INFORMATION FOR ARDUINO AND MOTOR-SHIELD (arduino support package)

%NOTE USING MEGA2560: Must route jumper from pin 20 and 21 on board to SDA and SLA on shield.  

%HAVE TO RUN THIS TO END PREVIOUS SERIAL CONNECTION
% clear s dcm sm shield a
% OR
% if ~isempty(instrfind)
%     fclose(instrfind);
%     delete(instrfind);
% end


a = arduino('COM5', 'Mega2560', 'Libraries', 'Adafruit/MotorShieldV2'); %if more than one arduino: a = arduino('com23', 'uno')
shield = addon(a, 'Adafruit/MotorShieldV2'); %Creates an object for the shield
dcm = dcmotor(shield, 3);%Creates a DC motor object
%sm = stepper(shield, 2, 200, 'stepType', 'Double');%Stepper oject (200 = steps/rev)

%Stepper control %help stepper
% sm.RPM = 80;
% move(sm, 500);
% pause(2);
% move(sm, -500);
% release(sm);


%DC motor control %help dcmotor
start(dcm); %Starts the object with the last parameters
pause(2);
dcm.Speed = 1; %Speed btw -1 and 1
pause(5);
stop(dcm);


%Blinks an LED 
% for idx = 0:10
%     writeDigitalPin(a,13,1);
%     pause(0.5);
%     writeDigitalPin(a,13,0);
%     pause(0.5);
% end



%Closes serial port
clear s dcm sm shield a
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
