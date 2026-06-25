% Code to plot simulation results from PowerSplitHEV
%% Plot Description:
%
% The plot below shows the electrical losses from the motor, generator, and
% battery as the vehicle accelerates and decelerates.  The largest losses
% come from the motor and the battery.

% Copyright 2016-2023 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
if ~exist('simlog_PowerSplitHEV', 'var') || ...
        simlogNeedsUpdate(simlog_PowerSplitHEV, 'PowerSplitHEV') 
    sim('PowerSplitHEV')
    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
end

% Reuse figure if it exists, else create new figure
if ~exist('h2_PowerSplitHEV', 'var') || ...
        ~isgraphics(h2_PowerSplitHEV, 'figure')
    h2_PowerSplitHEV = figure('Name', 'PowerSplitHEV');
end
figure(h2_PowerSplitHEV)
clf(h2_PowerSplitHEV)

% Get simulation results
simlog_t = simlog_PowerSplitHEV.Engine.PS_Product.O.series.time;
simlog_ePwrMotor = simlog_PowerSplitHEV.Motor.Electrical_Power.PS_Product.O.series.values;
simlog_mPwrMotor = simlog_PowerSplitHEV.Motor.Mechanical_Power.PS_Product.O.series.values;
simlog_lossMotor = simlog_ePwrMotor-simlog_mPwrMotor;
simlog_ePwrGen = simlog_PowerSplitHEV.Generator.Mechanical_Power.PS_Product.O.series.values;
simlog_mPwrGen = simlog_PowerSplitHEV.Generator.Electrical_Power.PS_Product.O.series.values;
simlog_lossGen = simlog_ePwrGen-simlog_mPwrGen;
simlog_lossBatt = simlog_PowerSplitHEV.Battery.Calculations.R.O.series.values;
simlog_vVeh = simlog_PowerSplitHEV.Vehicle_Body.Mass.v.series.values('km/hr');

temp_colorOrder = get(groot,'defaultAxesColorOrder');

% Plot results
yyaxis left
plot(simlog_t, (simlog_lossBatt+simlog_lossMotor+simlog_lossGen)/1000, 'LineWidth', 1)
hold on
plot(simlog_t, simlog_lossMotor/1000, 'LineWidth', 1)
plot(simlog_t, simlog_lossGen/1000, '-.','LineWidth', 1)
plot(simlog_t, simlog_lossBatt/1000,'-','LineWidth', 1,'Color',temp_colorOrder(5,:));
ylabel('Electrical Losses (kW)')
yyaxis right
plot(simlog_t, simlog_vVeh, 'LineWidth', 1)
ylabel('Speed (km/hr)')
grid on
title('Electrical Losses and Vehicle Speed')
legend({'Total Losses','Motor Losses','Generator Losses','Battery Losses','Vehicle Speed'},'Location','NorthEast');
xlabel('Time (s)')

% Remove temporary variables
clear simlog_t temp_colorOrder
clear simlog_lossMotor simlog_lossGen simlog_lossBatt 
clear simlog_ePwrGen simlog_mPwrGen simlog_ePwrMotor simlog_mPwrMotor
clear simlog_vVeh
