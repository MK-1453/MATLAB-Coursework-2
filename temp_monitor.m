%This function continously monitors the temperature using an arduino
%sensor. This arduino is connected to a breadboard with the sensor and 3
%LEDs. If temp is between 18 and 24, green lights up, if below 18 yellow
%LED blinks, if above 24, red LED blinks. The live data is displayed on a
%graph.

function temp_monitor(a)
    %Positions
    sensor = 'A2';
    green = 'D13';
    yellow = 'D11';
    red = 'D10';
    
    %Constants
    T_coeff = 0.01; %V/C
    V0 = 0.5; %V

    %Arrays for the plot
    time = [];
    tempVals = [];

    
    figure;
    
    x = 0;



    while true
        voltage = readVoltage(a, sensor);
        temp = (voltage - V0)/ T_coeff;

        
        

        time(end+1) = x;
        tempVals(end+1) = temp;

        %Plot Graph
        plot(time, tempVals);
        xlabel('Time (s)');
        ylabel('Temperature (C)');
        title('Live Temperature v Time');
        grid on

        %limits
        xlim([0 max(10, x+1)]);
        ylim([min(tempVals)-2 max(tempVals)+2]);

        drawnow;


        %Printing temp
        fprintf('Temperature = %.2f C\n', temp)
        
        %Conditions for green
        if temp >= 18 && temp <= 24
            writeDigitalPin(a, green,1);
            writeDigitalPin(a, red,0);
            writeDigitalPin(a, yellow,0);

            pause(1); %checks once every one second
        
        %conditions for yellow
        elseif temp < 18
            writeDigitalPin(a, green,0);
            writeDigitalPin(a, red,0);

            writeDigitalPin(a, yellow,1);
            pause(0.5);
            writeDigitalPin(a, yellow,0);
            pause(0.5);
         
        %conditions for red
        else 
            writeDigitalPin(a, green,0);
            writeDigitalPin(a, yellow,0);

            writeDigitalPin(a, red,1);
            pause(0.25);
            writeDigitalPin(a, red,0);
            pause(0.25)
            writeDigitalPin(a, red,1);
            pause(0.25);
            writeDigitalPin(a, red,0);
            pause(0.25);
        end

        x = x +0.3; %updates every 0.3s
    end
end
