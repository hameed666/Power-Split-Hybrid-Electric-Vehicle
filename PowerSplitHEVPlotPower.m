% Code to plot simulation results from PowerSplitHEV
%% Plot Description:
%
% The plot below shows the flow of power from the engine, motor, and
% generator as the vehicle accelerates and decelerates.  The generator
% supplies the DC network with a constant flow of power drawn from the
% engine.  The motor draws power from the battery to accelerate the vehicle
% and then uses regenerative braking to feed that power back to the
% battery.

% Copyright 2016-2023 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
if ~exist('simlog_PowerSplitHEV', 'var') || ...
        simlogNeedsUpdate(simlog_PowerSplitHEV, 'PowerSplitHEV') 
    sim('PowerSplitHEV')
    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_PowerSplitHEV', 'var') || ...
        ~isgraphics(h1_PowerSplitHEV, 'figure')
    h1_PowerSplitHEV = figure('Name', 'PowerSplitHEV');
end
figure(h1_PowerSplitHEV)
clf(h1_PowerSplitHEV)

% Get simulation results
simlog_t = simlog_PowerSplitHEV.Engine.PS_Product.O.series.time;
simlog_pwrEngine = simlog_PowerSplitHEV.Engine.PS_Product.O.series.values;
simlog_pwrMotor = simlog_PowerSplitHEV.Motor.Electrical_Power.PS_Product.O.series.values;
simlog_pwrGen = simlog_PowerSplitHEV.Generator.Electrical_Power.PS_Product.O.series.values;
simlog_pwrBatt = simlog_PowerSplitHEV.Battery.Calculations.Power.O.series.values;
simlog_vVeh = simlog_PowerSplitHEV.Vehicle_Body.Mass.v.series.values('km/hr');

temp_colorOrder = get(groot,'defaultAxesColorOrder');

% Plot results
yyaxis left
plot(simlog_t, simlog_pwrMotor/1000, 'LineWidth', 1)
hold on
plot(simlog_t, simlog_pwrEngine/1000, 'LineWidth', 1)
plot(simlog_t, simlog_pwrGen/1000, '-.','LineWidth', 1)
plot(simlog_t, simlog_pwrBatt/1000,'-','LineWidth', 1,'Color',temp_colorOrder(5,:));
ylabel('Power (kW)')
yyaxis right
plot(simlog_t, simlog_vVeh, 'LineWidth', 1)
ylabel('Speed (km/hr)')
grid on
title('Power and Vehicle Speed')
legend({'Motor Power','Engine Power','Generator Power','Battery Power','Vehicle Speed'},'Location','NorthEast');
xlabel('Time (s)')

% Remove temporary variables
clear simlog_t temp_colorOrder
clear simlog_pwrEngine simlog_pwrMotor simlog_pwrGen simlog_pwrBatt 
clear simlog_vVeh
