clc; %clear command line
clear all; %#ok<CLALL> %clear workspace
fprintf('Running code \n');

%% Input Variables %% 
%Zload = 0; %Load Impedance
Zgen = 50; %Generator Impedance
z0 = 50; %Characteristic Impedance
l = 11.7; %Line Lentgth
beta = (2*pi); 
%Vphasor = ; % Phasor expression of voltage. Always convert time domain into phasor. This is the voltage at any point in the line.
V0Plus = 10 ; %Part of phasor attached to e^-jBy
V0Minus = 2*exp(-1i*(pi/3)); % Part of phasor attached to e^+jBy

%% Gamma: The Reflection Coefficient%%
Gamma = ((V0Minus) / (V0Plus));
%Gamma = ((ZLoad - z0)/(ZLoad + z0));

%% Load Impedance using Gamma and z0 %%
ZLoad = ((-z0-Gamma*z0)/(Gamma -1));

%% Load Impedance using PVoltage at 0 vs Current at 0 %%
%PVoltage0 = (V0Plus*exp(-1i*beta*0)+V0Minus*exp(1i*beta*0));
%PCurrent0 = ((V0Plus-V0Minus)/(z0)); % This is also current everywhere for series circuit
%ZLoad = PVoltage0/ PCurrent0; %Voltage at load / Current at load = impedance at load in phasor

%% Input Impedance Zin %%
Zin = z0 * ((ZLoad*cos(beta*l) + 1i*z0*sin(beta*l))/ (z0*cos(beta*l) + 1i*ZLoad*sin(beta*l))); %%The line length shouldnt be negative for this (l)

%% Phasor Voltage at Vin (Vi) %%
z = -l;
PVoltageIn = (V0Plus*exp(-1i*beta*z)+V0Minus*exp(1i*beta*z)); %Phasor Voltage at position z
%PVoltageIn = V0Plus*(exp(-1i*beta*z)+ Gamma*exp(1i*beta*z));

%% Phasor Voltage at 0 (Vl) %%
PVoltageLoad = (V0Plus*exp(-1i*beta*0)+V0Minus*exp(1i*beta*0)); %Phasor Voltage at position z
%PVoltageLoad = V0Plus*(exp(-1i*beta*z)+ Gamma*exp(1i*beta*z));

%% Phasor Voltage at any point %%
%z = 0;
%PVoltage = (V0Plus*exp(-1i*beta*z)+V0Minus*exp(1i*beta*z)); %Phasor Voltage at position z
%PVoltage = V0Plus*(exp(-1i*beta*z)+ Gamma*exp(1i*beta*z));

%% Phasor Generator Voltage Vg(y) %%
PVoltageGen = ((PVoltageIn*(Zin + Zgen))/(Zin)); %% Rectangular Form of Answer
rho = abs(PVoltageGen);
theta = angle(PVoltageGen);
PVoltageGenPolar = rho*exp(j*theta); %% Polar Form of Answer MATLAB is giving me crap but you can use rho and theta to get it in polar

%% Time average power at generator Pg %%
Pg = .5*real(PVoltageGen * conj((PVoltageIn/Zin))); %%Units in Watts

%% Time average power at Load Pl %%
Pl = .5*real(PVoltageLoad * conj((PVoltageLoad/ZLoad))); %%Units in Watts

%% Working Through 2 Montse %%
Zm = 40*exp(1i*pi/2);
Zgen = 50;
ZLoad = 30+ 1i*40;
z0 = 50;
PVoltageLoad = 7;
biglength = 6.15;
smalllength = 0.75;
truelength = biglength - smalllength;


%Find Zin for the small loop
l = smalllength;
Zin = z0 * ((ZLoad*cos(beta*l) + 1i*z0*sin(beta*l))/ (z0*cos(beta*l) + 1i*ZLoad*sin(beta*l))); %%The line length shouldnt be negative for this (l)

%Small t line gamma
Gamma = ((ZLoad - z0)/(ZLoad + z0));

%Put Zin in parallel with Zm we will call this the new ZLoad
ZLoad = 1/((1/Zin)+(1/Zm));

%Now look at the biger loop we now must find the new Zin
l = truelength;
Zin = z0 * ((ZLoad*cos(beta*l) + 1i*z0*sin(beta*l))/ (z0*cos(beta*l) + 1i*ZLoad*sin(beta*l)));

%Voltage at new load is V0plus + V0minus which is equivalent to

V0Plus = (1-Gamma)/(PVoltageLoad); %% This is for the old small t line we use this to calculate voltage at Zm
z = l;
PVoltage = V0Plus*(exp(-1i*beta*-z)+ Gamma*exp(1i*beta*-z));





