clc; %clear command line
clear all; %clear workspace
fprintf('Running code \n');

%Input Variables
%Zload = 0; %Load Impedance
%Zgen = 0; %Generator Impedance
%z0 = 50; %Characteristic Impedance
%l = 11.7; %Line Lentgth
beta = (2*pi); 
%Vphasor = ; % Phasor expression of voltage. Always convert time domain into phasor. This is the voltage at any point in the line.
%V0Plus = 10 ; %Part of phasor attached to e^-jBy
%V0Minus = 2*exp(-1i*(pi/3)); % Part of phasor attached to e^+jBy

%%Load Impedance using Gamma and z0%%
%ZLoad = ((-z0-Gamma*z0)/(Gamma -1));

%%Load Impedance using PVoltage at 0 vs Current at 0%%
%PVoltage0 = (V0Plus*exp(-1i*beta*0)+V0Minus*exp(1i*beta*0));
%PCurrent0 = ((V0Plus-V0Minus)/(z0)); % This is also current everywhere for series circuit
%ZLoad = PVoltage0/ PCurrent0; %Voltage at load / Current at load = impedance at load in phasor

%%Input Impedance%%
%Zin = z0 * ((ZLoad*cos(beta*l) + 1i*z0*sin(beta*l))/ (z0*cos(beta*l) + 1i*ZLoad*sin(beta*l)));

%Gamma: The Reflection Coefficient
%Gamma = ((V0Minus) / (V0Plus));
%Gamma = ((ZLoad - z0)/(ZLoad + z0));

%Phasor Voltage at Vin
%z = l;
%PVoltageIn = (V0Plus*exp(-1i*beta*z)+V0Minus*exp(1i*beta*z)); %Phasor Voltage at position z
%PVoltageIn = V0Plus*(exp(-1i*beta*z)+ Gamma*exp(1i*beta*z));

%Phasor Voltage at any point
%z = 0;
%PVoltage = (V0Plus*exp(-1i*beta*z)+V0Minus*exp(1i*beta*z)); %Phasor Voltage at position z
%PVoltage = V0Plus*(exp(-1i*beta*z)+ Gamma*exp(1i*beta*z));
