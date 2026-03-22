% Mehmet Kocager
% egymk11@nottingham.ac.uk



%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [5 MARKS]


writeDigitalPin(a,'D12',1) %Max LED
writeDigitalPin(a,'DX',0) %LED off

for n = 1:100  %Blinking LED
    writeDigitalPin(a,'D12',0)
    pause(0.5)
    writeDigitalPin(a,'D12',0)
end


%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
clear
a = arduino('COM5','UNO');
%B)
duration = 600;

no_samples = duration+1;
%Setting arrays
time = zeros(1, no_samples);
voltage = zeros(1,no_samples);
temp = zeros(1,no_samples);

%Constants
T_coeff = 0.01; %V/C
V0 = 0.5; %V

for x = 1:no_samples
    time(x) = x-1;

    voltage(x) = readVoltage(a, 'A2');

    %Voltage to temp
    temp(x) = (voltage(x) - V0) / T_coeff;

    Ensuring Measuremnts are taken in 10 mins
    if x < no_samples
        pause(1);
    end

end

%Statistical quantities
min_temp = min(temp);
max_temp = max(temp);
avg_temp = mean(temp);



%C)
figure;
plot(time, temp);
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Temperature V Time')
grid on;

%D)
date = '22/03/36';
location = 'Nottingham';

output = sprintf('Data logging initiated - %s\nLocation - %s\n\n', date,location);

for min = 0:10
    index = min * 60 + 1;
    output = [output sprintf('Minute\t\t%d\nTemperature\t%.2f C\n\n',min,temp(index))];
end

output = [output sprintf('Max temp\t%.2f C\nMin temp\t%.2f C\nAverage temp\t%.2f C\n\nData logging terminated\n',max_temp,min_temp,avg_temp)];

fprintf('%s',output)

%E)

fileID = fopen('capsule_temperature.txt', 'w');

fprintf(fileID, '%s', output);

fclose(fileID);

%Checking file
fileID = fopen('capsule_temperature.txt','r');
fileText = fread(fileID, '*char')';
fclose(fileID);

disp(fileText)
%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]




%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [30 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% No need to enter any answers here, please answer on the .docx template.


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answers here, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.