% Grand Average TSA (Unfiltered) and ERP (Filtered) 
% Created: Hannover, 15.4.2020
% Uploaded: 8.9.2023
% Brilliant - VIANNA/MHH

%--------------------------------------------------------------------------
%% SUBJECT INDEXING
%--------------------------------------------------------------------------
subject1 = 'XXXX01';
subject2 = 'XXXX02';
subject3 = 'XXXX03';
subject4 = 'XXXX04';
subject5 = 'XXXX05';
subject6 = 'XXXX06';
subject7 = 'XXXX07';
subject8 = 'XXXX08';
subject9 = 'XXXX09';
subject10 = 'XXXX10';
subject11 = 'XXXX11';
subject12 = 'XXXX12';
subject13 = 'XXXX13';
subject14 = 'XXXX14';
subject15 = 'XXXX15';
subject16 = 'XXXX16';
subject17 = 'XXXX17';
subject18 = 'XXXX18';
subject19 = 'XXXX19';
subject20 = 'XXXX20';
group = 'NHYoung';

analysisMODE = 1; %analysisMODE: 
                  %1: VIQuiet, 2: VINoise,
                  %3: STQuiet, 4: STNoise,
                  %5: conQuiet, 6: conNoise,
                  %7: inconQuiet, 8: inconNoise,

for ROIMODE = 2:2                  
% ROIMODE = 1; %ROIMODE: %1: Frontal, 2: Central, %3: Parietal, %4: Occipital

datum = '220720';

switch ROIMODE
    case 1
        ROI = 'Frontal';
        roi = 'frontal';
    case 2
        ROI = 'Central';
        roi = 'central';        
    case 3
        ROI = 'Parietal';
        roi = 'parietal';
    case 4
        ROI = 'Occipital';  
        roi = 'occipital';        
end

%% Task

switch analysisMODE
    case 1
        Task = 'VIQuiet'; 
        DataNameTSA = 'TSA_VI';
        task = Task;
    case 2
        Task = 'VINoise';
        DataNameTSA = 'TSA_VI';
        task = Task;        
    case 3
        Task = 'STQuiet';
        DataNameTSA = 'TSA_ST';
        task = Task;        
    case 4
        Task = 'STNoise';
        DataNameTSA = 'TSA_ST';
        task = Task;        
    case 5
        Task = 'STQuiet';
        DataNameTSA = 'TSA_con';
        task = 'conQuiet';        
    case 6
        Task = 'STNoise';
        DataNameTSA = 'TSA_con';
        task = 'conNoise';        
    case 7
        Task = 'STQuiet';
        DataNameTSA = 'TSA_incon';
        task = 'inconQuiet';        
    case 8
        Task = 'STNoise';
        DataNameTSA = 'TSA_incon';
        task = 'inconNoise';
end

%--------------------------------------------------------------------------
%% DATA I/O
%--------------------------------------------------------------------------
%INPUT PLOT
if analysisMODE<=2
    inputDataFolder  = ['D:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\VI\' group '\'];
else
    inputDataFolder  = ['D:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\ST\' group '\'];
end

%OUTPUT PLOT
outputPlotFolder = ['D:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\ERP\'];
mkdir(outputPlotFolder);

%AVG
for foldup = 1:1
S = load([inputDataFolder '\' subject1 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject1 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject1 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject2 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject2 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject2 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject3 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject3 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject3 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject4 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject4 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject4 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject5 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject5 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject5 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject6 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject6 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject6 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject7 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject7 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject7 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject8 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject8 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject8 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject9 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject9 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject9 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject10 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject10 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject10 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject11 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject11 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject11 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject12 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject12 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject12 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject13 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject13 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject13 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject14 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject14 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject14 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject15 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject15 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject15 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject16 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject16 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject16 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject17 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject17 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject17 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject18 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject18 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject18 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject19 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject19 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject19 = S.([DataNameTSA '_avg']);
clear S;

S = load([inputDataFolder '\' subject20 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
load([inputDataFolder '\' subject20 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_avg.mat']);
TSA_Subject20 = S.([DataNameTSA '_avg']);
clear S;

end
clear TFR_VI_avg TSA_VI_avg TFR_ST_avg TSA_ST_avg TFR_con_avg TSA_con_avg TFR_incon_avg TSA_incon_avg

%ALLTRLS
for foldup = 1:1
S = load([inputDataFolder '\' subject1 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject1 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject1_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject2 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject2 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject2_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject3 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject3 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject3_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject4 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject4 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject4_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject5 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject5 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject5_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject6 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject6 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject6_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject7 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject7 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject7_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject8 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject8 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject8_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject9 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject9 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject9_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject10 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject10 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject10_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject11 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject11 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject11_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject12 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject12 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject12_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject13 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject13 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject13_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject14 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject14 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject14_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject15 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject15 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject15_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject16 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject16 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject16_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject17 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject17 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject17_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject18 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject18 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject18_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject19 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject19 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject19_alltrls = S.([DataNameTSA '_alltrls']);
clear S;

S = load([inputDataFolder '\' subject20 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
load([inputDataFolder '\' subject20 '\' Task '\TFR\ROI\Data\' ROI '\' DataNameTSA '_alltrls.mat']);
TSA_Subject20_alltrls = S.([DataNameTSA '_alltrls']);
clear S;
end
clear TSA_VI_alltrls TSA_ST_alltrls TSA_con_alltrls TSA_incon_alltrls

%meanRT Calculation
%Subject20 Commented
for foldup = 1:1
S = load([inputDataFolder '\' subject1 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject1 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject1 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject2 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject2 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject2 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject3 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject3 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject3 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject4 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject4 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject4 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject5 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject5 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject5 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject6 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject6 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject6 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject7 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject7 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject7 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject8 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject8 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject8 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject9 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject9 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject9 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject10 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject10 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject10 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject11 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject11 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject11 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject12 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject12 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject12 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject13 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject13 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject13 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject14 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject14 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject14 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject15 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject15 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject15 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject16 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject16 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject16 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject17 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject17 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject17 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject18 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject18 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject18 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject19 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject19 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject19 = S.(['dataft_' roi]);
clear S;

S = load([inputDataFolder '\' subject20 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
load([inputDataFolder '\' subject20 '\' Task '\TFR\ROI\Data\' roi '\dataft_' roi '.mat']);
dataft_Subject20 = S.(['dataft_' roi]);
clear S;
end
clear dataft_frontal dataft_central dataft_parietal dataft_occipital
clc
if analysisMODE <=4
    %Subject20 commented
    meanRT_Subject1 = mean(dataft_Subject1.trialinfo(:,5))/1000;
    meanRT_Subject2 = mean(dataft_Subject2.trialinfo(:,5))/1000;
    meanRT_Subject3 = mean(dataft_Subject3.trialinfo(:,5))/1000;
    meanRT_Subject4 = mean(dataft_Subject4.trialinfo(:,5))/1000;
    meanRT_Subject5 = mean(dataft_Subject5.trialinfo(:,5))/1000;
    meanRT_Subject6 = mean(dataft_Subject6.trialinfo(:,5))/1000;
    meanRT_Subject7 = mean(dataft_Subject7.trialinfo(:,5))/1000;
    meanRT_Subject8 = mean(dataft_Subject8.trialinfo(:,5))/1000;
    meanRT_Subject9 = mean(dataft_Subject9.trialinfo(:,5))/1000;
    meanRT_Subject10 = mean(dataft_Subject10.trialinfo(:,5))/1000;
    meanRT_Subject11 = mean(dataft_Subject11.trialinfo(:,5))/1000;
    meanRT_Subject12 = mean(dataft_Subject12.trialinfo(:,5))/1000;
    meanRT_Subject13 = mean(dataft_Subject13.trialinfo(:,5))/1000;
    meanRT_Subject14 = mean(dataft_Subject14.trialinfo(:,5))/1000;
    meanRT_Subject15 = mean(dataft_Subject15.trialinfo(:,5))/1000;
    meanRT_Subject16 = mean(dataft_Subject16.trialinfo(:,5))/1000;
    meanRT_Subject17 = mean(dataft_Subject17.trialinfo(:,5))/1000;
    meanRT_Subject18 = mean(dataft_Subject18.trialinfo(:,5))/1000;
    meanRT_Subject19 = mean(dataft_Subject19.trialinfo(:,5))/1000;
    meanRT_Subject20 = mean(dataft_Subject20.trialinfo(:,5))/1000;

    else if (analysisMODE == 5 || analysisMODE == 6)
         
for foldup = 1:1
cfg = [];
cfg.trials = find(dataft_Subject1.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject1.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject1);
meanRT_Subject1 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject2.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject2.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject2);
meanRT_Subject2 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject3.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject3.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject3);
meanRT_Subject3 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject4.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject4.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject4);
meanRT_Subject4 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject5.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject5.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject5);
meanRT_Subject5 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject6.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject6.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject6);
meanRT_Subject6 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject7.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject7.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject7);
meanRT_Subject7 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject8.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject8.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject8);
meanRT_Subject8 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject9.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject9.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject9);
meanRT_Subject9 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject10.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject10.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject10);
meanRT_Subject10 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject11.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject11.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject11);
meanRT_Subject11 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject12.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject12.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject12);
meanRT_Subject12 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject13.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject13.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject13);
meanRT_Subject13 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject14.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject14.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject14);
meanRT_Subject14 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject15.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject15.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject15);
meanRT_Subject15 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject16.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject16.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject16);
meanRT_Subject16 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject17.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject17.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject17);
meanRT_Subject17 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject18.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject18.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject18);
meanRT_Subject18 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject19.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject19.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject19);
meanRT_Subject19 = mean(dataft_con.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject20.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject20.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject20);
meanRT_Subject20 = mean(dataft_con.trialinfo(:,5))/1000;
end 

	else
%Subject20 commented        
for foldup = 1:1
cfg = [];
cfg.trials = find(dataft_Subject1.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject1.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject1);
meanRT_Subject1 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject2.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject2.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject2);
meanRT_Subject2 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject3.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject3.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject3);
meanRT_Subject3 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject4.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject4.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject4);
meanRT_Subject4 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject5.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject5.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject5);
meanRT_Subject5 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject6.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject6.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject6);
meanRT_Subject6 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject7.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject7.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject7);
meanRT_Subject7 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject8.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject8.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject8);
meanRT_Subject8 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject9.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject9.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject9);
meanRT_Subject9 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject10.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject10.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject10);
meanRT_Subject10 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject11.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject11.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject11);
meanRT_Subject11 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject12.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject12.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject12);
meanRT_Subject12 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject13.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject13.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject13);
meanRT_Subject13 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject14.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject14.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject14);
meanRT_Subject14 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject15.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject15.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject15);
meanRT_Subject15 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject16.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject16.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject16);
meanRT_Subject16 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject17.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject17.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject17);
meanRT_Subject17 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject18.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject18.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject18);
meanRT_Subject18 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject19.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject19.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject19);
meanRT_Subject19 = mean(dataft_incon.trialinfo(:,5))/1000;

cfg = [];
cfg.trials = find(dataft_Subject20.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject20.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject20);
meanRT_Subject20 = mean(dataft_incon.trialinfo(:,5))/1000;
end
    end
end

meanRT = (meanRT_Subject1  + meanRT_Subject2  + meanRT_Subject3  + meanRT_Subject4  + meanRT_Subject5 +...
         meanRT_Subject6  + meanRT_Subject7  + meanRT_Subject8  + meanRT_Subject9  + meanRT_Subject10 +...
         meanRT_Subject11 + meanRT_Subject12 + meanRT_Subject13 + meanRT_Subject14 + meanRT_Subject15 +...
         meanRT_Subject16 + meanRT_Subject17 + meanRT_Subject18 + meanRT_Subject19 + meanRT_Subject20)/20;

clear dataft_con dataft_incon

return;

%--------------------------------------------------------------------------
%% TSA & ERP
%--------------------------------------------------------------------------
cfg = [];
[TSA_GrandMean] = ft_timelockgrandaverage(cfg, TSA_Subject1,  TSA_Subject2,  TSA_Subject3,  TSA_Subject4,  TSA_Subject5,  TSA_Subject6,  TSA_Subject7,  TSA_Subject8,  TSA_Subject9,  TSA_Subject10,...
                                               TSA_Subject11, TSA_Subject12, TSA_Subject13, TSA_Subject14, TSA_Subject15, TSA_Subject16, TSA_Subject17, TSA_Subject18, TSA_Subject19, TSA_Subject20);
%Filtering and Baseline
cfg = [];
baselineERPEnd      = -0.2;
baselineERPStart    = 0;
cfg.demean          = 'yes';
cfg.baselinewindow  = [baselineERPEnd  baselineERPStart];
cfg.hpfilter            = 'yes';
cfg.hpfreq              = 0.1;
cfg.hpinstabilityfix    = 'reduce';
cfg.lpfilter            = 'yes';
cfg.lpfreq              = 30;
cfg.lpinstabilityfix    = 'reduce';
ERP_GrandMean           = ft_preprocessing(cfg, TSA_GrandMean);
ERP_Subject1_alltrls     = ft_preprocessing(cfg, TSA_Subject1_alltrls);
ERP_Subject2_alltrls     = ft_preprocessing(cfg, TSA_Subject2_alltrls);
ERP_Subject3_alltrls     = ft_preprocessing(cfg, TSA_Subject3_alltrls);
ERP_Subject4_alltrls     = ft_preprocessing(cfg, TSA_Subject4_alltrls);
ERP_Subject5_alltrls     = ft_preprocessing(cfg, TSA_Subject5_alltrls);
ERP_Subject6_alltrls     = ft_preprocessing(cfg, TSA_Subject6_alltrls);
ERP_Subject7_alltrls     = ft_preprocessing(cfg, TSA_Subject7_alltrls);
ERP_Subject8_alltrls     = ft_preprocessing(cfg, TSA_Subject8_alltrls);
ERP_Subject9_alltrls     = ft_preprocessing(cfg, TSA_Subject9_alltrls);
ERP_Subject10_alltrls    = ft_preprocessing(cfg, TSA_Subject10_alltrls);
ERP_Subject11_alltrls    = ft_preprocessing(cfg, TSA_Subject11_alltrls);
ERP_Subject12_alltrls    = ft_preprocessing(cfg, TSA_Subject12_alltrls);
ERP_Subject13_alltrls    = ft_preprocessing(cfg, TSA_Subject13_alltrls);
ERP_Subject14_alltrls    = ft_preprocessing(cfg, TSA_Subject14_alltrls);
ERP_Subject15_alltrls    = ft_preprocessing(cfg, TSA_Subject15_alltrls);
ERP_Subject16_alltrls    = ft_preprocessing(cfg, TSA_Subject16_alltrls);
ERP_Subject17_alltrls    = ft_preprocessing(cfg, TSA_Subject17_alltrls);
ERP_Subject18_alltrls    = ft_preprocessing(cfg, TSA_Subject18_alltrls);
ERP_Subject19_alltrls    = ft_preprocessing(cfg, TSA_Subject19_alltrls);
ERP_Subject20_alltrls    = ft_preprocessing(cfg, TSA_Subject20_alltrls);

%--------------------------------------------------------------------------
%% Plotting
%--------------------------------------------------------------------------

%max min
maxAmpl = max(TSA_GrandMean.avg(1, :));
minAmpl = min(TSA_GrandMean.avg(1, :));

% SINGLEPLOT TSA+TRIALS
    figure;
    for foldup = 1:1
        %Subject1
        for trialNumber = 1:length(TSA_Subject1_alltrls.trial(:,1,1))
            plot(TSA_Subject1_alltrls.time, TSA_Subject1_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
        %Subject2
        for trialNumber = 1:length(TSA_Subject2_alltrls.trial(:,1,1))
            plot(TSA_Subject2_alltrls.time, TSA_Subject2_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
         %Subject3
        for trialNumber = 1:length(TSA_Subject3_alltrls.trial(:,1,1))
            plot(TSA_Subject3_alltrls.time, TSA_Subject3_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
         %Subject4
        for trialNumber = 1:length(TSA_Subject4_alltrls.trial(:,1,1))
            plot(TSA_Subject4_alltrls.time, TSA_Subject4_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
        %Subject5
        for trialNumber = 1:length(TSA_Subject5_alltrls.trial(:,1,1))
            plot(TSA_Subject5_alltrls.time, TSA_Subject5_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
        %Subject6
        for trialNumber = 1:length(TSA_Subject6_alltrls.trial(:,1,1))
            plot(TSA_Subject6_alltrls.time, TSA_Subject6_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
        %Subject7
        for trialNumber = 1:length(TSA_Subject7_alltrls.trial(:,1,1))
            plot(TSA_Subject7_alltrls.time, TSA_Subject7_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
         %Subject8
        for trialNumber = 1:length(TSA_Subject8_alltrls.trial(:,1,1))
            plot(TSA_Subject8_alltrls.time, TSA_Subject8_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
         %Subject9
        for trialNumber = 1:length(TSA_Subject9_alltrls.trial(:,1,1))
            plot(TSA_Subject9_alltrls.time, TSA_Subject9_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
        %Subject10
        for trialNumber = 1:length(TSA_Subject10_alltrls.trial(:,1,1))
            plot(TSA_Subject10_alltrls.time, TSA_Subject10_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
 
        %Subject11
        for trialNumber = 1:length(TSA_Subject11_alltrls.trial(:,1,1))
            plot(TSA_Subject11_alltrls.time, TSA_Subject11_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
        %Subject12
        for trialNumber = 1:length(TSA_Subject12_alltrls.trial(:,1,1))
            plot(TSA_Subject12_alltrls.time, TSA_Subject12_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
         %Subject13
        for trialNumber = 1:length(TSA_Subject13_alltrls.trial(:,1,1))
            plot(TSA_Subject13_alltrls.time, TSA_Subject13_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
         %Subject14
        for trialNumber = 1:length(TSA_Subject14_alltrls.trial(:,1,1))
            plot(TSA_Subject14_alltrls.time, TSA_Subject14_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
        %Subject15
        for trialNumber = 1:length(TSA_Subject15_alltrls.trial(:,1,1))
            plot(TSA_Subject15_alltrls.time, TSA_Subject15_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
        %Subject16
        for trialNumber = 1:length(TSA_Subject16_alltrls.trial(:,1,1))
            plot(TSA_Subject16_alltrls.time, TSA_Subject16_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
        %Subject17
        for trialNumber = 1:length(TSA_Subject17_alltrls.trial(:,1,1))
            plot(TSA_Subject17_alltrls.time, TSA_Subject17_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
         %Subject18
        for trialNumber = 1:length(TSA_Subject18_alltrls.trial(:,1,1))
            plot(TSA_Subject18_alltrls.time, TSA_Subject18_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
         %Subject19
        for trialNumber = 1:length(TSA_Subject19_alltrls.trial(:,1,1))
            plot(TSA_Subject19_alltrls.time, TSA_Subject19_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
        %Subject20
        for trialNumber = 1:length(TSA_Subject20_alltrls.trial(:,1,1))
            plot(TSA_Subject20_alltrls.time, TSA_Subject20_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    end    
    plot(TSA_GrandMean.time, TSA_GrandMean.avg(1, :),'b', 'LineWidth', 2); % ERP-Plotting
    title(['TSA ' group ' ' task]);
    xlabel('Time [s]');
    ylabel('Amplitude [uV]      ');
    set(get(gca,'ylabel'), 'Rotation',0,'VerticalAlignment','top', 'HorizontalAlignment','right');
    xlim([prestimOffset poststimOffset]); %From Prestimulus until Poststimulus, please check Segmentation step
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    ax.Layer = 'top';  
    xl1 = xline(meanRT,'_','Mean RT','LabelHorizontalAlignment','right');
    xl1.FontSize = 9;  
 
% SINGLEPLOT TSA
    figure;
    plot(TSA_GrandMean.time, TSA_GrandMean.avg(1, :),'b', 'LineWidth', 1); % ERP-Plotting
    title(['TSA ' group ' ' task]);
    xlabel('Time [s]');
    ylabel('Amplitude [uV]      ');
    set(get(gca,'ylabel'), 'Rotation',0,'VerticalAlignment','top', 'HorizontalAlignment','right');
    xlim([prestimOffset poststimOffset]); %From Prestimulus until Poststimulus, please check Segmentation step
    ylim([minAmpl-1 maxAmpl+1]);     
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    ax.Layer = 'top';  
    xl1 = xline(meanRT,'_','Mean RT','LabelHorizontalAlignment','right');
    xl1.FontSize = 9;  

% SINGLEPLOT ERP+TRIALS
    figure;
    for foldup = 1:1
        %Subject1
        for trialNumber = 1:length(ERP_Subject1_alltrls.trial(:,1,1))
            plot(ERP_Subject1_alltrls.time, ERP_Subject1_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
        %Subject2
        for trialNumber = 1:length(ERP_Subject2_alltrls.trial(:,1,1))
            plot(ERP_Subject2_alltrls.time, ERP_Subject2_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
         %Subject3
        for trialNumber = 1:length(ERP_Subject3_alltrls.trial(:,1,1))
            plot(ERP_Subject3_alltrls.time, ERP_Subject3_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
         %Subject4
        for trialNumber = 1:length(ERP_Subject4_alltrls.trial(:,1,1))
            plot(ERP_Subject4_alltrls.time, ERP_Subject4_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
        %Subject5
        for trialNumber = 1:length(ERP_Subject5_alltrls.trial(:,1,1))
            plot(ERP_Subject5_alltrls.time, ERP_Subject5_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
        %Subject6
        for trialNumber = 1:length(ERP_Subject6_alltrls.trial(:,1,1))
            plot(ERP_Subject6_alltrls.time, ERP_Subject6_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
        %Subject7
        for trialNumber = 1:length(ERP_Subject7_alltrls.trial(:,1,1))
            plot(ERP_Subject7_alltrls.time, ERP_Subject7_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
         %Subject8
        for trialNumber = 1:length(ERP_Subject8_alltrls.trial(:,1,1))
            plot(ERP_Subject8_alltrls.time, ERP_Subject8_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
         %Subject9
        for trialNumber = 1:length(ERP_Subject9_alltrls.trial(:,1,1))
            plot(ERP_Subject9_alltrls.time, ERP_Subject9_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
        %Subject10
        for trialNumber = 1:length(ERP_Subject10_alltrls.trial(:,1,1))
            plot(ERP_Subject10_alltrls.time, ERP_Subject10_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
 
        %Subject11
        for trialNumber = 1:length(ERP_Subject11_alltrls.trial(:,1,1))
            plot(ERP_Subject11_alltrls.time, ERP_Subject11_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
        %Subject12
        for trialNumber = 1:length(ERP_Subject12_alltrls.trial(:,1,1))
            plot(ERP_Subject12_alltrls.time, ERP_Subject12_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
         %Subject13
        for trialNumber = 1:length(ERP_Subject13_alltrls.trial(:,1,1))
            plot(ERP_Subject13_alltrls.time, ERP_Subject13_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
         %Subject14
        for trialNumber = 1:length(ERP_Subject14_alltrls.trial(:,1,1))
            plot(ERP_Subject14_alltrls.time, ERP_Subject14_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
        %Subject15
        for trialNumber = 1:length(ERP_Subject15_alltrls.trial(:,1,1))
            plot(ERP_Subject15_alltrls.time, ERP_Subject15_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
        %Subject16
        for trialNumber = 1:length(ERP_Subject16_alltrls.trial(:,1,1))
            plot(ERP_Subject16_alltrls.time, ERP_Subject16_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
        %Subject17
        for trialNumber = 1:length(ERP_Subject17_alltrls.trial(:,1,1))
            plot(ERP_Subject17_alltrls.time, ERP_Subject17_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
         %Subject18
        for trialNumber = 1:length(ERP_Subject18_alltrls.trial(:,1,1))
            plot(ERP_Subject18_alltrls.time, ERP_Subject18_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    
         %Subject19
        for trialNumber = 1:length(ERP_Subject19_alltrls.trial(:,1,1))
            plot(ERP_Subject19_alltrls.time, ERP_Subject19_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
        
        %Subject20
        for trialNumber = 1:length(ERP_Subject20_alltrls.trial(:,1,1))
            plot(ERP_Subject20_alltrls.time, ERP_Subject20_alltrls.trial(trialNumber, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
            hold on;
        end
    end
    plot(ERP_GrandMean.time, ERP_GrandMean.avg(1, :),'b', 'LineWidth', 2); % ERP-Plotting
    title(['ERP ' group ' ' task]);
    xlabel('Time [s]');
    ylabel('Amplitude [uV]      ');
    set(get(gca,'ylabel'), 'Rotation',0,'VerticalAlignment','top', 'HorizontalAlignment','right');
    xlim([prestimOffset poststimOffset]); %From Prestimulus until Poststimulus, please check Segmentation step
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    ax.Layer = 'top';  
    xl1 = xline(meanRT,'_','Mean RT','LabelHorizontalAlignment','right');
    xl1.FontSize = 9;      
    
% SINGLEPLOT ERP   
    figure;
    plot(ERP_GrandMean.time, ERP_GrandMean.avg(1, :),'b', 'LineWidth', 1); % ERP-Plotting
    title(['ERP ' group ' ' task]);
    xlabel('Time [s]');
    ylabel('Amplitude [uV]      ');
    set(get(gca,'ylabel'), 'Rotation',0,'VerticalAlignment','top', 'HorizontalAlignment','right');
    xlim([prestimOffset poststimOffset]); %From Prestimulus until Poststimulus, please check Segmentation step
    ylim([minAmpl-1 maxAmpl+1]); 
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    ax.Layer = 'top';  
    xl1 = xline(meanRT,'_','Mean RT','LabelHorizontalAlignment','right');
    xl1.FontSize = 9;  

end

%Topoplot
% TOPOPLOT N1
cfg = [];
cfg.xlim = [0.02 0.12];
cfg.zlim = [-4 4];
cfg.layout = 'eeg1010.lay';
cfg.marker = 'off';
figure; 
ft_topoplotER(cfg,ERP_GrandMean); colorbar

% % TOPOPLOT P3
% cfg = [];
% cfg.xlim = [0.2 0.4];
% cfg.zlim = [-10 10];
% cfg.layout = 'eeg1010.lay';
% figure; 
% ft_topoplotER(cfg,ERP_GrandMean); colorbar
