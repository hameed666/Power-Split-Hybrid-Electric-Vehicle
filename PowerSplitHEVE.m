%% Power Split Hybrid Vehicle Electrical Network
% 
% This example shows the basic architecture of a power-split hybrid
% transmission. The planetary gear, along with the motor and generator,
% acts like a variable ratio gear. In this test, the vehicle accelerates
% from 15 m/s to 20 m/s, and then decelerates back to 15 m/s. The power
% management strategy uses just electrical power to perform the maneuver.
% 
% The motor, generator, and DC-DC converter are modeled using Simscape(TM)
% Electrical(TM) library blocks. These blocks use energy-based
% system-level equations that result in an efficient simulation whilst
% still capturing conversion losses. As such, the model is suitable for
% supporting design of the power management strategy. This example can be
% directly compared with the Simscape Driveline(TM) sdl_hybrid_power_split
% example which also includes more accurate representations of the engine,
% tires and mechanical gears.
% 
% 

% Copyright 2008-2025 The MathWorks, Inc.



%% Model

open_system('PowerSplitHEV')

set_param(find_system('PowerSplitHEV','FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Motor Subsystem

open_system('PowerSplitHEV/Motor','force')

%% Simulation Results from Simscape Logging
%%
%
% The plot below shows the flow of power from the engine, motor, and
% generator as the vehicle accelerates and decelerates.  The generator
% supplies the DC network with a constant flow of power drawn from the
% engine.  The motor draws power from the battery to accelerate the vehicle
% and then uses regenerative braking to feed that power back to the
% battery.
%


PowerSplitHEVPlotPower;
%%
%
% The plot below shows the electrical losses from the motor, generator, and
% battery as the vehicle accelerates and decelerates.  The largest losses
% come from the motor and the battery.
%


PowerSplitHEVPlotLosses;

%% Results from Real-Time Simulation
%%
%
% This example has been tested on these platforms:
%
% * Speedgoat(TM) Performance real-time target machine with an Intel(R) 3.5 
% GHz i7 multi-core CPU and 4 GB RAM. 
% 
% * dSPACE(R) SCALEXIO LabBox with Intel(R) Core XEON E3-1275v3 at 3.5GHz 
% and 4 GB RAM.
%
% You can run this model in real time with a step size of 50 microseconds 
% by using the Simscape local solver. For small sample rates, a task 
% overrun might occur during the initial task execution due to a cold 
% cache. To avoid this overrun, if the selected platform supports these 
% options, relax the start-up behavior by specifying a limited number of 
% task overruns or increasing the sample time of periodic tasks during the 
% start-up phase of the real-time application.

%%

