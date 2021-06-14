%% Extract Zwick Data
clear
clc
close all

opts = spreadsheetImportOptions("NumVariables", 12);

% Specify sheet and range
opts.Sheet = "Zwick_Data";


                    % % % % % MANUALLY CHANGE % % % % % %
opts.DataRange = "A6:L114"; %put calculated strain in L
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


% Specify column names and types
opts.VariableNames = ["Standardtravel", "Standardforce", "Strain",...
    "Stress", "Time", "Toolseparation", "Cyclenumber", "VarName8",...
    "StressMpa", "VarName10", "StressMpa1", "CalcStrain"];
opts.SelectedVariableNames = ["Standardtravel", "Standardforce",...
    "Strain", "Stress", "Time", "Toolseparation", "Cyclenumber",...
    "VarName8", "StressMpa", "VarName10", "StressMpa1", "CalcStrain"];
opts.VariableTypes = ["double", "double", "double", "double",...
    "double", "double", "double", "string", "double", "string",...
    "double", "double"];
opts = setvaropts(opts, [8, 10], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [8, 10], "EmptyFieldRule", "auto");

% Setup rules for import
opts.ImportErrorRule = "omitrow";
opts.MissingRule = "omitrow";
opts = setvaropts(opts, [1,  2,  3,  4,  5,  6,  7,  9, 11],...
    "TreatAsMissing", '');

% Import the data


                    % % % % % MANUALLY CHANGE % % % % % %
zwickData = readtable("D:\Everything\DTI + mech test plaques\Samples\Plaque 54\ZwicktoDIC\54_B21\54B21.xlsx",...
    opts, "UseExcel", false);
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%% Clear temporary variables
clear opts

%% Read in files

                    % % % % % MANUALLY CHANGE % % % % % %
filename = '54_B21_EvalBT1_EngTangStrainY_SurfMean_Ref91.txt';
filename2 = '54_B21_EvalBT1_Time_Ref91.txt';
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    
    
    
    
    
%% Setup - Extraction of DIC data
strain_data = call_strain(filename);
time_data = call_time(filename2);
% Edit time_data - remove NANs from time_data
length = (height(strain_data))+1; % +1 needed to match the table lengths
time_data(length:end,:) = [];   
% make array of time and strain for DIC data
DIC_strain(:,1) = table2array(time_data(:,2)); %time
DIC_strain(:,2) = table2array(strain_data(:,2)); %strain

figure(2); hold on; 
plot(DIC_strain(:,1), DIC_strain(:,2)); title('DIC strain vs time');
xlabel('Time [s]'); ylabel('Strain [%]');




%% Read in measurements as variables into MATLAB workspace and convert to
% array 

zwick_travel = zwickData(:,1);
zwick_travel = table2array(zwick_travel);
zwick_force = zwickData(:,2);
zwick_force = table2array(zwick_force);
zwick_strain = zwickData(:,12); %chaned to calculcated strain, from 3 to 12
zwick_strain = table2array(zwick_strain);
zwick_time = zwickData(:,5);
zwick_time = table2array(zwick_time);
tool_seperation = zwickData(:,6);
tool_seperation = table2array(tool_seperation);

% Stress calculated F / A - Done already in the excel document - call
% variable here.

eng_stress = zwickData(:,11);
eng_stress = table2array(eng_stress);

figure(4); hold on ; plot(zwick_strain,eng_stress);
xlabel('Zwick strain [%]') ; ylabel('Eng stress [MPa]');
title('Clean Zwick stress strain'); xlim([0 50]); ylim([0 0.5]);
%% Blank the zwick time to start from 0
% could do this in excel as well if wanted

A = zwick_time(1);
zwick_time = zwick_time - A;

%% Interpolate values 

% zwick stress at the DIC recorded time
stress_at_DIC_time = interp1(zwick_time,eng_stress,DIC_strain(:,1), 'linear'); 

DIC_strain_smooth = smooth(DIC_strain(:,2));

figure(5); hold on; plot(DIC_strain_smooth,stress_at_DIC_time); 
title('DIC interpolated stress v strain');
xlabel('DIC strain [%]') ; ylabel('Eng stress [MPa]');
xlim([0 50]); ylim([0 0.5]);
% title('DIC stress strain');xlabel('DIC strain [%]');
% ylabel('DIC stress [MPa]'); ylim([0 .25]);
%figure(6); hold on; plot(DIC_strain(:,2),stress_at_DIC_time);

%% Compare Zwick interpolated DIC

figure(6);
hold on;
plot(zwick_strain,eng_stress);
hold on;
plot(DIC_strain_smooth,stress_at_DIC_time); 
xlabel('Strain [%]') ; ylabel('Eng stress [MPa]');
xlim([0 50]); ylim([0 0.5]);
legend('Zwick','DIC');

%% Save variables from the workspace - DIC stress strain
% 
% save('stress_at_DIC_time'); save('DIC_strain_smooth'); save('DIC_strain');
% save('zwick_force'); save('zwick_strain'); save('eng_stress');