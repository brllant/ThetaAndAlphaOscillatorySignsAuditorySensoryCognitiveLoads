% Time Frequency Analysis - Channels ROI
% Created: Hannover, 5.2.2021
% Updated: 6.9.2021
% Uploaded: 7.9.2023
% Brilliant - VIANNA/MHH

%--------------------------------------------------------------------------
%% DATA I/O
%--------------------------------------------------------------------------
subject                 = 'XXX00';
preprocessedDataName 	= 'dataft_preprocessed_TFR';
NoiseInd = 1; %NoiseInd: 1: In Quiet - 2: In Noise

for ROIMODE = 1:3 
  %ROIMODE                 = 1; %ROIMoide: 1: Frontal, 2: Central, %3: Parietal, %4: Occipital
  
datum                   = '210909';
task                    = 'Vowel Identification';
taskShort               = 'VI';
group                   = 'NHYoung';

if NoiseInd == 1
    condDataFolder = 'VIQuiet';
else if NoiseInd == 2
        condDataFolder = 'VINoise';
    end
end

if NoiseInd == 1
    noiseInfo = 'in Quiet';
    noiseInfoShort = 'Quiet';
else if NoiseInd == 2
        noiseInfo = 'in Noise';
        noiseInfoShort = 'Noise';
    end
end

preprocessedDataFolder	= ['D:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\' taskShort '\' group '\' subject '\' condDataFolder '\Preprocessing\Data\'];

switch ROIMODE
    case 1
        outputDataFolder        = ['D:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\' taskShort '\' group '\' subject '\' condDataFolder '\TFR\ROI\Data\Frontal\'];
        mkdir(outputDataFolder);
    case 2
        outputDataFolder        = ['D:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\' taskShort '\' group '\' subject '\' condDataFolder '\TFR\ROI\Data\Central\'];
        mkdir(outputDataFolder);
    case 3
        outputDataFolder        = ['D:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\' taskShort '\' group '\' subject '\' condDataFolder '\TFR\ROI\Data\Parietal\'];
        mkdir(outputDataFolder);
    case 4
        outputDataFolder        = ['D:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\' taskShort '\' group '\' subject '\' condDataFolder '\TFR\ROI\Data\Occipital\'];
        mkdir(outputDataFolder);
end

switch ROIMODE
    case 1
        outputPlotFolder        = ['D:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\' taskShort '\' group '\' subject '\' condDataFolder '\TFR\ROI\Plot\Frontal\'];
        mkdir(outputPlotFolder);
    case 2
        outputPlotFolder        = ['D:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\' taskShort '\' group '\' subject '\' condDataFolder '\TFR\ROI\Plot\Central\'];
        mkdir(outputPlotFolder);
    case 3
        outputPlotFolder        = ['D:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\' taskShort '\' group '\' subject '\' condDataFolder '\TFR\ROI\Plot\Parietal\'];
        mkdir(outputPlotFolder);
    case 4
        outputPlotFolder        = ['D:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\' taskShort '\' group '\' subject '\' condDataFolder '\TFR\ROI\Plot\Occipital\'];
        mkdir(outputPlotFolder);
end

load ([preprocessedDataFolder preprocessedDataName], '-mat' );
dataft_aktuell = dataft_preprocessed_TFR;

meanRT = mean(dataft_aktuell.trialinfo(:,5))/1000;

%% DOWNSAMPLING dataft_aktuell
cfg = [];
cfg.resamplefs = 500;
dataft_aktuell = ft_resampledata(cfg, dataft_aktuell);  

%% POOLING CHANNELS ALS ROI
for foldup = 1:1
    
cfg = [];

switch ROIMODE
    case 1
        %Frontal Electrodes
        pooledChannel1 = 'F1';
        cfg.channel = pooledChannel1;
        dataft_frontal1 = ft_selectdata(cfg, dataft_aktuell);
        dataft_frontal1.label = {'frontalChannels'};
        pooledChannel2 = 'F2';
        cfg.channel = pooledChannel2;
        dataft_frontal2 = ft_selectdata(cfg, dataft_aktuell);
        dataft_frontal2.label = {'frontalChannels'};
        pooledChannel3 = 'Fz';
        cfg.channel = pooledChannel3;
        dataft_frontal3 = ft_selectdata(cfg, dataft_aktuell);
        dataft_frontal3.label = {'frontalChannels'};
        pooledChannel4 = 'FCz';
        cfg.channel = pooledChannel4;
        dataft_frontal4 = ft_selectdata(cfg, dataft_aktuell);
        dataft_frontal4.label = {'frontalChannels'};

        dataft_frontal = dataft_frontal1;

        dataft_frontal.trialinfo     = [dataft_frontal1.trialinfo; dataft_frontal2.trialinfo; ...
                                        dataft_frontal3.trialinfo; dataft_frontal4.trialinfo];
        dataft_frontal.trial         = [dataft_frontal1.trial, dataft_frontal2.trial, ...
                                        dataft_frontal3.trial, dataft_frontal4.trial];
        dataft_frontal.time          = [dataft_frontal1.time, dataft_frontal2.time, ...
                                        dataft_frontal3.time, dataft_frontal4.time];                             
                                    
        dataft_aktuell = dataft_frontal;
            channelName = 'Frontal'; 
            %channelName = ['Frontal (' pooledChannel1 ' ,' pooledChannel2 ' ,' pooledChannel3 ' ,' pooledChannel4 ')'];
            channelIndex = 1;
     
%---

    case 2  
        %Central Electrodes
        pooledChannel1 = 'C1';
        cfg.channel = pooledChannel1;
        dataft_central1 = ft_selectdata(cfg, dataft_aktuell);
        dataft_central1.label = {'centralChannels'};
        pooledChannel2 = 'C2';
        cfg.channel = pooledChannel2;
        dataft_central2 = ft_selectdata(cfg, dataft_aktuell);
        dataft_central2.label = {'centralChannels'};
        pooledChannel3 = 'Cz';
        cfg.channel = pooledChannel3;
        dataft_central3 = ft_selectdata(cfg, dataft_aktuell);
        dataft_central3.label = {'centralChannels'};
        pooledChannel4 = 'CPz';
        cfg.channel = pooledChannel4;
        dataft_central4 = ft_selectdata(cfg, dataft_aktuell);
        dataft_central4.label = {'centralChannels'};

        dataft_central = dataft_central1;

        dataft_central.trialinfo     = [dataft_central1.trialinfo; dataft_central2.trialinfo; ...
                                        dataft_central3.trialinfo; dataft_central4.trialinfo];
        dataft_central.trial         = [dataft_central1.trial, dataft_central2.trial, ...
                                        dataft_central3.trial, dataft_central4.trial];
        dataft_central.time          = [dataft_central1.time, dataft_central2.time, ...
                                        dataft_central3.time, dataft_central4.time];

        dataft_aktuell = dataft_central;

            channelName = 'Central';
            %channelName = ['Central (' pooledChannel1 ' ,' pooledChannel2 ' ,' pooledChannel3 ' ,' pooledChannel4 ' ,' pooledChannel5 ' ,' pooledChannel6 ')'];
            channelIndex = 1;

%---

    case 3
        %Parietal Electrodes
        pooledChannel1 = 'P1';
        cfg.channel = pooledChannel1;
        dataft_parietal1 = ft_selectdata(cfg, dataft_aktuell);
        dataft_parietal1.label = {'parietalChannels'};
        pooledChannel2 = 'P2';
        cfg.channel = pooledChannel2;
        dataft_parietal2 = ft_selectdata(cfg, dataft_aktuell);
        dataft_parietal2.label = {'parietalChannels'};
        pooledChannel3 = 'Pz';
        cfg.channel = pooledChannel3;
        dataft_parietal3 = ft_selectdata(cfg, dataft_aktuell);
        dataft_parietal3.label = {'parietalChannels'};
        pooledChannel4 = 'POz';
        cfg.channel = pooledChannel4;
        dataft_parietal4 = ft_selectdata(cfg, dataft_aktuell);
        dataft_parietal4.label = {'parietalChannels'};

        dataft_parietal = dataft_parietal1;

        dataft_parietal.trialinfo     = [dataft_parietal1.trialinfo; dataft_parietal2.trialinfo; ...
                                        dataft_parietal3.trialinfo; dataft_parietal4.trialinfo];
        dataft_parietal.trial         = [dataft_parietal1.trial, dataft_parietal2.trial, ...
                                        dataft_parietal3.trial, dataft_parietal4.trial];
        dataft_parietal.time          = [dataft_parietal1.time, dataft_parietal2.time, ...
                                        dataft_parietal3.time, dataft_parietal4.time];

        dataft_aktuell = dataft_parietal;

            channelName = 'Parietal';
            %channelName = ['Parietal (' pooledChannel1 ' ,' pooledChannel2 ' ,' pooledChannel3 ' ,' pooledChannel4 ' ,' pooledChannel5 ' ,' pooledChannel6 ')'];
            channelIndex = 1;
        
%---

    case 4
        %Occipital Electrodes
        pooledChannel1 = 'O1';
        cfg.channel = pooledChannel1;
        dataft_occipital1 = ft_selectdata(cfg, dataft_aktuell);
        dataft_occipital1.label = {'occipitalChannels'};
        pooledChannel2 = 'O2';
        cfg.channel = pooledChannel2;
        dataft_occipital2 = ft_selectdata(cfg, dataft_aktuell);
        dataft_occipital2.label = {'occipitalChannels'};
        pooledChannel3 = 'Oz';
        cfg.channel = pooledChannel3;
        dataft_occipital3 = ft_selectdata(cfg, dataft_aktuell);
        dataft_occipital3.label = {'occipitalChannels'};
        pooledChannel4 = 'POz';
        cfg.channel = pooledChannel4;
        dataft_occipital4 = ft_selectdata(cfg, dataft_aktuell);
        dataft_occipital4.label = {'occipitalChannels'};

        dataft_occipital = dataft_occipital1;

        dataft_occipital.trialinfo     = [dataft_occipital1.trialinfo; dataft_occipital2.trialinfo; ...
                                        dataft_occipital3.trialinfo; dataft_occipital4.trialinfo];
        dataft_occipital.trial         = [dataft_occipital1.trial, dataft_occipital2.trial, ...
                                        dataft_occipital3.trial, dataft_occipital4.trial];
        dataft_occipital.time          = [dataft_occipital1.time, dataft_occipital2.time, ...
                                        dataft_occipital3.time, dataft_occipital4.time];

        dataft_aktuell = dataft_occipital;
            
            channelName = 'Occipital';
            %channelName = ['Occipital (' pooledChannel1 ' ,' pooledChannel2 ' ,' pooledChannel3 ' ,' pooledChannel4 ' ,' pooledChannel5 ' ,' pooledChannel6 ')'];
            channelIndex = 1;
 
%--------------------------------------------------------------------------
%% TSA
%--------------------------------------------------------------------------
% TSA Parameter
prestimOffset   = -1; % in seconds
poststimOffset  = 2;  % in seconds
cfg = [];
cfg.keeptrials  = 'yes';
cfg.trials      = 'all';
cfg.channel = 'all';

% TSA_alltrls Calculation
TSA_VI_alltrls = ft_timelockanalysis(cfg, dataft_aktuell);

% TSA_avg Calculation
cfg = [];
TSA_VI_avg = ft_timelockanalysis(cfg, TSA_VI_alltrls);

%TSA Plotting
% Topoplot
% cfg = [];
% cfg.layout      = 'eeg1010.lay';
% cfg.baseline    = 'no'; %already done in Step 4
% 
% % TOPOPLOT TSA VI
% ft_topoplotER(cfg, TSA_VI); 
% title(['TSA Topoplot: ' subject ', ' task '-' noiseInfo]);

% Singleplot
% SINGLEPLOT GESAMT OF A CHANNEL TSA+TRIALS
    figure;
    for trial = 1:length(dataft_aktuell.trial)
        plot(dataft_aktuell.time{trial}, dataft_aktuell.trial{trial}(channelIndex, :), 'Color',[0.65 0.65 0.65], 'LineWidth', 0.25); % The higher the color index, the lighter is the grey
        hold on;
    end
    plot(TSA_VI_avg.time, TSA_VI_avg.avg(channelIndex, :),'b', 'LineWidth', 0.75); % TSA-Plotting
    title(['TSA and Trials: ' subject ', ' task '-' noiseInfo ', ' channelName]);
    xlabel('Time [s]');
    ylabel('Amplitude [uV]');
    xlim([prestimOffset poststimOffset]); %From Prestimulus until Poststimulus, please check Segmentation step
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    ax.Layer = 'top';
    xl1 = xline(meanRT,'-','Mean RT','LabelHorizontalAlignment','right');
    xl1.FontSize = 9;  
    hold off;   
    
% SINGLEPLOT OF A CHANNEL ONLY TSA
    figure;
    plot(TSA_VI_avg.time, TSA_VI_avg.avg(channelIndex, :),'b'); % TSA-Plotting
    title(['TSA: ' subject ', ' task '-' noiseInfo ', ' channelName]);
    xlabel('Time [s]');
    ylabel('Amplitude [uV]');
    xlim([prestimOffset poststimOffset]); %From Prestimulus until Poststimulus, please check Segmentation step
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    ax.Layer = 'top';
    xl1 = xline(meanRT,'-','Mean RT','LabelHorizontalAlignment','right');
    xl1.FontSize = 9;  

%--------------------------------------------------------------------------
%% WAVELET Time Frequency Analysis
%--------------------------------------------------------------------------
% Crucial parameter to set is cfg.width. 
% It determines the width of the wavelets in number of cycles. 
% Making the value smaller will increase the temporal resolution at the expense of frequency resolution and vice versa. 
% The spectral bandwidth at a given frequency F is equal to F/width * 2 (so, at 30 Hz and a width of 7, the spectral bandwidth is 30/7 * 2 = 8.6 Hz) 
% while the wavelet duration is equal to width/F/pi (in this case, 7/30/pi = 0.074s = 74ms) 
% (Tallon-Baudry & Bertrand, 1999).

%TFR Parameter
timeBinSize = 0.002; %2 ms/bin

cfg = [];
cfg.method     = 'wavelet';
cfg.output     = 'pow';
cfg.width      = 6;
% The standard deviation in the frequency domain (sf) at frequency f0 is defined as: sf = f0/width
% The standard deviation in the temporal domain (st) at frequency f0 is defined as: st = 1/(2*pi*sf)

foiLow          = 1;
foiHigh         = 128;
cfg.foi         = foiLow:1:foiHigh;
cfg.toi         = prestimOffset:timeBinSize:poststimOffset;   
baselineTFREnd      = -0.8;
baselineTFRStart    = -0.2;
cfg.baseline        = [baselineTFREnd baselineTFRStart];
cfg.baselinetype    = 'db';
cfg.keeptrials  = 'yes';
cfg.trials      = 'all';
cfg.channel     = 'all';
end
TFR_VI_alltrls = ft_freqanalysis(cfg, dataft_aktuell);

cfg.keeptrials  = 'no';
cfg.trials      = 'all';
cfg.channel     = 'all';
TFR_VI_avg = ft_freqdescriptives(cfg, TFR_VI_alltrls);

%TFR Plotting
for foldup = 1:1
baselineTFREnd      = -0.8;
baselineTFRStart    = -0.2;
cfg = [];
cfg.baselinetype = 'db';
cfg.colorbartext = strcat('Power [dB re Baseline: ' , '(', num2str(baselineTFREnd), 's)', ' - ',  '(', num2str(baselineTFRStart), 's)', ']');
zInfo = 'dB';
cfg.baseline        = [baselineTFREnd baselineTFRStart];
cfg.showlabels      = 'yes';
cfg.colorbar        = 'yes';
cfg.xlim            = [prestimOffset poststimOffset];    % specified in seconds
cfg.ylim            = [foiLow foiHigh];     
cfg.zlim            = [-4 4];%[-Inf Inf]; %'maxabs';
cfg.channel         = channelName;

ft_singleplotTFR(cfg, TFR_VI_avg); 
title(['TFR: ' subject ', ' task '-' noiseInfo ', ' channelName ', ' zInfo]);
colormap(jet(64));
xlabel('Time [s]');
ylabel('Frequency [Hz]');
xticks(-1:0.2:2); 
yticks([2 4 8 13 20 30 35 50 65 80 95 110 125])
ax = gca;
ax.YAxis.FontSize = 8;
ax.XAxis.FontSize = 8;
yl1 = yline (2,':'); 
yl2 = yline (4,':'); 
yl3 = yline (8,':'); 
yl4 = yline(13,':');
yl5 = yline(30,':'); 
xline (0);
xl1 = xline(baselineTFREnd,'--','Baseline','LabelHorizontalAlignment','right');
xl1.FontSize = 9;
xl2 = xline(baselineTFRStart,'--');

% TFR Logarithmic Plot
cfg = [];
cfg.baselinetype = 'db';
colorbartext = strcat('Power [dB re Baseline: ' , '(', num2str(baselineTFREnd), 's)', ' - ',  '(', num2str(baselineTFRStart), 's)', ']');
zInfo = 'dB';
cfg.baseline = [baselineTFREnd baselineTFRStart];
TFR_imagesc  = ft_freqbaseline(cfg, TFR_VI_avg);
meanPow_TFR  = squeeze(mean(TFR_imagesc.powspctrm(channelIndex,:,:), 1));

figure;
imagesc(TFR_VI_avg.time, TFR_VI_avg.freq, meanPow_TFR);
xlim([prestimOffset poststimOffset]);
ylim([foiLow foiHigh]);
caxis([-4 4]);
axis xy; 
xlabel('Time [s]');
ylabel('Frequency [Hz]');
colorbar; colormap(jet(64));
fig = gcf;
figHandle       = get(gca,'Children');
timeBin         = get(figHandle, 'XData');
freqBin     	= get(figHandle, 'YData');
powerBin(:,:)	= get(figHandle, 'CData'); %freqXtime
close(gcf);
   
%---

timeBinIntrp = timeBin;
freqBinIntrp = freqBin;
powerIntrp   = powerBin;
lowestYlimLog = 2;

    figure;
    contourf(timeBinIntrp, freqBinIntrp, powerIntrp,64,'linestyle','none');
    xlim([prestimOffset poststimOffset]);
    ylim([lowestYlimLog foiHigh]);
    caxis([-4 4]);
    axis xy; 
    c = colorbar; c.Label.String = colorbartext; colormap(jet(64));
    xlabel('Time [s]');
    ylabel('Frequency [Hz]');
    title(['TFR: ' subject ', ' task '-' noiseInfo ', ' channelName ', ' zInfo]);
    set(gca,'yscale','log','ytick',[2 4 8 13 20 25 30 50 75 100 125]);
    yl2 = yline (4,':'); 
    yl3 = yline (8,':'); 
    yl4 = yline(13,':');
    yl5 = yline(30,':'); 
    xline (0);
    xl1 = xline(baselineTFREnd,'--','Baseline','LabelHorizontalAlignment','right');
    xl1.FontSize = 9;
    xl2 = xline(baselineTFRStart,'--');
    xl3 = xline(meanRT,'-','Mean RT','LabelHorizontalAlignment','right');
    xl3.FontSize = 9;    
    hold on;   
    yyaxis right;
    plot(TSA_VI_avg.time, ((TSA_VI_avg.avg(channelIndex, :))), 'Color',[0,0.5,0.9], 'LineWidth',0.5);%*1.35)+13,'b'); % TSA-Plotting
    ylim ([-25 25]);
    hold off;
