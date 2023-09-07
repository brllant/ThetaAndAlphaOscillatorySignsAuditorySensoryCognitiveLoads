% FieldTrip Beamforming Source Localization
% Stroop Task
% Hannover, 13.7.2021
% Edited: 3.3.2023
% Brilliant
% VIANNA

%https://www.fieldtriptoolbox.org/tutorial/beamformer/
%https://www.fieldtriptoolbox.org/tutorial/headmodel_eeg_bem/
%https://www.fieldtriptoolbox.org/workshop/natmeg/beamforming/#eeg-the-forward-model-and-lead-field-matrix
%https://www.fieldtriptoolbox.org/tutorial/minimumnormestimate/
%https://www.fieldtriptoolbox.org/example/make_leadfields_using_different_headmodels/
%https://www.fieldtriptoolbox.org/workshop/oslo2019/forward_modeling/

load ('J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Data\RedBlueTFR0p5.mat');

%% PART I: FORWARD MODEL and LEAD FIELD MATRIX

%https://www.fieldtriptoolbox.org/workshop/oslo2019/forward_modeling/
% Four components of a forward model:
% 1. Head model
% 2. Sensor description
% 3. Source model
% 4. Lead field

%--------------------------------------------------------------------------

% Load Brain, Skull and Scalp
for foldup = 1:1
% load standard_bem.mat; %Loading generic model Standard BEM
%     load segmentedmri.mat; %Loading segmented MRI
% 
%     cfg =[];
%     cfg.tissue ={'brain','skull','scalp'};
%     cfg.numvertices = [3000 2000 1000];
%     bnd = ft_prepare_mesh(cfg,segmentedmri);
%     
%     cfg  = [];
%     cfg.method = 'openmeeg'; % You can also specify 'openmeeg', 'bemcp', or 'dipoli'.
%     vol = ft_prepare_headmodel(cfg, bnd);
% 
% mesh_brain = vol.bnd(3);
% mesh_skull = vol.bnd(2);
% mesh_scalp = vol.bnd(1);
% 
% cfg = [];
% cfg.interactive = 'yes';
% vol_coordinate = ft_determine_coordsys(vol);
% 
% figure;
% ft_plot_mesh(mesh_brain, 'edgecolor', 'none', 'facecolor', 'r');
% ft_plot_mesh(mesh_skull, 'edgecolor', 'none', 'facecolor', 'g');
% ft_plot_mesh(mesh_scalp, 'edgecolor', 'none', 'facecolor', 'b');
% alpha 0.3;
% view(135, 15);
%  
% mesh_eeg = [mesh_brain mesh_skull mesh_scalp];
% 
% %--------------------------------------------------------------------------
% 
% % Prepare Headmodel (Component 1)
% 
% cfg              = [];
% cfg.method       = 'openmeeg';
% cfg.conductivity = [1 1/80 1]*(1/3); % S/m
% headmodel_openmeeg = ft_prepare_headmodel(cfg, mesh_eeg);
% headmodel_openmeeg = ft_convert_units(headmodel_openmeeg, 'cm'); 
% headmodel = headmodel_openmeeg;
% 
% ft_plot_headmodel(headmodel, 'facealpha', 0.5);
% view(90, 0);
end

load mesh_brain_Brainnetome.mat
load mesh_skull_Brainnetome.mat
load mesh_scalp_Brainnetome.mat
load mesh_eeg_Brainnetome.mat
load headmodel_Brainnetome.mat

%--------------------------------------------------------------------------

% % Load Sensor (Component 2)

% elec = ft_read_sens('standard_1020.elc');

% Electrode Position edited for IL
for foldup = 1:1
% elecEdited = elec;
% elecEdited.label = [elec.label(4:6); elec.label(19); elec.label(21); elec.label(23); elec.label(25); elec.label(27); elec.label(90); elec.label(43);... &1-10
%                     elec.label(45); elec.label(47); elec.label(92); elec.label(91); elec.label(65); elec.label(67); elec.label(69); elec.label(93); elec.label(84); elec.label(85);... &11-20
%                     elec.label(86); elec.label(31); elec.label(33); elec.label(35); elec.label(37); elec.label(52); elec.label(53); elec.label(55); elec.label(57); elec.label(59);... %21-30
%                     elec.label(60); elec.label(54); elec.label(58); elec.label(22); elec.label(24); elec.label(20); elec.label(44); elec.label(32); elec.label(14); elec.label(66);... %31-40
%                     elec.label(68); elec.label(74); elec.label(34); elec.label(46); elec.label(82); elec.label(79); elec.label(42); elec.label(56); elec.label(78); elec.label(77);... %41-50
%                     elec.label(10); elec.label(36); elec.label(76); elec.label(80); elec.label(26); elec.label(70); elec.label(64); elec.label(48)]; %51-58;
% 
% elecEdited.chanunit = [elec.chanunit(4:6); elec.chanunit(19); elec.chanunit(21); elec.chanunit(23); elec.chanunit(25); elec.chanunit(27); elec.chanunit(90); elec.chanunit(43);... &1-10
%                        elec.chanunit(45); elec.chanunit(47); elec.chanunit(92); elec.chanunit(91); elec.chanunit(65); elec.chanunit(67); elec.chanunit(69); elec.chanunit(93); elec.chanunit(84); elec.chanunit(85);... &11-20
%                        elec.chanunit(86); elec.chanunit(31); elec.chanunit(33); elec.chanunit(35); elec.chanunit(37); elec.chanunit(52); elec.chanunit(53); elec.chanunit(55); elec.chanunit(57); elec.chanunit(59);... %21-30
%                        elec.chanunit(60); elec.chanunit(54); elec.chanunit(58); elec.chanunit(22); elec.chanunit(24); elec.chanunit(20); elec.chanunit(44); elec.chanunit(32); elec.chanunit(14); elec.chanunit(66);... %31-40
%                        elec.chanunit(68); elec.chanunit(74); elec.chanunit(34); elec.chanunit(46); elec.chanunit(82); elec.chanunit(79); elec.chanunit(42); elec.chanunit(56); elec.chanunit(78); elec.chanunit(77);... %41-50
%                        elec.chanunit(10); elec.chanunit(36); elec.chanunit(76); elec.chanunit(80); elec.chanunit(26); elec.chanunit(70); elec.chanunit(64); elec.chanunit(48)]; %51-58;
% 
% elecEdited.chantype = [elec.chantype(4:6); elec.chantype(19); elec.chantype(21); elec.chantype(23); elec.chantype(25); elec.chantype(27); elec.chantype(90); elec.chantype(43);... &1-10
%                        elec.chantype(45); elec.chantype(47); elec.chantype(92); elec.chantype(91); elec.chantype(65); elec.chantype(67); elec.chantype(69); elec.chantype(93); elec.chantype(84); elec.chantype(85);... &11-20
%                        elec.chantype(86); elec.chantype(31); elec.chantype(33); elec.chantype(35); elec.chantype(37); elec.chantype(52); elec.chantype(53); elec.chantype(55); elec.chantype(57); elec.chantype(59);... %21-30
%                        elec.chantype(60); elec.chantype(54); elec.chantype(58); elec.chantype(22); elec.chantype(24); elec.chantype(20); elec.chantype(44); elec.chantype(32); elec.chantype(14); elec.chantype(66);... %31-40
%                        elec.chantype(68); elec.chantype(74); elec.chantype(34); elec.chantype(46); elec.chantype(82); elec.chantype(79); elec.chantype(42); elec.chantype(56); elec.chantype(78); elec.chantype(77);... %41-50
%                        elec.chantype(10); elec.chantype(36); elec.chantype(76); elec.chantype(80); elec.chantype(26); elec.chantype(70); elec.chantype(64); elec.chantype(48)]; %51-58;
%  
% elecEdited.chanpos = [elec.chanpos(4,:,:); elec.chanpos(5,:,:); elec.chanpos(6,:,:); elec.chanpos(19,:,:); elec.chanpos(21,:,:); elec.chanpos(23,:,:); elec.chanpos(25,:,:); elec.chanpos(27,:,:); elec.chanpos(90,:,:); elec.chanpos(43,:,:);... &1-10
%                       elec.chanpos(45,:,:); elec.chanpos(47,:,:); elec.chanpos(92,:,:); elec.chanpos(91,:,:); elec.chanpos(65,:,:); elec.chanpos(67,:,:); elec.chanpos(69,:,:); elec.chanpos(93,:,:); elec.chanpos(84,:,:); elec.chanpos(85,:,:);... &11-20
%                       elec.chanpos(86,:,:); elec.chanpos(31,:,:); elec.chanpos(33,:,:); elec.chanpos(35,:,:); elec.chanpos(37,:,:); elec.chanpos(52,:,:); elec.chanpos(53,:,:); elec.chanpos(55,:,:); elec.chanpos(57,:,:); elec.chanpos(59,:,:);... %21-30
%                       elec.chanpos(60,:,:); elec.chanpos(54,:,:); elec.chanpos(58,:,:); elec.chanpos(22,:,:); elec.chanpos(24,:,:); elec.chanpos(20,:,:); elec.chanpos(44,:,:); elec.chanpos(32,:,:); elec.chanpos(14,:,:); elec.chanpos(66,:,:);... %31-40
%                       elec.chanpos(68,:,:); elec.chanpos(74,:,:); elec.chanpos(34,:,:); elec.chanpos(46,:,:); elec.chanpos(82,:,:); elec.chanpos(79,:,:); elec.chanpos(42,:,:); elec.chanpos(56,:,:); elec.chanpos(78,:,:); elec.chanpos(77,:,:);... %41-50
%                       elec.chanpos(10,:,:); elec.chanpos(36,:,:); elec.chanpos(76,:,:); elec.chanpos(80,:,:); elec.chanpos(26,:,:); elec.chanpos(70,:,:); elec.chanpos(64,:,:); elec.chanpos(48,:,:)];
% 
% elecEdited.elecpos = [elec.elecpos(4,:,:); elec.elecpos(5,:,:); elec.elecpos(6,:,:); elec.elecpos(19,:,:); elec.elecpos(21,:,:); elec.elecpos(23,:,:); elec.elecpos(25,:,:); elec.elecpos(27,:,:); elec.elecpos(90,:,:); elec.elecpos(43,:,:);... &1-10
%                       elec.elecpos(45,:,:); elec.elecpos(47,:,:); elec.elecpos(92,:,:); elec.elecpos(91,:,:); elec.elecpos(65,:,:); elec.elecpos(67,:,:); elec.elecpos(69,:,:); elec.elecpos(93,:,:); elec.elecpos(84,:,:); elec.elecpos(85,:,:);... &11-20
%                       elec.elecpos(86,:,:); elec.elecpos(31,:,:); elec.elecpos(33,:,:); elec.elecpos(35,:,:); elec.elecpos(37,:,:); elec.elecpos(52,:,:); elec.elecpos(53,:,:); elec.elecpos(55,:,:); elec.elecpos(57,:,:); elec.elecpos(59,:,:);... %21-30
%                       elec.elecpos(60,:,:); elec.elecpos(54,:,:); elec.elecpos(58,:,:); elec.elecpos(22,:,:); elec.elecpos(24,:,:); elec.elecpos(20,:,:); elec.elecpos(44,:,:); elec.elecpos(32,:,:); elec.elecpos(14,:,:); elec.elecpos(66,:,:);... %31-40
%                       elec.elecpos(68,:,:); elec.elecpos(74,:,:); elec.elecpos(34,:,:); elec.elecpos(46,:,:); elec.elecpos(82,:,:); elec.elecpos(79,:,:); elec.elecpos(42,:,:); elec.elecpos(56,:,:); elec.elecpos(78,:,:); elec.elecpos(77,:,:);... %41-50
%                       elec.elecpos(10,:,:); elec.elecpos(36,:,:); elec.elecpos(76,:,:); elec.elecpos(80,:,:); elec.elecpos(26,:,:); elec.elecpos(70,:,:); elec.elecpos(64,:,:); elec.elecpos(48,:,:)];
end

%Unused
% elec = elecEdited;                  
% elec = ft_convert_units(elec, 'cm');

% figure
% hold on
% ft_plot_sens(elecEdited, 'elecsize', 40);
% ft_plot_headmodel(headmodel, 'facealpha', 0.5);
% view(90, 0);

%return;

% Allign the electrode

% -------------------------------------------------------------------------
% Allignment 1
% -------------------------------------------------------------------------
% cfg           = [];
% cfg.elec      = elecEdited;
% cfg.method    = 'interactive';
% cfg.headshape = vol.bnd(1);
% elecAligned  = ft_electroderealign(cfg);
%IL Manual Allignment
%Rotate: (-1.1),(-20),(-90.5);
%Scale: (1.04), (1), (0.95);
%Translate: (36.5), (0), (54);
% load elecAligned.mat

% -------------------------------------------------------------------------
% Allignment 2
% -------------------------------------------------------------------------
% elecAligned_edited = elecAligned;
for foldup = 1:1

%     % FRONTAL
%     for foldup = 1:1
%     % REIHE 1
%     % MID
%     channelIndex = find(strcmp(elecAligned.label, 'FCz'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 33.1842;
%     %elecAligned_edited.chanpos(channelIndex,2)= 1.1644;
%     %elecAligned_edited.chanpos(channelIndex,3)= 139.3478;
%     
%     % RIGHT
%     channelIndex = find(strcmp(elecAligned.label, 'FC2'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 35.4675;
%     %elecAligned_edited.chanpos(channelIndex,2)= -33.4138;
%     elecAligned_edited.chanpos(channelIndex,3)= 130.2678; %130.7678;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'FC4'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 40.8240;
%     %elecAligned_edited.chanpos(channelIndex,2)= -61.3305;
%     %elecAligned_edited.chanpos(channelIndex,3)= 109.6217;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'FC6'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 48.0711;
%     %elecAligned_edited.chanpos(channelIndex,2)= -79.1232;
%     %elecAligned_edited.chanpos(channelIndex,3)= 80.8162;    
%     
%     % LEFT
%     channelIndex = find(strcmp(elecAligned.label, 'FC1'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 35.2182;
%     %elecAligned_edited.chanpos(channelIndex,2)= 35.4431;
%     elecAligned_edited.chanpos(channelIndex,3)= 129.1210; %130.6210;       
%     
%     channelIndex = find(strcmp(elecAligned.label, 'FC3'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 40.9154;
%     %elecAligned_edited.chanpos(channelIndex,2)= 61.1249;
%     %elecAligned_edited.chanpos(channelIndex,3)= 107.3314;  
%     
%     channelIndex = find(strcmp(elecAligned.label, 'FC5'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 48.1371;
%     %elecAligned_edited.chanpos(channelIndex,2)= 77.6032;
%     %elecAligned_edited.chanpos(channelIndex,3)= 78.0015;
%     
%     % REIHE 2
%     % MID
%     channelIndex = find(strcmp(elecAligned.label, 'Fz'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 71.4972;
%     %elecAligned_edited.chanpos(channelIndex,2)= 0.7605;
%     elecAligned_edited.chanpos(channelIndex,3)= 124.6418; %129.6418;    
%     
%     % RIGHT
%     channelIndex = find(strcmp(elecAligned.label, 'F2'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 72.8209;
%     elecAligned_edited.chanpos(channelIndex,2)= -27.5596; %-28.5596;
%     elecAligned_edited.chanpos(channelIndex,3)= 119.6176; %123.6176; 
%     
%     channelIndex = find(strcmp(elecAligned.label, 'F4'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 76.0693;
%     %elecAligned_edited.chanpos(channelIndex,2)= -51.2086;
%     %elecAligned_edited.chanpos(channelIndex,3)= 106.1760; 
%     
%     channelIndex = find(strcmp(elecAligned.label, 'F6'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 80.2548;
%     %elecAligned_edited.chanpos(channelIndex,2)= -67.7153;
%     %elecAligned_edited.chanpos(channelIndex,3)= 83.1492; 
%     
%     channelIndex = find(strcmp(elecAligned.label, 'F8'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 85.0163;
%     %elecAligned_edited.chanpos(channelIndex,2)= -73.3434;
%     %elecAligned_edited.chanpos(channelIndex,3)= 56.1518; 
%     
%     % LEFT
%     channelIndex = find(strcmp(elecAligned.label, 'F1'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 72.3663;
%     elecAligned_edited.chanpos(channelIndex,2)= 27.4569; %28.4569;
%     elecAligned_edited.chanpos(channelIndex,3)= 119.2373; %123.2373; 
%     
%     channelIndex = find(strcmp(elecAligned.label, 'F3'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 75.2833;
%     %elecAligned_edited.chanpos(channelIndex,2)= 50.8820;
%     %elecAligned_edited.chanpos(channelIndex,3)= 105.4458; 
%     
%     channelIndex = find(strcmp(elecAligned.label, 'F5'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 79.4331;
%     elecAligned_edited.chanpos(channelIndex,2)= 67.6567; %64.6567;
%     elecAligned_edited.chanpos(channelIndex,3)= 82.0216; %81.0216;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'F7'));   
%     %elecAligned_edited.chanpos(channelIndex,1)= 84.1290;
%     elecAligned_edited.chanpos(channelIndex,2)= 70.9536; %69.9536;
%     %elecAligned_edited.chanpos(channelIndex,3)= 53.8294;    
%  
%     % REIHE 3
%     channelIndex = find(strcmp(elecAligned.label, 'AF4'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 105.8028;
%     %elecAligned_edited.chanpos(channelIndex,2)= -35.4782;
%     %elecAligned_edited.chanpos(channelIndex,3)= 96.7081;       
%     
%     channelIndex = find(strcmp(elecAligned.label, 'AF3'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 105.7855;
%     %elecAligned_edited.chanpos(channelIndex,2)= 33.9122;
%     %elecAligned_edited.chanpos(channelIndex,3)= 94.6995;       
% 
%     % REIHE 4
%     channelIndex = find(strcmp(elecAligned.label, 'Fpz'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 124.8071;
%     %elecAligned_edited.chanpos(channelIndex,2)= -0.3337;
%     %elecAligned_edited.chanpos(channelIndex,3)= 78.4536;  
%     
%     channelIndex = find(strcmp(elecAligned.label, 'Fp2'));
%     %elecAligned_edited.chanpos(channelIndex,1)= 123.1875;
%     %elecAligned_edited.chanpos(channelIndex,2)= -30.1784;
%     %elecAligned_edited.chanpos(channelIndex,3)= 73.0326;  
%     
%     channelIndex = find(strcmp(elecAligned.label, 'Fp1'));    
%     %elecAligned_edited.chanpos(channelIndex,1)= 122.7048;
%     %elecAligned_edited.chanpos(channelIndex,2)= 29.1245;
%     %elecAligned_edited.chanpos(channelIndex,3)= 71.8813;   
%     end
%     
%     % CENTRAL
%     for foldup = 1:1
%     % MID
%     % Cz
%     channelIndex = find(strcmp(elecAligned.label, 'Cz'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -6.6587;
%     %elecAligned_edited.chanpos(channelIndex,2)= 1.4273;
%     elecAligned_edited.chanpos(channelIndex,3)= 140.2990; %137.7990;
% 
%     % RIGHT
%     % C2
%     channelIndex = find(strcmp(elecAligned.label, 'C2'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -3.2146;
%     elecAligned_edited.chanpos(channelIndex,2)= -38.0501;%-36.0501
%     elecAligned_edited.chanpos(channelIndex,3)= 131.1639; %127.6639;
% 
%     % C4
%     channelIndex = find(strcmp(elecAligned.label, 'C4'));    
%     %elecAligned_edited.chanpos(channelIndex,1)= 4.1199;
%     elecAligned_edited.chanpos(channelIndex,2)= -68.4363; %-65.9363;
%     elecAligned_edited.chanpos(channelIndex,3)= 113.0390; %105.5390;
% 
%     % C6
%     channelIndex = find(strcmp(elecAligned.label, 'C6'));    
%     %elecAligned_edited.chanpos(channelIndex,1)= 14.3734;
%     elecAligned_edited.chanpos(channelIndex,2)= -84.8876; %-82.8876;
%     %elecAligned_edited.chanpos(channelIndex,3)= 74.5024;
% 
%     % T4
%     channelIndex = find(strcmp(elecAligned.label, 'T4'));    
%     %elecAligned_edited.chanpos(channelIndex,1)= 25.9315;
%     elecAligned_edited.chanpos(channelIndex,2)= -87.2046; %-85.2046;
%     %elecAligned_edited.chanpos(channelIndex,3)= 39.2585;    
% 
%     % LEFT
%     % C1
%     channelIndex = find(strcmp(elecAligned.label, 'C1'));    
%     %elecAligned_edited.chanpos(channelIndex,1)= -3.4132;
%     elecAligned_edited.chanpos(channelIndex,2)= 39.7927; %37.7927;
%     elecAligned_edited.chanpos(channelIndex,3)= 130.6058; %128.6058;
% 
%     % C3
%     channelIndex = find(strcmp(elecAligned.label, 'C3'));    
%     %elecAligned_edited.chanpos(channelIndex,1)= 4.2582;
%     elecAligned_edited.chanpos(channelIndex,2)= 70.5334; %66.5334;
%     %elecAligned_edited.chanpos(channelIndex,3)= 103.9553;
% 
%     % C5
%     channelIndex = find(strcmp(elecAligned.label, 'C5'));    
%     %elecAligned_edited.chanpos(channelIndex,1)= 14.8258;
%     elecAligned_edited.chanpos(channelIndex,2)= 83.8226;
%     %elecAligned_edited.chanpos(channelIndex,3)= 71.6181;
% 
%     % T3
%     channelIndex = find(strcmp(elecAligned.label, 'T3'));    
%     %elecAligned_edited.chanpos(channelIndex,1)= 26.3480;
%     elecAligned_edited.chanpos(channelIndex,2)=  88.0132; %84.0132;
%     %elecAligned_edited.chanpos(channelIndex,3)= 36.4559;
%     end
%     
%     % OCCIPITAL
%     for foldup = 1:1
%         
%     % REIHE 1
%     % MID
%     channelIndex = find(strcmp(elecAligned.label, 'CPz'));
%     elecAligned_edited.chanpos(channelIndex,1)= -41.6525; %-43.6525;
%     %elecAligned_edited.chanpos(channelIndex,2)= 1.5102;
%     elecAligned_edited.chanpos(channelIndex,3)= 122.1747; %124.6747;
%     
%     % RIGHT    
%     channelIndex = find(strcmp(elecAligned.label, 'CP2'));
%     elecAligned_edited.chanpos(channelIndex,1)= -40.1295; %-40.6295
%     %elecAligned_edited.chanpos(channelIndex,2)= -36.6397;
%     elecAligned_edited.chanpos(channelIndex,3)= 116.5414; %117.5414
%     
%     channelIndex = find(strcmp(elecAligned.label, 'CP4'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -31.5108;
%     %elecAligned_edited.chanpos(channelIndex,2)= -65.3171;
%     %elecAligned_edited.chanpos(channelIndex,3)= 95.7016;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'CP6'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -18.9028;
%     elecAligned_edited.chanpos(channelIndex,2)= -79.6456; %-82.6456;
%     %elecAligned_edited.chanpos(channelIndex,3)= 65.4528;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'TP8'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -4.7423;
%     elecAligned_edited.chanpos(channelIndex,2)= -82.5650; %-85.5650
%     elecAligned_edited.chanpos(channelIndex,3)= 35.4513; %31.4513;
%     
%     % LEFT    
%     channelIndex = find(strcmp(elecAligned.label, 'CP1'));
%     elecAligned_edited.chanpos(channelIndex,1)= -37.9337; %-40.4337;
%     %elecAligned_edited.chanpos(channelIndex,2)= 37.2566;
%     elecAligned_edited.chanpos(channelIndex,3)= 114.3855; %116.8855;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'CP3'));
%     elecAligned_edited.chanpos(channelIndex,1)= -30.2795; %-30.7795
%     %elecAligned_edited.chanpos(channelIndex,2)= 64.8311;
%     elecAligned_edited.chanpos(channelIndex,3)= 93.1152; %93.6152
%     
%     channelIndex = find(strcmp(elecAligned.label, 'CP5'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -17.8612;
%     elecAligned_edited.chanpos(channelIndex,2)= 77.2379; %80.2379;
%     %elecAligned_edited.chanpos(channelIndex,3)= 62.5682;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'TP7'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -3.7811;
%     elecAligned_edited.chanpos(channelIndex,2)= 80.7883; %84.7883;
%     elecAligned_edited.chanpos(channelIndex,3)= 33.7383; %28.7383;   
%         
%     % REIHE 2    
%     % MID
%     channelIndex = find(strcmp(elecAligned.label, 'Pz'));
%     elecAligned_edited.chanpos(channelIndex,1)= -66.1981; %-70.6981;
%     %elecAligned_edited.chanpos(channelIndex,2)= 1.3409;
%     elecAligned_edited.chanpos(channelIndex,3)= 93.1796; %98.6796;
%     
%     % RIGHT    
%     channelIndex = find(strcmp(elecAligned.label, 'P2'));
%     elecAligned_edited.chanpos(channelIndex,1)= -64.2556; %-68.2556;
%     %elecAligned_edited.chanpos(channelIndex,2)= -30.3567;
%     elecAligned_edited.chanpos(channelIndex,3)= 89.6052; %94.1052;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'P4'));
%     elecAligned_edited.chanpos(channelIndex,1)= -57.4060; %-59.4060;
%     %elecAligned_edited.chanpos(channelIndex,2)= -54.4675;
%     elecAligned_edited.chanpos(channelIndex,3)= 76.1080; %77.1080;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'P6'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -46.7879;
%     elecAligned_edited.chanpos(channelIndex,2)= -68.2058; %-67.2058;
%     %elecAligned_edited.chanpos(channelIndex,3)= 52.7487;
%     
%     % LEFT    
%     channelIndex = find(strcmp(elecAligned.label, 'P1')); 
%     elecAligned_edited.chanpos(channelIndex,1)= -61.8210; %-67.3210;
%     %elecAligned_edited.chanpos(channelIndex,2)= 30.1503;
%     elecAligned_edited.chanpos(channelIndex,3)= 86.5180; %92.0180;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'P3'));
%     elecAligned_edited.chanpos(channelIndex,1)= -54.4807; %-58.4807;
%     %elecAligned_edited.chanpos(channelIndex,2)= 54.1778;
%     elecAligned_edited.chanpos(channelIndex,3)= 72.3060; %74.8060;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'P5'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -46.1163;
%     elecAligned_edited.chanpos(channelIndex,2)= 63.9379; %67.9379;
%     %elecAligned_edited.chanpos(channelIndex,3)= 50.8011;
%     
%     % REIHE 3
%     % MID
%     channelIndex = find(strcmp(elecAligned.label, 'POz'));
%     elecAligned_edited.chanpos(channelIndex,1)= -78.8959; %-79.8959;
%     %elecAligned_edited.chanpos(channelIndex,2)= 0.9180;
%     elecAligned_edited.chanpos(channelIndex,3)= 61.2647; %63.2647;
%     
%     % RIGHT        
%     channelIndex = find(strcmp(elecAligned.label, 'PO2'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -78.1881;
%     %elecAligned_edited.chanpos(channelIndex,2)= -18.8176;
%     %elecAligned_edited.chanpos(channelIndex,3)= 59.9306;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'PO4'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -73.8542;
%     %elecAligned_edited.chanpos(channelIndex,2)= -35.9012;
%     %elecAligned_edited.chanpos(channelIndex,3)= 51.5758;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'PO8'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -58.8893;
%     %elecAligned_edited.chanpos(channelIndex,2)= -55.3974;
%     %elecAligned_edited.chanpos(channelIndex,3)= 22.8653;
%     
%     % LEFT    
%     channelIndex = find(strcmp(elecAligned.label, 'PO1'));
%     elecAligned_edited.chanpos(channelIndex,1)= -76.8832; %-77.8832;
%     %elecAligned_edited.chanpos(channelIndex,2)= 20.0285;
%     elecAligned_edited.chanpos(channelIndex,3)= 58.4680; %59.4680;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'PO3'));
%     elecAligned_edited.chanpos(channelIndex,1)= -72.5068; %-73.5068;
%     %elecAligned_edited.chanpos(channelIndex,2)= 37.3936;
%     elecAligned_edited.chanpos(channelIndex,3)= 50.1330; %51.1330;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'PO7'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -57.8739;
%     %elecAligned_edited.chanpos(channelIndex,2)= 55.0923;
%     %elecAligned_edited.chanpos(channelIndex,3)= 21.2502;
%     
%     % REIHE 4
%     % Oz
%     channelIndex = find(strcmp(elecAligned.label, 'Oz'));        
%     elecAligned_edited.chanpos(channelIndex,1)= -81.5318; %-79.5318;
%     %elecAligned_edited.chanpos(channelIndex,2)= 0.4049;
%     elecAligned_edited.chanpos(channelIndex,3)= 24.5431; %27.0431;
%     
%     channelIndex = find(strcmp(elecAligned.label, 'O2'));
%     %elecAligned_edited.chanpos(channelIndex,1)= -75.0284;
%     %elecAligned_edited.chanpos(channelIndex,2)= -29.4368;
%     %elecAligned_edited.chanpos(channelIndex,3)= 23.1626;  
%     
%     channelIndex = find(strcmp(elecAligned.label, 'O1')); 
%     %elecAligned_edited.chanpos(channelIndex,1)= -74.8232;
%     %elecAligned_edited.chanpos(channelIndex,2)= 29.8108;
%     %elecAligned_edited.chanpos(channelIndex,3)= 22.1896;      
% 
%     end
%     
% % %Extra Befehl
% % elecAligned_edited.chanpos(channelIndex,1),elecAligned_edited.chanpos(channelIndex,2),elecAligned_edited.chanpos(channelIndex,3);   

end
% load elecAligned_edited.mat    

% -------------------------------------------------------------------------
% Allignment 3
% -------------------------------------------------------------------------
% elec = elecAligned_edited;
% % Electrode FT9 FT10 TP10 and TP9 for IL
for foldup = 1:1
% elec.label = [elec.label(1:4); elec.label(6:8); elec.label(11:20); elec.label(22:26); elec.label(28:63)];
% 
% elec.chanunit = [elec.chanunit(1:4); elec.chanunit(6:8); elec.chanunit(11:20); elec.chanunit(22:26); elec.chanunit(28:63)];
% 
% elec.chantype = [elec.chantype(1:4); elec.chantype(6:8); elec.chantype(11:20); elec.chantype(22:26); elec.chantype(28:63)];
%  
% elec.chanpos = [elec.chanpos(1,:,:); elec.chanpos(2,:,:); elec.chanpos(3,:,:); elec.chanpos(4,:,:); elec.chanpos(6,:,:); elec.chanpos(7,:,:); elec.chanpos(8,:,:); elec.chanpos(11,:,:); elec.chanpos(12,:,:); elec.chanpos(13,:,:);... &1-10
%                       elec.chanpos(14,:,:); elec.chanpos(15,:,:); elec.chanpos(16,:,:); elec.chanpos(17,:,:); elec.chanpos(18,:,:); elec.chanpos(19,:,:); elec.chanpos(20,:,:); elec.chanpos(22,:,:); elec.chanpos(23,:,:); elec.chanpos(24,:,:);... &11-20
%                       elec.chanpos(25,:,:); elec.chanpos(26,:,:); elec.chanpos(28,:,:); elec.chanpos(29,:,:); elec.chanpos(30,:,:); elec.chanpos(31,:,:); elec.chanpos(32,:,:); elec.chanpos(33,:,:); elec.chanpos(34,:,:); elec.chanpos(35,:,:);... %21-30
%                       elec.chanpos(36,:,:); elec.chanpos(37,:,:); elec.chanpos(38,:,:); elec.chanpos(39,:,:); elec.chanpos(40,:,:); elec.chanpos(41,:,:); elec.chanpos(42,:,:); elec.chanpos(43,:,:); elec.chanpos(44,:,:); elec.chanpos(45,:,:);... %31-40
%                       elec.chanpos(46,:,:); elec.chanpos(47,:,:); elec.chanpos(48,:,:); elec.chanpos(49,:,:); elec.chanpos(50,:,:); elec.chanpos(51,:,:); elec.chanpos(52,:,:); elec.chanpos(53,:,:); elec.chanpos(54,:,:); elec.chanpos(55,:,:);... %41-50
%                       elec.chanpos(56,:,:); elec.chanpos(57,:,:); elec.chanpos(58,:,:); elec.chanpos(59,:,:); elec.chanpos(60,:,:); elec.chanpos(61,:,:); elec.chanpos(62,:,:); elec.chanpos(63,:,:)];
% 
% elec.elecpos = [elec.elecpos(1,:,:); elec.elecpos(2,:,:); elec.elecpos(3,:,:); elec.elecpos(4,:,:); elec.elecpos(6,:,:); elec.elecpos(7,:,:); elec.elecpos(8,:,:); elec.elecpos(11,:,:); elec.elecpos(12,:,:); elec.elecpos(13,:,:);... &1-10
%                       elec.elecpos(14,:,:); elec.elecpos(15,:,:); elec.elecpos(16,:,:); elec.elecpos(17,:,:); elec.elecpos(18,:,:); elec.elecpos(19,:,:); elec.elecpos(20,:,:); elec.elecpos(22,:,:); elec.elecpos(23,:,:); elec.elecpos(24,:,:);... &11-20
%                       elec.elecpos(25,:,:); elec.elecpos(26,:,:); elec.elecpos(28,:,:); elec.elecpos(29,:,:); elec.elecpos(30,:,:); elec.elecpos(31,:,:); elec.elecpos(32,:,:); elec.elecpos(33,:,:); elec.elecpos(34,:,:); elec.elecpos(35,:,:);... %21-30
%                       elec.elecpos(36,:,:); elec.elecpos(37,:,:); elec.elecpos(38,:,:); elec.elecpos(39,:,:); elec.elecpos(40,:,:); elec.elecpos(41,:,:); elec.elecpos(42,:,:); elec.elecpos(43,:,:); elec.elecpos(44,:,:); elec.elecpos(45,:,:);... %31-40
%                       elec.elecpos(46,:,:); elec.elecpos(47,:,:); elec.elecpos(48,:,:); elec.elecpos(49,:,:); elec.elecpos(50,:,:); elec.elecpos(51,:,:); elec.elecpos(52,:,:); elec.elecpos(53,:,:); elec.elecpos(54,:,:); elec.elecpos(55,:,:);... %41-50
%                       elec.elecpos(56,:,:); elec.elecpos(57,:,:); elec.elecpos(58,:,:); elec.elecpos(59,:,:); elec.elecpos(60,:,:); elec.elecpos(61,:,:); elec.elecpos(62,:,:); elec.elecpos(63,:,:)];
% elec.tra = diag(ones(58,1));
end
% elecAligned_edited_58 = elec;

% -------------------------------------------------------------------------
% Allignment 4
% -------------------------------------------------------------------------
% load elecAligned_edited_58.mat
for foldup = 1:1
% elec = elecAligned_edited_58;
% 
% %Change AFz into FPz and change it's location 
% channelIndex = find(strcmp(elec.label, 'AFz'));
% elec.label{channelIndex,1} = 'Fpz';
% elec.chanpos(channelIndex,1)= 124.8071;
% elec.chanpos(channelIndex,2)= -0.3337;
% elec.chanpos(channelIndex,3)= 78.4536;  
% 
% %Change T8 into FCz and change it's location 
% channelIndex = find(strcmp(elec.label, 'T8'));
% elec.label{channelIndex,1} = 'FCz';
% elec.chanpos(channelIndex,1)= 33.1842;
% elec.chanpos(channelIndex,2)= 1.1644;
% elec.chanpos(channelIndex,3)= 139.3478;
% 
% %Change Name FT7 into T3
% channelIndex = find(strcmp(elec.label, 'FT7'));
% elec.label{channelIndex,1} = 'T3';
% 
% %Change Name FT8 into T4
% channelIndex = find(strcmp(elec.label, 'FT8'));
% elec.label{channelIndex,1} = 'T4';
% 
% %Change Name P7 into T5
% channelIndex = find(strcmp(elec.label, 'P7'));
% elec.label{channelIndex,1} = 'T5';
% 
% %Change Name P8 into T6
% channelIndex = find(strcmp(elec.label, 'P8'));
% elec.label{channelIndex,1} = 'T6';
% 
% %Change Name AF7 into PO1 and change it's location 
% channelIndex = find(strcmp(elec.label, 'AF7'));
% elec.label{channelIndex,1} = 'PO1';
% elec.chanpos(channelIndex,1)= -77.5068; %-73.5068;
% elec.chanpos(channelIndex,2)= 20.3936; %37.3936;
% elec.chanpos(channelIndex,3)= 54.1330; %51.1330;
% 
% %Change Name AF8 into PO2 and change it's location 
% channelIndex = find(strcmp(elec.label, 'AF8'));
% elec.label{channelIndex,1} = 'PO2';
% elec.chanpos(channelIndex,1)= -78.8542;
% elec.chanpos(channelIndex,2)= -19.9012; %-35.9012
% elec.chanpos(channelIndex,3)= 55.5758;
% 
% elec.elecpos = elec.chanpos;
end
% elecAligned_edited_58_edited = elec;

% -------------------------------------------------------------------------
% Allignment 5
% -------------------------------------------------------------------------
% load elecAligned_edited_58_edited.mat
for foldup = 1:1
% elec = elecAligned_edited_58_edited;
% elec.label = [elec.label(1); elec.label(30); elec.label(27); elec.label(4); elec.label(3); ...
%                  elec.label(2); elec.label(25); elec.label(26); elec.label(33); elec.label(7); ...
%                  elec.label(20); elec.label(21); elec.label(54); elec.label(12); elec.label(11); ...
%                  elec.label(10); elec.label(16); elec.label(17); elec.label(13); elec.label(14); ...
%                  elec.label(15); elec.label(5); elec.label(6); elec.label(24); elec.label(23); ...
%                  elec.label(37); elec.label(8); elec.label(9); elec.label(19); elec.label(18); ...
%                  elec.label(50); elec.label(38); elec.label(49); elec.label(31); elec.label(58); ...
%                  elec.label(32); elec.label(35); elec.label(34); elec.label(57); elec.label(39); ...
%                  elec.label(47); elec.label(41); elec.label(22); elec.label(52); elec.label(45); ...
%                  elec.label(56); elec.label(36); elec.label(48); elec.label(43); elec.label(28); ...
%                  elec.label(29); elec.label(53); elec.label(42); elec.label(44); elec.label(55); ...
%                  elec.label(46); elec.label(40); elec.label(51)];
%              
% elec.chanunit = [elec.chanunit(1); elec.chanunit(30); elec.chanunit(27); elec.chanunit(4); elec.chanunit(3); ...
%                  elec.chanunit(2); elec.chanunit(25); elec.chanunit(26); elec.chanunit(33); elec.chanunit(7); ...
%                  elec.chanunit(20); elec.chanunit(21); elec.chanunit(54); elec.chanunit(12); elec.chanunit(11); ...
%                  elec.chanunit(10); elec.chanunit(16); elec.chanunit(17); elec.chanunit(13); elec.chanunit(14); ...
%                  elec.chanunit(15); elec.chanunit(5); elec.chanunit(6); elec.chanunit(24); elec.chanunit(23); ...
%                  elec.chanunit(37); elec.chanunit(8); elec.chanunit(9); elec.chanunit(19); elec.chanunit(18); ...
%                  elec.chanunit(50); elec.chanunit(38); elec.chanunit(49); elec.chanunit(31); elec.chanunit(58); ...
%                  elec.chanunit(32); elec.chanunit(35); elec.chanunit(34); elec.chanunit(57); elec.chanunit(39); ...
%                  elec.chanunit(47); elec.chanunit(41); elec.chanunit(22); elec.chanunit(52); elec.chanunit(45); ...
%                  elec.chanunit(56); elec.chanunit(36); elec.chanunit(48); elec.chanunit(43); elec.chanunit(28); ...
%                  elec.chanunit(29); elec.chanunit(53); elec.chanunit(42); elec.chanunit(44); elec.chanunit(55); ...
%                  elec.chanunit(46); elec.chanunit(40); elec.chanunit(51)];
% 
% elec.chantype = [elec.chantype(1); elec.chantype(30); elec.chantype(27); elec.chantype(4); elec.chantype(3); ...
%                  elec.chantype(2); elec.chantype(25); elec.chantype(26); elec.chantype(33); elec.chantype(7); ...
%                  elec.chantype(20); elec.chantype(21); elec.chantype(54); elec.chantype(12); elec.chantype(11); ...
%                  elec.chantype(10); elec.chantype(16); elec.chantype(17); elec.chantype(13); elec.chantype(14); ...
%                  elec.chantype(15); elec.chantype(5); elec.chantype(6); elec.chantype(24); elec.chantype(23); ...
%                  elec.chantype(37); elec.chantype(8); elec.chantype(9); elec.chantype(19); elec.chantype(18); ...
%                  elec.chantype(50); elec.chantype(38); elec.chantype(49); elec.chantype(31); elec.chantype(58); ...
%                  elec.chantype(32); elec.chantype(35); elec.chantype(34); elec.chantype(57); elec.chantype(39); ...
%                  elec.chantype(47); elec.chantype(41); elec.chantype(22); elec.chantype(52); elec.chantype(45); ...
%                  elec.chantype(56); elec.chantype(36); elec.chantype(48); elec.chantype(43); elec.chantype(28); ...
%                  elec.chantype(29); elec.chantype(53); elec.chantype(42); elec.chantype(44); elec.chantype(55); ...
%                  elec.chantype(46); elec.chantype(40); elec.chantype(51)];
%  
% elec.chanpos = [elec.chanpos(1,:,:); elec.chanpos(30,:,:); elec.chanpos(27,:,:); elec.chanpos(4,:,:); elec.chanpos(3,:,:); ...
%                  elec.chanpos(2,:,:); elec.chanpos(25,:,:); elec.chanpos(26,:,:); elec.chanpos(33,:,:); elec.chanpos(7,:,:); ...
%                  elec.chanpos(20,:,:); elec.chanpos(21,:,:); elec.chanpos(54,:,:); elec.chanpos(12,:,:); elec.chanpos(11,:,:); ...
%                  elec.chanpos(10,:,:); elec.chanpos(16,:,:); elec.chanpos(17,:,:); elec.chanpos(13,:,:); elec.chanpos(14,:,:); ...
%                  elec.chanpos(15,:,:); elec.chanpos(5,:,:); elec.chanpos(6,:,:); elec.chanpos(24,:,:); elec.chanpos(23,:,:); ...
%                  elec.chanpos(37,:,:); elec.chanpos(8,:,:); elec.chanpos(9,:,:); elec.chanpos(19,:,:); elec.chanpos(18,:,:); ...
%                  elec.chanpos(50,:,:); elec.chanpos(38,:,:); elec.chanpos(49,:,:); elec.chanpos(31,:,:); elec.chanpos(58,:,:); ...
%                  elec.chanpos(32,:,:); elec.chanpos(35,:,:); elec.chanpos(34,:,:); elec.chanpos(57,:,:); elec.chanpos(39,:,:); ...
%                  elec.chanpos(47,:,:); elec.chanpos(41,:,:); elec.chanpos(22,:,:); elec.chanpos(52,:,:); elec.chanpos(45,:,:); ...
%                  elec.chanpos(56,:,:); elec.chanpos(36,:,:); elec.chanpos(48,:,:); elec.chanpos(43,:,:); elec.chanpos(28,:,:); ...
%                  elec.chanpos(29,:,:); elec.chanpos(53,:,:); elec.chanpos(42,:,:); elec.chanpos(44,:,:); elec.chanpos(55,:,:); ...
%                  elec.chanpos(46,:,:); elec.chanpos(40,:,:); elec.chanpos(51,:,:)];
% 
% elec.elecpos = [elec.elecpos(1,:,:); elec.elecpos(30,:,:); elec.elecpos(27,:,:); elec.elecpos(4,:,:); elec.elecpos(3,:,:); ...
%                  elec.elecpos(2,:,:); elec.elecpos(25,:,:); elec.elecpos(26,:,:); elec.elecpos(33,:,:); elec.elecpos(7,:,:); ...
%                  elec.elecpos(20,:,:); elec.elecpos(21,:,:); elec.elecpos(54,:,:); elec.elecpos(12,:,:); elec.elecpos(11,:,:); ...
%                  elec.elecpos(10,:,:); elec.elecpos(16,:,:); elec.elecpos(17,:,:); elec.elecpos(13,:,:); elec.elecpos(14,:,:); ...
%                  elec.elecpos(15,:,:); elec.elecpos(5,:,:); elec.elecpos(6,:,:); elec.elecpos(24,:,:); elec.elecpos(23,:,:); ...
%                  elec.elecpos(37,:,:); elec.elecpos(8,:,:); elec.elecpos(9,:,:); elec.elecpos(19,:,:); elec.elecpos(18,:,:); ...
%                  elec.elecpos(50,:,:); elec.elecpos(38,:,:); elec.elecpos(49,:,:); elec.elecpos(31,:,:); elec.elecpos(58,:,:); ...
%                  elec.elecpos(32,:,:); elec.elecpos(35,:,:); elec.elecpos(34,:,:); elec.elecpos(57,:,:); elec.elecpos(39,:,:); ...
%                  elec.elecpos(47,:,:); elec.elecpos(41,:,:); elec.elecpos(22,:,:); elec.elecpos(52,:,:); elec.elecpos(45,:,:); ...
%                  elec.elecpos(56,:,:); elec.elecpos(36,:,:); elec.elecpos(48,:,:); elec.elecpos(43,:,:); elec.elecpos(28,:,:); ...
%                  elec.elecpos(29,:,:); elec.elecpos(53,:,:); elec.elecpos(42,:,:); elec.elecpos(44,:,:); elec.elecpos(55,:,:); ...
%                  elec.elecpos(46,:,:); elec.elecpos(40,:,:); elec.elecpos(51,:,:)];
end
% elecAligned_edited_58_edited_listed = elec;

% -------------------------------------------------------------------------
% Allignment 6
% -------------------------------------------------------------------------
% load elecAligned_edited_58_edited_listed.mat
for foldup = 1:1
% elec = elecAligned_edited_58_edited_listed;
% 
% % 1. Fp1
% elec.chanpos(1,1)= elecAligned_edited_58_edited_listed.chanpos(1,1);
% elec.chanpos(1,2)= elecAligned_edited_58_edited_listed.chanpos(1,2);
% elec.chanpos(1,3)= elecAligned_edited_58_edited_listed.chanpos(1,3); 
% 
% % 2. Fpz
% elec.chanpos(2,1)= elecAligned_edited_58_edited_listed.chanpos(2,1)+2;
% elec.chanpos(2,2)= elecAligned_edited_58_edited_listed.chanpos(2,2);
% elec.chanpos(2,3)= elecAligned_edited_58_edited_listed.chanpos(2,3)-5; 
% 
% % 3. Fp2
% elec.chanpos(3,1)= elecAligned_edited_58_edited_listed.chanpos(3,1);
% elec.chanpos(3,2)= elecAligned_edited_58_edited_listed.chanpos(3,2);
% elec.chanpos(3,3)= elecAligned_edited_58_edited_listed.chanpos(3,3);
% 
% % 4. F7
% elec.chanpos(4,1)= elecAligned_edited_58_edited_listed.chanpos(4,1);
% elec.chanpos(4,2)= elecAligned_edited_58_edited_listed.chanpos(4,2);
% elec.chanpos(4,3)= elecAligned_edited_58_edited_listed.chanpos(4,3);
% 
% % 5. F3
% elec.chanpos(5,1)= elecAligned_edited_58_edited_listed.chanpos(5,1);
% elec.chanpos(5,2)= elecAligned_edited_58_edited_listed.chanpos(5,2);
% elec.chanpos(5,3)= elecAligned_edited_58_edited_listed.chanpos(5,3);
% 
% % 6. Fz
% elec.chanpos(6,1)= elecAligned_edited_58_edited_listed.chanpos(6,1);
% elec.chanpos(6,2)= elecAligned_edited_58_edited_listed.chanpos(6,2);
% elec.chanpos(6,3)= elecAligned_edited_58_edited_listed.chanpos(6,3);
% 
% % 7. F4
% elec.chanpos(7,1)= elecAligned_edited_58_edited_listed.chanpos(7,1);
% elec.chanpos(7,2)= elecAligned_edited_58_edited_listed.chanpos(7,2);
% elec.chanpos(7,3)= elecAligned_edited_58_edited_listed.chanpos(7,3);
% 
% % 8. F8
% elec.chanpos(8,1)= elecAligned_edited_58_edited_listed.chanpos(8,1);
% elec.chanpos(8,2)= elecAligned_edited_58_edited_listed.chanpos(8,2);
% elec.chanpos(8,3)= elecAligned_edited_58_edited_listed.chanpos(8,3);
% 
% % 9. T3
% elec.chanpos(9,1)= elecAligned_edited_58_edited_listed.chanpos(9,1)-40;
% elec.chanpos(9,2)= elecAligned_edited_58_edited_listed.chanpos(9,2)+3;
% elec.chanpos(9,3)= elecAligned_edited_58_edited_listed.chanpos(9,3);
% 
% % 10. C3
% elec.chanpos(10,1)= elecAligned_edited_58_edited_listed.chanpos(10,1);
% elec.chanpos(10,2)= elecAligned_edited_58_edited_listed.chanpos(10,2);
% elec.chanpos(10,3)= elecAligned_edited_58_edited_listed.chanpos(10,3);
% 
% % 11. Cz
% elec.chanpos(11,1)= elecAligned_edited_58_edited_listed.chanpos(11,1);
% elec.chanpos(11,2)= elecAligned_edited_58_edited_listed.chanpos(11,2);
% elec.chanpos(11,3)= elecAligned_edited_58_edited_listed.chanpos(11,3);
% 
% % 12. C4
% elec.chanpos(12,1)= elecAligned_edited_58_edited_listed.chanpos(12,1);
% elec.chanpos(12,2)= elecAligned_edited_58_edited_listed.chanpos(12,2);
% elec.chanpos(12,3)= elecAligned_edited_58_edited_listed.chanpos(12,3);
% 
% % 13. T4
% elec.chanpos(13,1)= elecAligned_edited_58_edited_listed.chanpos(13,1)-40;
% elec.chanpos(13,2)= elecAligned_edited_58_edited_listed.chanpos(13,2)-2;
% elec.chanpos(13,3)= elecAligned_edited_58_edited_listed.chanpos(13,3);
% 
% % 14. T5
% elec.chanpos(14,1)= elecAligned_edited_58_edited_listed.chanpos(14,1);
% elec.chanpos(14,2)= elecAligned_edited_58_edited_listed.chanpos(14,2);
% elec.chanpos(14,3)= elecAligned_edited_58_edited_listed.chanpos(14,3);
% 
% % 15. P3
% elec.chanpos(15,1)= elecAligned_edited_58_edited_listed.chanpos(15,1);
% elec.chanpos(15,2)= elecAligned_edited_58_edited_listed.chanpos(15,2);
% elec.chanpos(15,3)= elecAligned_edited_58_edited_listed.chanpos(15,3);
% 
% % 16. Pz
% elec.chanpos(16,1)= elecAligned_edited_58_edited_listed.chanpos(16,1);
% elec.chanpos(16,2)= elecAligned_edited_58_edited_listed.chanpos(16,2);
% elec.chanpos(16,3)= elecAligned_edited_58_edited_listed.chanpos(16,3);
% 
% % 17. P4
% elec.chanpos(17,1)= elecAligned_edited_58_edited_listed.chanpos(17,1);
% elec.chanpos(17,2)= elecAligned_edited_58_edited_listed.chanpos(17,2);
% elec.chanpos(17,3)= elecAligned_edited_58_edited_listed.chanpos(17,3);
% 
% % 18. T6
% elec.chanpos(18,1)= elecAligned_edited_58_edited_listed.chanpos(18,1);
% elec.chanpos(18,2)= elecAligned_edited_58_edited_listed.chanpos(18,2);
% elec.chanpos(18,3)= elecAligned_edited_58_edited_listed.chanpos(18,3);
% 
% % 19. O1
% elec.chanpos(19,1)= elecAligned_edited_58_edited_listed.chanpos(19,1);
% elec.chanpos(19,2)= elecAligned_edited_58_edited_listed.chanpos(19,2);
% elec.chanpos(19,3)= elecAligned_edited_58_edited_listed.chanpos(19,3);
% 
% % 20. Oz
% elec.chanpos(20,1)= elecAligned_edited_58_edited_listed.chanpos(20,1);
% elec.chanpos(20,2)= elecAligned_edited_58_edited_listed.chanpos(20,2);
% elec.chanpos(20,3)= elecAligned_edited_58_edited_listed.chanpos(20,3);
% 
% % 21. O2
% elec.chanpos(21,1)= elecAligned_edited_58_edited_listed.chanpos(21,1);
% elec.chanpos(21,2)= elecAligned_edited_58_edited_listed.chanpos(21,2);
% elec.chanpos(21,3)= elecAligned_edited_58_edited_listed.chanpos(21,3);
% 
% % 22. FC5
% elec.chanpos(22,1)= elecAligned_edited_58_edited_listed.chanpos(22,1);
% elec.chanpos(22,2)= elecAligned_edited_58_edited_listed.chanpos(22,2);
% elec.chanpos(22,3)= elecAligned_edited_58_edited_listed.chanpos(22,3);
% 
% % 23. FC1
% elec.chanpos(23,1)= elecAligned_edited_58_edited_listed.chanpos(23,1);
% elec.chanpos(23,2)= elecAligned_edited_58_edited_listed.chanpos(23,2);
% elec.chanpos(23,3)= elecAligned_edited_58_edited_listed.chanpos(23,3);
% 
% % 24. FC2
% elec.chanpos(24,1)= elecAligned_edited_58_edited_listed.chanpos(24,1);
% elec.chanpos(24,2)= elecAligned_edited_58_edited_listed.chanpos(24,2);
% elec.chanpos(24,3)= elecAligned_edited_58_edited_listed.chanpos(24,3);
% 
% % 25. FC6
% elec.chanpos(25,1)= elecAligned_edited_58_edited_listed.chanpos(25,1);
% elec.chanpos(25,2)= elecAligned_edited_58_edited_listed.chanpos(25,2);
% elec.chanpos(25,3)= elecAligned_edited_58_edited_listed.chanpos(25,3);
% 
% % 26. TP7
% elec.chanpos(26,1)= elecAligned_edited_58_edited_listed.chanpos(26,1);
% elec.chanpos(26,2)= elecAligned_edited_58_edited_listed.chanpos(26,2);
% elec.chanpos(26,3)= elecAligned_edited_58_edited_listed.chanpos(26,3);
% 
% % 27. CP5
% elec.chanpos(27,1)= elecAligned_edited_58_edited_listed.chanpos(27,1);
% elec.chanpos(27,2)= elecAligned_edited_58_edited_listed.chanpos(27,2);
% elec.chanpos(27,3)= elecAligned_edited_58_edited_listed.chanpos(27,3);
% 
% % 28. CP1
% elec.chanpos(28,1)= elecAligned_edited_58_edited_listed.chanpos(28,1);
% elec.chanpos(28,2)= elecAligned_edited_58_edited_listed.chanpos(28,2);
% elec.chanpos(28,3)= elecAligned_edited_58_edited_listed.chanpos(28,3);
% 
% % 29. CP2
% elec.chanpos(29,1)= elecAligned_edited_58_edited_listed.chanpos(29,1);
% elec.chanpos(29,2)= elecAligned_edited_58_edited_listed.chanpos(29,2);
% elec.chanpos(29,3)= elecAligned_edited_58_edited_listed.chanpos(29,3);
% 
% % 30. CP6
% elec.chanpos(30,1)= elecAligned_edited_58_edited_listed.chanpos(30,1);
% elec.chanpos(30,2)= elecAligned_edited_58_edited_listed.chanpos(30,2);
% elec.chanpos(30,3)= elecAligned_edited_58_edited_listed.chanpos(30,3);
% 
% % 31. TP8
% elec.chanpos(31,1)= elecAligned_edited_58_edited_listed.chanpos(31,1);
% elec.chanpos(31,2)= elecAligned_edited_58_edited_listed.chanpos(31,2);
% elec.chanpos(31,3)= elecAligned_edited_58_edited_listed.chanpos(31,3);
% 
% % 32. CP3
% elec.chanpos(32,1)= elecAligned_edited_58_edited_listed.chanpos(32,1);
% elec.chanpos(32,2)= elecAligned_edited_58_edited_listed.chanpos(32,2);
% elec.chanpos(32,3)= elecAligned_edited_58_edited_listed.chanpos(32,3);
% 
% % 33. CP4
% elec.chanpos(33,1)= elecAligned_edited_58_edited_listed.chanpos(33,1);
% elec.chanpos(33,2)= elecAligned_edited_58_edited_listed.chanpos(33,2);
% elec.chanpos(33,3)= elecAligned_edited_58_edited_listed.chanpos(33,3);
% 
% % 34. F1
% elec.chanpos(34,1)= elecAligned_edited_58_edited_listed.chanpos(34,1);
% elec.chanpos(34,2)= elecAligned_edited_58_edited_listed.chanpos(34,2);
% elec.chanpos(34,3)= elecAligned_edited_58_edited_listed.chanpos(34,3);
% 
% % 35. F2
% elec.chanpos(35,1)= elecAligned_edited_58_edited_listed.chanpos(35,1);
% elec.chanpos(35,2)= elecAligned_edited_58_edited_listed.chanpos(35,2);
% elec.chanpos(35,3)= elecAligned_edited_58_edited_listed.chanpos(35,3);
% 
% % 36. F5
% elec.chanpos(36,1)= elecAligned_edited_58_edited_listed.chanpos(36,1);
% elec.chanpos(36,2)= elecAligned_edited_58_edited_listed.chanpos(36,2);
% elec.chanpos(36,3)= elecAligned_edited_58_edited_listed.chanpos(36,3);
% 
% % 37. C1
% elec.chanpos(37,1)= elecAligned_edited_58_edited_listed.chanpos(37,1);
% elec.chanpos(37,2)= elecAligned_edited_58_edited_listed.chanpos(37,2);
% elec.chanpos(37,3)= elecAligned_edited_58_edited_listed.chanpos(37,3);
% 
% % 38. FC3
% elec.chanpos(38,1)= elecAligned_edited_58_edited_listed.chanpos(38,1);
% elec.chanpos(38,2)= elecAligned_edited_58_edited_listed.chanpos(38,2);
% elec.chanpos(38,3)= elecAligned_edited_58_edited_listed.chanpos(38,3);
% 
% % 39. AF4
% elec.chanpos(39,1)= elecAligned_edited_58_edited_listed.chanpos(39,1);
% elec.chanpos(39,2)= elecAligned_edited_58_edited_listed.chanpos(39,2);
% elec.chanpos(39,3)= elecAligned_edited_58_edited_listed.chanpos(39,3);
% 
% % 40. P1
% elec.chanpos(40,1)= elecAligned_edited_58_edited_listed.chanpos(40,1);
% elec.chanpos(40,2)= elecAligned_edited_58_edited_listed.chanpos(40,2);
% elec.chanpos(40,3)= elecAligned_edited_58_edited_listed.chanpos(40,3);
% 
% % 41. P2
% elec.chanpos(41,1)= elecAligned_edited_58_edited_listed.chanpos(41,1);
% elec.chanpos(41,2)= elecAligned_edited_58_edited_listed.chanpos(41,2);
% elec.chanpos(41,3)= elecAligned_edited_58_edited_listed.chanpos(41,3);
% 
% % 42. PO7
% elec.chanpos(42,1)= elecAligned_edited_58_edited_listed.chanpos(42,1);
% elec.chanpos(42,2)= elecAligned_edited_58_edited_listed.chanpos(42,2);
% elec.chanpos(42,3)= elecAligned_edited_58_edited_listed.chanpos(42,3);
% 
% % 43. FCz
% elec.chanpos(43,1)= elecAligned_edited_58_edited_listed.chanpos(43,1);
% elec.chanpos(43,2)= elecAligned_edited_58_edited_listed.chanpos(43,2);
% elec.chanpos(43,3)= elecAligned_edited_58_edited_listed.chanpos(43,3);
% 
% % 44. C2
% elec.chanpos(44,1)= elecAligned_edited_58_edited_listed.chanpos(44,1);
% elec.chanpos(44,2)= elecAligned_edited_58_edited_listed.chanpos(44,2);
% elec.chanpos(44,3)= elecAligned_edited_58_edited_listed.chanpos(44,3);
% 
% % 45. PO8
% elec.chanpos(45,1)= elecAligned_edited_58_edited_listed.chanpos(45,1);
% elec.chanpos(45,2)= elecAligned_edited_58_edited_listed.chanpos(45,2);
% elec.chanpos(45,3)= elecAligned_edited_58_edited_listed.chanpos(45,3);
% 
% % 46. PO2 
% elec.chanpos(46,1)= elecAligned_edited_58_edited_listed.chanpos(46,1);
% elec.chanpos(46,2)= elecAligned_edited_58_edited_listed.chanpos(46,2);
% elec.chanpos(46,3)= elecAligned_edited_58_edited_listed.chanpos(46,3);
% 
% % 47. C5
% elec.chanpos(47,1)= elecAligned_edited_58_edited_listed.chanpos(47,1);
% elec.chanpos(47,2)= elecAligned_edited_58_edited_listed.chanpos(47,2);
% elec.chanpos(47,3)= elecAligned_edited_58_edited_listed.chanpos(47,3);
% 
% % 48. CPZ
% elec.chanpos(48,1)= elecAligned_edited_58_edited_listed.chanpos(48,1);
% elec.chanpos(48,2)= elecAligned_edited_58_edited_listed.chanpos(48,2);
% elec.chanpos(48,3)= elecAligned_edited_58_edited_listed.chanpos(48,3);
% 
% % 49. POz
% elec.chanpos(49,1)= elecAligned_edited_58_edited_listed.chanpos(49,1)-2;
% elec.chanpos(49,2)= elecAligned_edited_58_edited_listed.chanpos(49,2);
% elec.chanpos(49,3)= elecAligned_edited_58_edited_listed.chanpos(49,3)-10;
% 
% % 50. PO1 
% elec.chanpos(50,1)= elecAligned_edited_58_edited_listed.chanpos(50,1);
% elec.chanpos(50,2)= elecAligned_edited_58_edited_listed.chanpos(50,2);
% elec.chanpos(50,3)= elecAligned_edited_58_edited_listed.chanpos(50,3);
% 
% % 51. AF3
% elec.chanpos(51,1)= elecAligned_edited_58_edited_listed.chanpos(51,1);
% elec.chanpos(51,2)= elecAligned_edited_58_edited_listed.chanpos(51,2);
% elec.chanpos(51,3)= elecAligned_edited_58_edited_listed.chanpos(51,3);
% 
% % 52. FC4
% elec.chanpos(52,1)= elecAligned_edited_58_edited_listed.chanpos(52,1);
% elec.chanpos(52,2)= elecAligned_edited_58_edited_listed.chanpos(52,2);
% elec.chanpos(52,3)= elecAligned_edited_58_edited_listed.chanpos(52,3);
% 
% % 53. PO3
% elec.chanpos(53,1)= elecAligned_edited_58_edited_listed.chanpos(53,1)+4;
% elec.chanpos(53,2)= elecAligned_edited_58_edited_listed.chanpos(53,2)+7;
% elec.chanpos(53,3)= elecAligned_edited_58_edited_listed.chanpos(53,3);
% 
% % 54. PO4
% elec.chanpos(54,1)= elecAligned_edited_58_edited_listed.chanpos(54,1)+5;
% elec.chanpos(54,2)= elecAligned_edited_58_edited_listed.chanpos(54,2)-7;
% elec.chanpos(54,3)= elecAligned_edited_58_edited_listed.chanpos(54,3);
% 
% % 55. F6
% elec.chanpos(55,1)= elecAligned_edited_58_edited_listed.chanpos(55,1);
% elec.chanpos(55,2)= elecAligned_edited_58_edited_listed.chanpos(55,2);
% elec.chanpos(55,3)= elecAligned_edited_58_edited_listed.chanpos(55,3);
% 
% % 56. P6
% elec.chanpos(56,1)= elecAligned_edited_58_edited_listed.chanpos(56,1);
% elec.chanpos(56,2)= elecAligned_edited_58_edited_listed.chanpos(56,2);
% elec.chanpos(56,3)= elecAligned_edited_58_edited_listed.chanpos(56,3);
% 
% % 57. P5
% elec.chanpos(57,1)= elecAligned_edited_58_edited_listed.chanpos(57,1);
% elec.chanpos(57,2)= elecAligned_edited_58_edited_listed.chanpos(57,2);
% elec.chanpos(57,3)= elecAligned_edited_58_edited_listed.chanpos(57,3);
% 
% % 58. C6
% elec.chanpos(58,1)= elecAligned_edited_58_edited_listed.chanpos(58,1);
% elec.chanpos(58,2)= elecAligned_edited_58_edited_listed.chanpos(58,2);
% elec.chanpos(58,3)= elecAligned_edited_58_edited_listed.chanpos(58,3);
% 
% elec.elecpos = elec.chanpos;
end
% elecAligned_edited_58_edited_listed_finetuned = elec;

% -------------------------------------------------------------------------
% Loading saved elec
% -------------------------------------------------------------------------
load elecAligned_edited_58_edited_listed_finetuned.mat

% figure;
% %ft_plot_sens(elec, 'elecsize', 40);
% %hold on;
% %ft_plot_sens(elecAligned_edited_58_edited_listed, 'elecsize', 30, 'facecolor', 'red');
% ft_plot_sens(elecAligned_edited_58_edited_listed_finetuned, 'elecsize', 40, 'facecolor', 'red');
% ft_plot_headmodel(headmodel, 'facealpha', 0.5);
% view(90, 0);

elec = elecAligned_edited_58_edited_listed_finetuned;  

%--------------------------------------------------------------------------                  

% Create a Source Model (Component 3)
for foldup = 1:1
% cfg             = [];
% cfg.headmodel   = headmodel; % used to estimate extent of grid
% cfg.resolution  = 10;        % a source per 10 mm
% cfg.inwardshift = 8;         % moving sources 5 mm inwards from the skull, ...
%                              % since BEM models may be unstable here
% %cfg.moveinward = 2;
% 
% sourcemodel = ft_prepare_sourcemodel(cfg);
end

load sourcemodel_Brainnetome.mat

% figure
% hold on
% ft_plot_mesh(sourcemodel, 'vertexsize', 20);
% ft_plot_headmodel(headmodel, 'facealpha', 0.5);
% view(90, 0);

insideSource = sourcemodel;
outsideSource = sourcemodel;

insideSource.pos = sourcemodel.pos(sourcemodel.inside, :);
outsideSource.pos = sourcemodel.pos(~sourcemodel.inside, :);

% figure
% hold on
% ft_plot_mesh(insideSource, 'vertexsize', 20, 'vertexcolor', 'red');
% ft_plot_mesh(outsideSource, 'vertexsize', 20)
% ft_plot_headmodel(headmodel, 'facealpha', 0.1)
% view(125, 10);

%--------------------------------------------------------------------------                  

% Estimate Lead Field (Component 4)
for foldup = 1:1
% cfg = [];
% cfg.sourcemodel = sourcemodel;  % where are the sources?
% cfg.headmodel   = headmodel;    % how do currents spread?
% cfg.elec        = elec;         % where are the sensors?
% 
% % how do sources and sensors connect?
% leadfield = ft_prepare_leadfield(cfg);
end

load leadfield_Brainnetome.mat

% Plotting Lead Field
for foldup = 1:1
figure('units', 'normalized', 'outerposition', [0 0 0.5 0.5])
source_index = 800; %1200; %10 %% a superficial sources
sensory_dipole_current = 100e-1; % Am (realistic) %Test and error until Scale: 1e-5

n_sensors = length(elec.label);

inside_sources = find(leadfield.inside);
inside_index = inside_sources(source_index);
lead = leadfield.leadfield{inside_index};
xs = zeros(1, n_sensors);
ys = zeros(1, n_sensors);
zs = zeros(1, n_sensors);
voltages = zeros(1, n_sensors);
titles = {'Lead field (x)' 'Lead field (y)' 'Lead field (z)'};

% get the xyz and norm
for sensor_index = 1:n_sensors
    this_x = lead(sensor_index, 1);
    this_y = lead(sensor_index, 2);
    this_z = lead(sensor_index, 3);
    this_norm = norm(lead(sensor_index, :));
    xs(sensor_index) = this_x * sensory_dipole_current;
    ys(sensor_index) = this_y * sensory_dipole_current;
    zs(sensor_index) = this_z * sensory_dipole_current;
    voltages(sensor_index) = this_norm * sensory_dipole_current;
end

% plot xyz
axes = {xs ys zs};

for axis_index = 1:3
    this_axis = axes{axis_index};
    subplot(1, 3, axis_index)
    hold on
    ft_plot_topo3d(elec.chanpos, this_axis, 'facealpha', 0.8)
    if strcmp(headmodel.type, 'dipoli')
        caxis([0, 10e-6])
    end
    c = colorbar('location', 'southoutside');
    c.Label.String = 'Lead field (V)';
    caxis([-20e-4, 20e-4])
    axis tight
    ft_plot_mesh(mesh_brain, 'facealpha', 0.10);
    ft_plot_sens(elec, 'elecsize', 20);
    title(titles{axis_index})
    plot3(leadfield.pos(inside_index, 1), ...
      leadfield.pos(inside_index, 2), ...
      leadfield.pos(inside_index, 3), 'bo', ...
      'markersize', 20, 'markerfacecolor', 'r')
end

% plot norm
figure('units', 'normalized', 'outerposition', [0 0 0.5 0.85])
hold on
ft_plot_topo3d(elec.chanpos, voltages, 'facealpha', 0.8)
if strcmp(headmodel.type, 'dipoli')
    caxis([0, 10e-6])
end
c = colorbar('location', 'eastoutside');
c.Label.String = 'Lead field (V)';
caxis([-20e-4, 20e-4])
axis tight
ft_plot_mesh(mesh_brain, 'facealpha', 0.10);
ft_plot_sens(elec, 'elecsize', 20);
title('Leadfield magnitude')
plot3(leadfield.pos(inside_index, 1), ...
  leadfield.pos(inside_index, 2), ...
  leadfield.pos(inside_index, 3), 'bo', ...
  'markersize', 20, 'markerfacecolor', 'r')

view(90, 0);
end

close all;

return;

%% PART IIA1: ALL SUBJECT

%--------------------------------------------------------------------------
%PLEASE CHECK!
datum = '230307';
%--------------------------------------------------------------------------

% SUBJECT INDEXING
for foldup = 1:1
% subject1 = 'ANRO34';
% subject2 = 'ARHE18';
% subject3 = 'AVHE42';
% subject4 = 'AYZE1';
% subject5 = 'DASH32';
% subject6 = 'EDKA28';
% subject7 = 'ELGA29';
% subject8 = 'HIGA12';
% subject9 = 'IDAR24';
% subject10 = 'ITAI51';
% subject11 = 'MICA2';
% subject12 = 'NIAK31';
% subject13 = 'NOSA22';
% subject14 = 'ORCO10';
% subject15 = 'RECO48';
% subject16 = 'REUT46';
% subject17 = 'STLI27';
% subject18 = 'TALK43';
% subject19 = 'YIYE21';
% subject20 = 'YUMO19';
% 
% group = 'NHYoung';
end

for foldup = 1:1
subject1 = 'AKIV75';
subject2 = 'BASH33';
subject3 = 'DAYA62';
subject4 = 'EVEN39';
subject5 = 'FINK38';
subject6 = 'GABI56';
subject7 = 'GRSH52';
subject8 = 'HAIM70';
subject9 = 'HANA54';
subject10 = 'ILAN49';
subject11 = 'MINA36';
subject12 = 'NAVA73';
subject13 = 'OFRA64';
subject14 = 'RASA7';
subject15 = 'RIBM17';
subject16 = 'RIZE4';
subject17 = 'ZEEV71';
subject18 = 'ZETE16';
subject19 = 'ZIYA14';
subject20 = 'LAKO55';

group = 'NHOld';
end

% DATA I/O
%PLEASE CHECK!
%DEFINE Subject
subject = 'AllSubs';

% CONDITION
% Choose MODE 

%--------------------------------------------------------------------------
%PLEASE CHECK!

analysisMODE = 2; %analysisMODE: %3, 5, 7 are problematic in NHOld (Subject20 commented)
                  %1: VIQuiet, 2: VINoise,
                  %3: STQuiet, 4: STNoise,
                  %5: conQuiet, 6: conNoise,
                  %7: inconQuiet, 8: inconNoise,
                     
%--------------------------------------------------------------------------

% Task
switch analysisMODE
    case 1
        Task = 'VIQuiet'; 
        DataNameTFR = 'TFR_VI';
        DataNameTSA = 'TSA_VI';
        task = Task;
    case 2
        Task = 'VINoise';
        DataNameTFR = 'TFR_VI';
        DataNameTSA = 'TSA_VI';
        task = Task;        
    case 3
        Task = 'STQuiet';
        DataNameTFR = 'TFR_ST';
        DataNameTSA = 'TSA_ST';
        task = Task;        
    case 4
        Task = 'STNoise';
        DataNameTFR = 'TFR_ST';
        DataNameTSA = 'TSA_ST';
        task = Task;        
    case 5
        Task = 'STQuiet';
        DataNameTFR = 'TFR_con';
        DataNameTSA = 'TSA_con';
        task = 'conQuiet';        
    case 6
        Task = 'STNoise';
        DataNameTFR = 'TFR_con';
        DataNameTSA = 'TSA_con';
        task = 'conNoise';        
    case 7
        Task = 'STQuiet';
        DataNameTFR = 'TFR_incon';
        DataNameTSA = 'TSA_incon';
        task = 'inconQuiet';        
    case 8
        Task = 'STNoise';
        DataNameTFR = 'TFR_incon';
        DataNameTSA = 'TSA_incon';
        task = 'inconNoise';
end

%--------------------------------------------------------------------------

%INPUT PLOT
if analysisMODE<=2
    inputDataFolder  = ['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\VI\' group '\'];
else
    inputDataFolder  = ['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\ST\'  group '\'];
end

%--------------------------------------------------------------------------
                               
%OUTPUT PLOT
%outputPlotFolder = ['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Plot\' group '\' task '\'];
outputPlotFolder = ['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Plot\_test\' datum '\' group '\' task '\'];
mkdir(outputPlotFolder);

% %OUTPUT DATA
% outputDataFolder = ['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Data\'];        
% mkdir(outputDataFolder);
                             
%--------------------------------------------------------------------------

%Subject20 commented
%Loading dataft_preprocessed_TFR and meanRT Calculation
for foldup = 1:1
% S = load([inputDataFolder '\' subject1 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject1 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject1 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject2 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject2 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject2 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject3 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject3 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject3 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject4 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject4 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject4 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject5 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject5 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject5 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject6 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject6 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject6 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject7 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject7 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject7 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject8 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject8 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject8 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject9 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject9 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject9 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject10 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject10 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject10 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject11 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject11 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject11 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject12 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject12 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject12 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject13 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject13 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject13 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject14 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject14 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject14 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject15 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject15 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject15 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject16 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject16 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject16 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject17 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject17 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject17 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject18 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject18 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject18 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject19 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject19 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject19 = S.(['dataft_preprocessed_TFR']);
% clear S;
% 
% S = load([inputDataFolder '\' subject20 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% load([inputDataFolder '\' subject20 '\' Task '\TFR\SingleChannels\Data\dataft_preprocessed_TFR.mat']);
% dataft_Subject20 = S.(['dataft_preprocessed_TFR']);
% clear S;
end
%clear dataft_preprocessed_TFR

for foldup = 1:1
S = load([inputDataFolder '\' subject1 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject1 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject1 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject2 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject2 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject2 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject3 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject3 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject3 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject4 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject4 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject4 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject5 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject5 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject5 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject6 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject6 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject6 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject7 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject7 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject7 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject8 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject8 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject8 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject9 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject9 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject9 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject10 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject10 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject10 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject11 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject11 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject11 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject12 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject12 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject12 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject13 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject13 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject13 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject14 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject14 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject14 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject15 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject15 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject15 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject16 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject16 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject16 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject17 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject17 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject17 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject18 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject18 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject18 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject19 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject19 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject19 = S.(['dataft_preprocessed_RAW']);
clear S;

S = load([inputDataFolder '\' subject20 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
load([inputDataFolder '\' subject20 '\' Task '\Preprocessing\Data\dataft_preprocessed_RAW.mat']);
dataft_Subject20 = S.(['dataft_preprocessed_RAW']);
clear S;
end
clear dataft_preprocessed_RAW

cfg = [];
% cfg.channel     = {'all', '-EB', '-elB28', '-elB29', '-elB30', '-elB31', '-elB32', '-abdo', '-thor',  '-xyz', '-MKR', '-a1', '-a2', '-VEOR', '-VEOL', '-el064'};
cfg.resamplefs = 500;
%Downsampling 
%Subject20 commented
dataft_Subject1 = ft_resampledata(cfg, dataft_Subject1);
dataft_Subject2 = ft_resampledata(cfg, dataft_Subject2);
dataft_Subject3 = ft_resampledata(cfg, dataft_Subject3);
dataft_Subject4 = ft_resampledata(cfg, dataft_Subject4);
dataft_Subject5 = ft_resampledata(cfg, dataft_Subject5);
dataft_Subject6 = ft_resampledata(cfg, dataft_Subject6);
dataft_Subject7 = ft_resampledata(cfg, dataft_Subject7);
dataft_Subject8 = ft_resampledata(cfg, dataft_Subject8);
dataft_Subject9 = ft_resampledata(cfg, dataft_Subject9);
dataft_Subject10 = ft_resampledata(cfg, dataft_Subject10);
dataft_Subject11 = ft_resampledata(cfg, dataft_Subject11);
dataft_Subject12 = ft_resampledata(cfg, dataft_Subject12);
dataft_Subject13 = ft_resampledata(cfg, dataft_Subject13);
dataft_Subject14 = ft_resampledata(cfg, dataft_Subject14);
dataft_Subject15 = ft_resampledata(cfg, dataft_Subject15);
dataft_Subject16 = ft_resampledata(cfg, dataft_Subject16);
dataft_Subject17 = ft_resampledata(cfg, dataft_Subject17);
dataft_Subject18 = ft_resampledata(cfg, dataft_Subject18);
dataft_Subject19 = ft_resampledata(cfg, dataft_Subject19);
dataft_Subject20 = ft_resampledata(cfg, dataft_Subject20);

%Subject20 commented
if analysisMODE <=4
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

    %Subject20 commented
    else if (analysisMODE == 5 || analysisMODE == 6)
for foldup = 1:1
cfg = [];
cfg.trials = find(dataft_Subject1.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject1.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject1);
meanRT_Subject1 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject1 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject2.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject2.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject2);
meanRT_Subject2 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject2 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject3.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject3.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject3);
meanRT_Subject3 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject3 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject4.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject4.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject4);
meanRT_Subject4 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject4 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject5.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject5.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject5);
meanRT_Subject5 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject5 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject6.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject6.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject6);
meanRT_Subject6 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject6 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject7.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject7.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject7);
meanRT_Subject7 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject7 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject8.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject8.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject8);
meanRT_Subject8 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject8 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject9.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject9.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject9);
meanRT_Subject9 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject9 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject10.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject10.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject10);
meanRT_Subject10 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject10 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject11.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject11.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject11);
meanRT_Subject11 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject11 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject12.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject12.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject12);
meanRT_Subject12 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject12 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject13.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject13.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject13);
meanRT_Subject13 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject13 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject14.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject14.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject14);
meanRT_Subject14 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject14 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject15.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject15.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject15);
meanRT_Subject15 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject15 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject16.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject16.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject16);
meanRT_Subject16 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject16 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject17.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject17.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject17);
meanRT_Subject17 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject17 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject18.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject18.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject18);
meanRT_Subject18 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject18 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject19.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject19.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject19);
meanRT_Subject19 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject19 = dataft_con;

cfg = [];
cfg.trials = find(dataft_Subject20.trialinfo(:,3) == 1);
cfg.trials = [cfg.trials; find(dataft_Subject20.trialinfo(:,3) == 2)]; %trialinfo Column 3 is CONDIndex, ConQuiet -> CONDInd = 1
dataft_con = ft_selectdata(cfg, dataft_Subject20);
meanRT_Subject20 = mean(dataft_con.trialinfo(:,5))/1000;
dataft_Subject20 = dataft_con;

end

    %Subject20 commented
    else
for foldup = 1:1
cfg = [];
cfg.trials = find(dataft_Subject1.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject1.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject1);
meanRT_Subject1 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject1 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject2.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject2.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject2);
meanRT_Subject2 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject2 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject3.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject3.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject3);
meanRT_Subject3 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject3 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject4.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject4.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject4);
meanRT_Subject4 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject4 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject5.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject5.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject5);
meanRT_Subject5 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject5 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject6.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject6.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject6);
meanRT_Subject6 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject6 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject7.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject7.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject7);
meanRT_Subject7 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject7 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject8.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject8.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject8);
meanRT_Subject8 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject8 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject9.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject9.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject9);
meanRT_Subject9 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject9 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject10.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject10.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject10);
meanRT_Subject10 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject10 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject11.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject11.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject11);
meanRT_Subject11 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject11 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject12.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject12.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject12);
meanRT_Subject12 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject12 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject13.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject13.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject13);
meanRT_Subject13 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject13 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject14.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject14.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject14);
meanRT_Subject14 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject14 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject15.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject15.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject15);
meanRT_Subject15 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject15 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject16.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject16.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject16);
meanRT_Subject16 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject16 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject17.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject17.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject17);
meanRT_Subject17 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject17 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject18.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject18.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject18);
meanRT_Subject18 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject18 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject19.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject19.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject19);
meanRT_Subject19 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject19 = dataft_incon;

cfg = [];
cfg.trials = find(dataft_Subject20.trialinfo(:,3) == 3);
cfg.trials = [cfg.trials; find(dataft_Subject20.trialinfo(:,3) == 4)]; %trialinfo Column 3 is CONDIndex, InconQuiet -> CONDInd = 3
dataft_incon = ft_selectdata(cfg, dataft_Subject20);
meanRT_Subject20 = mean(dataft_incon.trialinfo(:,5))/1000;
dataft_Subject20 = dataft_incon;

end
    end
end

meanRT = (meanRT_Subject1 + meanRT_Subject2  + meanRT_Subject3  + meanRT_Subject4  + meanRT_Subject5 +...
         meanRT_Subject6  + meanRT_Subject7  + meanRT_Subject8  + meanRT_Subject9  + meanRT_Subject10 +...
         meanRT_Subject11 + meanRT_Subject12 + meanRT_Subject13 + meanRT_Subject14 + meanRT_Subject15 +...
         meanRT_Subject16 + meanRT_Subject17 + meanRT_Subject18 + meanRT_Subject19 + meanRT_Subject20)/20;

%Subject20 commented
% meanRT = (meanRT_Subject1 + meanRT_Subject2  + meanRT_Subject3  + meanRT_Subject4  + meanRT_Subject5 +...
%          meanRT_Subject6  + meanRT_Subject7  + meanRT_Subject8  + meanRT_Subject9  + meanRT_Subject10 +...
%          meanRT_Subject11 + meanRT_Subject12 + meanRT_Subject13 + meanRT_Subject14 + meanRT_Subject15 +...
%          meanRT_Subject16 + meanRT_Subject17 + meanRT_Subject18 + meanRT_Subject19)/19;

% %Subject2, Subject10, Subject13 commented
% meanRT = (meanRT_Subject1 + meanRT_Subject3  + meanRT_Subject4  + meanRT_Subject5 +...
%          meanRT_Subject6  + meanRT_Subject7  + meanRT_Subject8  + meanRT_Subject9 +...
%          meanRT_Subject11 + meanRT_Subject12 + meanRT_Subject14 + meanRT_Subject15 +...
%          meanRT_Subject16 + meanRT_Subject17 + meanRT_Subject18 + meanRT_Subject19 + meanRT_Subject20)/17;

clear dataft_con dataft_incon

% Choosing Working channels
cfg = [];
cfg.channel     = {'all', '-EB', '-elB28', '-elB29', '-elB30', '-elB31', '-elB32', '-abdo', '-thor',  '-xyz', '-MKR', '-a1', '-a2', '-VEOR', '-VEOL', '-el064'};
dataft_Subject1 = ft_selectdata(cfg, dataft_Subject1);
dataft_Subject2 = ft_selectdata(cfg, dataft_Subject2);
dataft_Subject3 = ft_selectdata(cfg, dataft_Subject3);
dataft_Subject4 = ft_selectdata(cfg, dataft_Subject4);
dataft_Subject5 = ft_selectdata(cfg, dataft_Subject5);
dataft_Subject6 = ft_selectdata(cfg, dataft_Subject6);
dataft_Subject7 = ft_selectdata(cfg, dataft_Subject7);
dataft_Subject8 = ft_selectdata(cfg, dataft_Subject8);
dataft_Subject9 = ft_selectdata(cfg, dataft_Subject9);
dataft_Subject10 = ft_selectdata(cfg, dataft_Subject10);
dataft_Subject11 = ft_selectdata(cfg, dataft_Subject11);
dataft_Subject12 = ft_selectdata(cfg, dataft_Subject12);
dataft_Subject13 = ft_selectdata(cfg, dataft_Subject13);
dataft_Subject14 = ft_selectdata(cfg, dataft_Subject14);
dataft_Subject15 = ft_selectdata(cfg, dataft_Subject15);
dataft_Subject16 = ft_selectdata(cfg, dataft_Subject16);
dataft_Subject17 = ft_selectdata(cfg, dataft_Subject17);
dataft_Subject18 = ft_selectdata(cfg, dataft_Subject18);
dataft_Subject19 = ft_selectdata(cfg, dataft_Subject19);
dataft_Subject20 = ft_selectdata(cfg, dataft_Subject20);

% Rereference Common Avg per Subject
cfg = [];
cfg.reref = 'yes';
cfg.refmethod = 'avg';
cfg.refchannel = dataft_Subject1.label(1:58);
dataft_Subject1 = ft_preprocessing(cfg, dataft_Subject1);
dataft_Subject2 = ft_preprocessing(cfg, dataft_Subject2);
dataft_Subject3 = ft_preprocessing(cfg, dataft_Subject3);
dataft_Subject4 = ft_preprocessing(cfg, dataft_Subject4);
dataft_Subject5 = ft_preprocessing(cfg, dataft_Subject5);
dataft_Subject6 = ft_preprocessing(cfg, dataft_Subject6);
dataft_Subject7 = ft_preprocessing(cfg, dataft_Subject7);
dataft_Subject8 = ft_preprocessing(cfg, dataft_Subject8);
dataft_Subject9 = ft_preprocessing(cfg, dataft_Subject9);
dataft_Subject10 = ft_preprocessing(cfg, dataft_Subject10);
dataft_Subject11 = ft_preprocessing(cfg, dataft_Subject11);
dataft_Subject12 = ft_preprocessing(cfg, dataft_Subject12);
dataft_Subject13 = ft_preprocessing(cfg, dataft_Subject13);
dataft_Subject14 = ft_preprocessing(cfg, dataft_Subject14);
dataft_Subject15 = ft_preprocessing(cfg, dataft_Subject15);
dataft_Subject16 = ft_preprocessing(cfg, dataft_Subject16);
dataft_Subject17 = ft_preprocessing(cfg, dataft_Subject17);
dataft_Subject18 = ft_preprocessing(cfg, dataft_Subject18);
dataft_Subject19 = ft_preprocessing(cfg, dataft_Subject19);
dataft_Subject20 = ft_preprocessing(cfg, dataft_Subject20);

% Combining data all Subjects
dataft_Cond_all = dataft_Subject1;
dataft_Cond_all.trialinfo    = [dataft_Cond_all.trialinfo;  dataft_Subject2.trialinfo;  dataft_Subject3.trialinfo;  dataft_Subject4.trialinfo;  dataft_Subject5.trialinfo; ...
                                dataft_Subject6.trialinfo;  dataft_Subject7.trialinfo;  dataft_Subject8.trialinfo;  dataft_Subject9.trialinfo;  dataft_Subject10.trialinfo; ...
                                dataft_Subject11.trialinfo; dataft_Subject12.trialinfo; dataft_Subject13.trialinfo; dataft_Subject14.trialinfo; dataft_Subject15.trialinfo; ...
                                dataft_Subject16.trialinfo; dataft_Subject17.trialinfo; dataft_Subject18.trialinfo; dataft_Subject19.trialinfo; dataft_Subject20.trialinfo];
dataft_Cond_all.trial         = [dataft_Cond_all.trial      dataft_Subject2.trial       dataft_Subject3.trial       dataft_Subject4.trial       dataft_Subject5.trial ...
                                 dataft_Subject6.trial      dataft_Subject7.trial       dataft_Subject8.trial       dataft_Subject9.trial       dataft_Subject10.trial ...
                                 dataft_Subject11.trial     dataft_Subject12.trial      dataft_Subject13.trial      dataft_Subject14.trial      dataft_Subject15.trial ...
                                 dataft_Subject16.trial     dataft_Subject17.trial      dataft_Subject18.trial      dataft_Subject19.trial      dataft_Subject20.trial];  
dataft_Cond_all.time          = [dataft_Cond_all.time       dataft_Subject2.time        dataft_Subject3.time        dataft_Subject4.time        dataft_Subject5.time ...
                                 dataft_Subject6.time       dataft_Subject7.time        dataft_Subject8.time        dataft_Subject9.time        dataft_Subject10.time ...
                                 dataft_Subject11.time      dataft_Subject12.time       dataft_Subject13.time       dataft_Subject14.time       dataft_Subject15.time ...
                                 dataft_Subject16.time      dataft_Subject17.time       dataft_Subject18.time       dataft_Subject19.time       dataft_Subject20.time]; 

%Subject20 commented
% dataft_Cond_all = dataft_Subject1;
% dataft_Cond_all.trialinfo    = [dataft_Cond_all.trialinfo;  dataft_Subject2.trialinfo;  dataft_Subject3.trialinfo;  dataft_Subject4.trialinfo;  dataft_Subject5.trialinfo; ...
%                                 dataft_Subject6.trialinfo;  dataft_Subject7.trialinfo;  dataft_Subject8.trialinfo;  dataft_Subject9.trialinfo;  dataft_Subject10.trialinfo; ...
%                                 dataft_Subject11.trialinfo; dataft_Subject12.trialinfo; dataft_Subject13.trialinfo; dataft_Subject14.trialinfo; dataft_Subject15.trialinfo; ...
%                                 dataft_Subject16.trialinfo; dataft_Subject17.trialinfo; dataft_Subject18.trialinfo; dataft_Subject19.trialinfo];
% dataft_Cond_all.trial         = [dataft_Cond_all.trial      dataft_Subject2.trial       dataft_Subject3.trial       dataft_Subject4.trial       dataft_Subject5.trial ...
%                                  dataft_Subject6.trial      dataft_Subject7.trial       dataft_Subject8.trial       dataft_Subject9.trial       dataft_Subject10.trial ...
%                                  dataft_Subject11.trial     dataft_Subject12.trial      dataft_Subject13.trial      dataft_Subject14.trial      dataft_Subject15.trial ...
%                                  dataft_Subject16.trial     dataft_Subject17.trial      dataft_Subject18.trial      dataft_Subject19.trial];  
% dataft_Cond_all.time          = [dataft_Cond_all.time       dataft_Subject2.time        dataft_Subject3.time        dataft_Subject4.time        dataft_Subject5.time ...
%                                  dataft_Subject6.time       dataft_Subject7.time        dataft_Subject8.time        dataft_Subject9.time        dataft_Subject10.time ...
%                                  dataft_Subject11.time      dataft_Subject12.time       dataft_Subject13.time       dataft_Subject14.time       dataft_Subject15.time ...
%                                  dataft_Subject16.time      dataft_Subject17.time       dataft_Subject18.time       dataft_Subject19.time]; 

% %Subject2, Subject10, Subject13 commented
% dataft_Cond_all = dataft_Subject1;
% dataft_Cond_all.trialinfo    = [dataft_Cond_all.trialinfo;  dataft_Subject3.trialinfo;  dataft_Subject4.trialinfo;  dataft_Subject5.trialinfo; ...
%                                 dataft_Subject6.trialinfo;  dataft_Subject7.trialinfo;  dataft_Subject8.trialinfo;  dataft_Subject9.trialinfo; ...
%                                 dataft_Subject11.trialinfo; dataft_Subject12.trialinfo; dataft_Subject14.trialinfo; dataft_Subject15.trialinfo; ...
%                                 dataft_Subject16.trialinfo; dataft_Subject17.trialinfo; dataft_Subject18.trialinfo; dataft_Subject19.trialinfo; dataft_Subject20.trialinfo];
% dataft_Cond_all.trial         = [dataft_Cond_all.trial      dataft_Subject3.trial       dataft_Subject4.trial       dataft_Subject5.trial ...
%                                  dataft_Subject6.trial      dataft_Subject7.trial       dataft_Subject8.trial       dataft_Subject9.trial ...
%                                  dataft_Subject11.trial     dataft_Subject12.trial      dataft_Subject14.trial      dataft_Subject15.trial ...
%                                  dataft_Subject16.trial     dataft_Subject17.trial      dataft_Subject18.trial      dataft_Subject19.trial      dataft_Subject20.trial];  
% dataft_Cond_all.time          = [dataft_Cond_all.time       dataft_Subject3.time        dataft_Subject4.time        dataft_Subject5.time ...
%                                  dataft_Subject6.time       dataft_Subject7.time        dataft_Subject8.time        dataft_Subject9.time ...
%                                  dataft_Subject11.time      dataft_Subject12.time       dataft_Subject14.time       dataft_Subject15.time ...
%                                  dataft_Subject16.time      dataft_Subject17.time       dataft_Subject18.time       dataft_Subject19.time       dataft_Subject20.time]; 
 
dataft_aktuell = dataft_Cond_all;

% SAVING Data dataft_Cond_All
% Commented
for foldup = 1:1
% 	savingDataOn    = 1;
% 	outputDataName = ['dataft_Cond_all'];
% 	eval([outputDataName '= dataft_Cond_all']);
% 
% 	if savingDataOn == 1
%         S.(outputDataName) = dataft_Cond_all;
%         save([outputDataFolder outputDataName '_' datum '.mat'], '-struct', 'S');
%         save([outputDataFolder 'dataft_Cond_all.mat'], 'dataft_Cond_all');        
%         savingDataOn = 0;
%     end
%         clear outputDataName
%         clear S
end

%Clearing Individual Data
clear TSA_Subject1  TSA_Subject2  TSA_Subject3  TSA_Subject4  TSA_Subject5 ...
      TSA_Subject6  TSA_Subject7  TSA_Subject8  TSA_Subject9  TSA_Subject10 ...
      TSA_Subject11 TSA_Subject12 TSA_Subject13 TSA_Subject14 TSA_Subject15 ...
      TSA_Subject16 TSA_Subject17 TSA_Subject18 TSA_Subject19 TSA_Subject20

clear dataft_Subject1  dataft_Subject2  dataft_Subject3  dataft_Subject4  dataft_Subject5 ...
      dataft_Subject6  dataft_Subject7  dataft_Subject8  dataft_Subject9  dataft_Subject10 ...
      dataft_Subject11 dataft_Subject12 dataft_Subject13 dataft_Subject14 dataft_Subject15 ...
      dataft_Subject16 dataft_Subject17 dataft_Subject18 dataft_Subject19 dataft_Subject20 ...
   
%return;

%% PART III: SOURCE LOCALIZATION    

%--------------------------------------------------------------------------
%PLEASE CHECK!

for freqBandMODE = [3:3] %Repeat over freqBandMODE

% freqBandMODE = 1;     %DeltaEarly   (S)
% freqBandMODE = 2;     %DeltaLate    (S)

% freqBandMODE = 3;     %ThetaEarly   (S)
% freqBandMODE = 4;     %ThetaLate    (S)

% freqBandMODE = 5;     %AlphaEarly   (D)
% freqBandMODE = 6;     %AlphaLate    (S)

% freqBandMODE = 7;     %BetaSynchEarly (S)
% freqBandMODE = 8;     %BetaDesynchEarly(D)
% freqBandMODE = 9;     %BetaLate     (S)

%                     %analysisMODE: 
%                     %1: DeltaEarly (S),       2: DeltaLate (S),  
%                     %3: ThetaEarly (S),       4: ThetaLate (S),        
%                     %5: AlphaEarly (D),       6: AlphaLate (S),        
%                     %7: LowBetaEarly (S),     8: HighBetaEarly (D),    9: BetaLate (S);  
%                     (%10:GammaEarly,          11: GammaLate;)
%                     (%12: AllFreqEarly;       13: AllFreqLate;)
%--------------------------------------------------------------------------

%THE BRAIN
    for foldup = 1:1

    % Task
    switch freqBandMODE
        case 1
            freqBand        = 'DeltaEarly';
            baselineStart   = -0.2;
            baselineEnd     = -0.8;%-0.8;
            timeStart       = 0.2;
            timeEnd         = 0.8;
            freqStart       = 2;
            freqEnd         = 3;
            label           = ['\delta (' num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];
        case 2
            freqBand        = 'DeltaLate';
            baselineStart   = -0.2;
            baselineEnd     = -0.8;%-0.8;
            timeStart       = 1.2;
            timeEnd         = 1.8;
            freqStart       = 2;
            freqEnd         = 3;
            label           = ['\delta (' num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];
        case 3
            freqBand        = 'ThetaEarly';
            baselineStart   = -0.2;
            baselineEnd     = -0.9;
            timeStart       = 0; %0.2;
            timeEnd         = 0.7; %0.8;
            freqStart       = 4;%4;
            freqEnd         = 8;%8;
            label           = ['\theta ('  num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];       
        case 4 
            freqBand        = 'ThetaLate';
            baselineStart   = -0.2;
            baselineEnd     = -0.8;
            timeStart       = 1.2;
            timeEnd         = 1.8;        
            freqStart       = 4;
            freqEnd         = 8;
            label           = ['\theta ('  num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)']; 
        case 5
            freqBand        = 'AlphaEarly';
            baselineStart   = -0.2;
            baselineEnd     = -0.6;
            timeStart       = 0.2;
            timeEnd         = 0.6;
            freqStart       = 8;
            freqEnd         = 12; %Standard: 12
            label           = ['\alpha ('  num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];
        case 6
            freqBand        = 'AlphaLate';
            baselineStart   = -0.2;
            baselineEnd     = -0.6;    
            timeStart       = 1.2;
            timeEnd         = 1.6;
            freqStart       = 8;
            freqEnd         = 12;
            label           = [ '\alpha (' num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)']; 
        case 7
            freqBand        = 'BetaSynchEarly';
            baselineStart   = -0.2; 
            baselineEnd     = -0.6;
            timeStart       = 0.2;
            timeEnd         = 0.6; 
            freqStart       = 13;  
            freqEnd         = 18; %16
            label           = ['\beta Synch('  num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];
        case 8
            freqBand        = 'BetaDesynchEarly';
            baselineStart   = -0.2;
            baselineEnd     = -0.8;
            timeStart       = 0;
            timeEnd         = 0.6; 
            freqStart       = 13;
            freqEnd         = 30;  
            label           = ['\beta Desynch ('  num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];            
        case 9
            freqBand        = 'BetaLate';
            baselineStart   = -0.2;
            baselineEnd     = -0.8;    
            timeStart       = 0.8;
            timeEnd         = 1.4; 
            freqStart       = 13;
            freqEnd         = 30;
            label           = ['\beta (' num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)']; 
        case 10
            freqBand        = 'GammaEarly';
            baselineStart   = -0.2;
            baselineEnd     = -0.4;    
            timeStart       = 0.2;
            timeEnd         = 0.4;
            freqStart       = 30;
            freqEnd         = 120;
            label           = [ '\Gamma (' num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)']; 
        case 11
            freqBand        = 'GammaLate';
            baselineStart   = -0.2;
            baselineEnd     = -0.3;    
            timeStart       = 1.2;
            timeEnd         = 1.3;
            freqStart       = 30;
            freqEnd         = 120;
            label           = ['\Gamma (' num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];              
        case 12
            freqBand        = 'AllFrequenzEarly';
            baselineStart   = -0.2;
            baselineEnd     = -0.3;    
            timeStart       = 0.05;
            timeEnd         = 0.15;
            freqStart       = 2;
            freqEnd         = 120;
            label           = [ 'All Frequenz (' num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)']; 
        case 13
            freqBand        = 'AllFrequenzLate';
            baselineStart   = -0.2;
            baselineEnd     = -0.3;    
            timeStart       = 1.2;
            timeEnd         = 1.3;
            freqStart       = 2;
            freqEnd         = 120;
            label           = ['All Frequenz (' num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];            
    end

    %mkdir([outputPlotFolder '/' freqBand '/ohneContrast']);
    mkdir([outputPlotFolder '/' freqBand '/mitContrast']);

    % Cross Spectral Density Matrix

    %--------------------------------------------------------------------------
    % DEFINE FreqBands
    %--------------------------------------------------------------------------
    for foldup = 1:1
    % % Delta Theta
    % freqBand = DeltaTheta;

    % % Alpha
    % freqBand = Alpha;

    % % Beta Late
    % freqBand = BetaLate;

    % % Theta Late
    % freqBand = ThetaLate;

    % % Theta Early
    % freqBand = ThetaEarly;
    end

    %--------------------------------------------------------------------------
    % DEFINE TOI
    %--------------------------------------------------------------------------

    % Baseline
    for foldup = 1:1
    % % Delta Theta
    % baselineStart = -0.2;
    % baselineEnd = -0.45;

    % % Alpha
    % baselineStart = 0;
    % baselineEnd = -0.6;

    % % Beta Late
    % baselineStart = 0;
    % baselineEnd = -0.4;

    % % Theta Late
    % baselineStart = 0;
    % baselineEnd = -0.4

    % % Theta Early
    % baselineStart = 0;
    % baselineEnd = -0.4;
    end
    cfg = [];
    cfg.toilim = [baselineEnd baselineStart];
    dataft_pre = ft_redefinetrial(cfg, dataft_aktuell);

    %---

    % TOI
    for foldup = 1:1
    % % Delta Theta
    % timeStart   = 0;
    % timeEnd     = 0.25;

    % % Alpha
    % timeStart   = 0.2;
    % timeEnd     = 0.8;

    % % Beta Late
    % timeStart   = 0.8;
    % timeEnd     = 1.2;

    % % Theta Late
    % timeStart   = 1.2;
    % timeEnd     = 1.6;

    % % Theta Early
    % timeStart   = 0;
    % timeEnd     = 0.4;
    end
    % JUNK
    for foldup = 1:1
    %timeStep    = 0.4; %see toilim Baseline   

    % nTime = ((timeEnd - timeStart)/timeStep)+1;
    % timeVector = linspace(timeStart,timeEnd,round(nTime));
    % 
    % %How many toi will depend on nTime (nTime-1)
    % toi1 = [timeVector(1) timeVector(2)];
    % toi2 = [timeVector(2) timeVector(3)];
    % toi3 = [timeVector(3) timeVector(4)];
    % toi4 = [timeVector(4) timeVector(5)];
    % toi5 = [timeVector(5) timeVector(6)];
    % toi6 = [timeVector(6) timeVector(7)];
    % 
    % cfg = [];
    % cfg.toilim = toi1;
    % dataft_post1 = ft_redefinetrial(cfg, dataft_aktuell);
    % 
    % cfg.toilim = toi2;
    % dataft_post2 = ft_redefinetrial(cfg, dataft_aktuell);
    % 
    % cfg.toilim = toi3;
    % dataft_post3 = ft_redefinetrial(cfg, dataft_aktuell);
    % 
    % cfg.toilim = toi4;
    % dataft_post4 = ft_redefinetrial(cfg, dataft_aktuell);
    % 
    % cfg.toilim = toi5;
    % dataft_post5 = ft_redefinetrial(cfg, dataft_aktuell);
    % 
    % cfg.toilim = toi6;
    % dataft_post6 = ft_redefinetrial(cfg, dataft_aktuell);
    end

    cfg = [];
    cfg.toilim = [timeStart timeEnd];
    dataft_post = ft_redefinetrial(cfg, dataft_aktuell);

    %--------------------------------------------------------------------------
    % DEFINE FOI
    %--------------------------------------------------------------------------

    for foldup = 1:1
    % freqStart = 1;
    % freqEnd   = 35;

    % % Delta %unused
    % freqStart = 2;
    % freqEnd   = 4;
    % label = ['\delta ('  num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)']

    % % Delta-Theta
    % freqStart = 1;
    % freqEnd   = 8;
    % label = ['\delta - \theta ('  num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];

    % % Alpha
    % freqStart = 8;
    % freqEnd   = 13;
    % label = ['\alpha ('  num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];

    % % Beta
    % freqStart = 13;
    % freqEnd   = 23;
    % label = [ '\beta (' num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];

    % % Theta
    % freqStart = 4;
    % freqEnd   = 8;
    % label = ['\theta ('  num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];

    % %Beta %unused
    % freqStart = 13;
    % freqEnd   = 30;
    % label = ['\beta ('  num2str(freqStart) ' Hz - ' num2str(freqEnd) ' Hz)'];
    end

    freqMid = (freqEnd + freqStart)/2;
    choosenFreq     = ceil(freqMid);
    choosenFreqLim  = [choosenFreq choosenFreq];
    taper = freqEnd - freqMid;
    
    %taper =  freqEnd-freqStart;
    %taper = ceil(1/(timeEnd-timeStart)); %in Hz
    %taper = 1/(timeEnd-timeStart); %in Hz
    %choosenFreqLim  = [freqStart+taper freqEnd-taper];
    %choosenFreqLim = [freqStart freqEnd];

    %--------------------------------------------------------------------------
    % DEFINE lambda
    %--------------------------------------------------------------------------
    lambda = '10%';
    
    %--------------------------------------------------------------------------
    
    % mitContrast
    cfg = [];
    cfg.method      = 'mtmfft';
    cfg.output      = 'powandcsd';
    cfg.taper       = 'dpss';
    cfg.keeptrials  = 'yes';
    cfg.channel     = {'all', '-EB', '-elB28', '-elB29', '-elB30', '-elB31', '-elB32', '-abdo', '-thor',  '-xyz', '-MKR', '-a1', '-a2', '-VEOR', '-VEOL', '-el064'};
    cfg.tapsmofrq   = taper;
    %cfg.foi   = choosenFreq;
    cfg.foilim   = choosenFreqLim;
    TFR_pre = ft_freqanalysis(cfg, dataft_pre);

    %---

    cfg = [];
    cfg.method      = 'mtmfft';
    cfg.output      = 'powandcsd';
    cfg.taper       = 'dpss';
    cfg.keeptrials  = 'yes';
    cfg.channel     = {'all', '-EB', '-elB28', '-elB29', '-elB30', '-elB31', '-elB32', '-abdo', '-thor',  '-xyz', '-MKR', '-a1', '-a2', '-VEOR', '-VEOL', '-el064'};
    cfg.tapsmofrq   = taper;
    %cfg.foi   = choosenFreq;
    cfg.foilim   = choosenFreqLim;
    TFR_post = ft_freqanalysis(cfg, dataft_post);

    %---
    
    % mitContrast
    dataft_prepost = ft_appenddata([], dataft_pre, dataft_post);
    cfg = [];
    cfg.method      = 'mtmfft';
    cfg.output      = 'powandcsd';
    cfg.taper       = 'dpss';
    cfg.keeptrials  = 'yes';
    cfg.channel     = {'all', '-EB', '-elB28', '-elB29', '-elB30', '-elB31', '-elB32', '-abdo', '-thor',  '-xyz', '-MKR', '-a1', '-a2', '-VEOR', '-VEOL', '-el064'};
    cfg.tapsmofrq   = taper;
    %cfg.foi     = choosenFreq;
    cfg.foilim   = choosenFreqLim;
    TFR_prepost = ft_freqanalysis(cfg, dataft_prepost);

    %---
    %---

    % mitContrast
    % Filter
    cfg                     = [];
    cfg.method              = 'dics';
    cfg.frequency           = choosenFreqLim;
    cfg.sourcemodel         = leadfield;
    cfg.headmodel           = headmodel;
%     cfg.rawtrial            = 'yes';
%     cfg.keeptrials          = 'yes';
    cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
    cfg.dics.projectnoise   = 'yes';
    cfg.dics.lambda         = lambda;
    cfg.dics.keepfilter     = 'yes';
    cfg.dics.realfilter     = 'yes';  
    source_prepost = ft_sourceanalysis(cfg, TFR_prepost);

    %---
    %---
    
    cfg                     = [];
    cfg.method              = 'dics';
    cfg.frequency           = choosenFreqLim;
    cfg.sourcemodel         = leadfield;
    cfg.headmodel           = headmodel;
%     cfg.rawtrial            = 'yes';
%     cfg.keeptrials          = 'yes';
    cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
    cfg.dics.projectnoise   = 'yes';
    cfg.dics.lambda         = lambda;
    cfg.dics.keepfilter     = 'yes';
    cfg.dics.realfilter     = 'yes';  
    
    % mitContrast
    cfg.sourcemodel.filter  = source_prepost.avg.filter; %Last Stand: must be commented
    source_pre_mcon  = ft_sourceanalysis(cfg, TFR_pre);
    source_post_mcon = ft_sourceanalysis(cfg, TFR_post);
    source_diff = source_post_mcon;
    source_diff.avg.pow = (source_post_mcon.avg.pow - source_pre_mcon.avg.pow) ./ source_pre_mcon.avg.pow;
    %source_diff.avg.pow = (source_post_mcon.avg.pow - source_pre_mcon.avg.pow) ./ (source_post_mcon.avg.pow + source_pre_mcon.avg.pow);
    %source_diff.avg.pow = (source_post_mcon.avg.pow - source_pre_mcon.avg.pow);
    %source_diff.avg.pow = source_pre_mcon.avg.pow ./ source_pre_mcon.avg.noise;
    %source_diff.avg.pow = (source_post_mcon.avg.pow);
    %source_diff.avg.pow = (source_post_mcon.avg.pow - source_pre_mcon.avg.pow) ./ source_prepost.avg.noise;
    %source_diff.avg.pow = ((source_post_mcon.avg.pow) ./ (source_post_mcon.avg.noise)) - ((source_pre_mcon.avg.pow) ./ (source_pre_mcon.avg.noise));
    %maxval = max((source_diff.avg.pow));

%     % ohneContrast
%     source_post_ocon = ft_sourceanalysis(cfg, TFR_post);
%     source_diff = source_post_ocon;
%     source_diff.avg.pow = source_post_ocon.avg.pow ./ source_post_ocon.avg.noise;

 if (freqBandMODE == 5)||(freqBandMODE == 8) 
    % De-Synchronization
    %source_diff.avg.pow = min(source_diff.avg.pow, 0);
    source_diff.avg.pow(source_diff.avg.pow>0) = NaN;
 else
    % Synchronization
    %source_diff.avg.pow = max(source_diff.avg.pow, 0);
    source_diff.avg.pow(source_diff.avg.pow<0) = NaN;
 end
    
    % Normalisierung
    %maxval = max((source_diff.avg.pow));
    absval = abs(source_diff.avg.pow);
    maxval = max(absval);
    %maxval = round (maxval,2);
    source_diff.avg.pow = source_diff.avg.pow ./ maxval;

    end 

%return;

%% PLOTTING and ATLAS REGRISTRATION

% Set default colormap in matlab to RdBu instead of jet
ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
set(0,'DefaultFigureColormap',flipud(brewermap(20,'RdBu')));
%set(0,'DefaultFigureColormap',brewermap(20,'OrRd'));
%set(0,'DefaultFigureColormap',flipud(brewermap(20,'PuBu')));

for foldup = 1:1
absPows = abs(source_diff.avg.pow);
maxPow = max(absPows);
%maxPow = round (maxPow,2);

% Mask Threshold %more means more specific spacially
for foldup = 1:1
% Delta-Theta
% % Delta-Theta VIQuiet
% threshold = 0.5*maxPow;
% % Delta-Theta VINoise
% threshold = 0.7*maxPow;
% % Delta-Theta STQuiet
% threshold = 0.5*maxPow;
% % Delta-Theta STNoise
% threshold = 0.8*maxPow;

% Alpha
% % Alpha VIQuiet
% threshold = 0.5*maxPow;
% % Alpha VINoise
% threshold = 0.6*maxPow;
% % Alpha STQuiet
% threshold = 0.5*maxPow;
% % Alpha STNoise
% threshold = 0.6*maxPow;

% Beta
% % Beta VIQuiet
% threshold = 0.75*maxPow;
% % Beta VINoise
% threshold = 0.8*maxPow;
% % Beta STQuiet
% threshold = 0.8*maxPow;
% % Beta STNoise
% threshold = 0.6*maxPow;

% Theta Late
% % Theta Late VIQuiet
% threshold = 0.6*maxPow;
% % Theta Late VINoise
% threshold = 0.7*maxPow
% % Theta Late STQuiet
% threshold = 0.6*maxPow;
% % Theta Late STNoise
% threshold = 0.7*maxPow

% Theta Early
% % Theta Early VIQuiet
% threshold = 0.75*maxPow;
% % Theta Early VINoise
% threshold = 0.7*maxPow
% % Theta Early STQuiet
% threshold = 0.8*maxPow;
% % Theta Early STQuiet
% threshold = 0.75*maxPow;
end
threshold = 0.5*maxPow;
%threshold = round(threshold,2);
%  if (freqBandMODE == 5)||(freqBandMODE == 8)
%     ticks = [-maxPow, -threshold, 0];
%  else
%     ticks = [0, threshold, maxPow];
%  end
ticks = [-maxPow, -threshold, 0, threshold, maxPow];

%--------
% Plot 3D
%--------

%source_diff-CS is 'ctf'
source_diff_ctf = source_diff;
source_diff_ctf.coordsys = 'ctf'; %ctf = als
% %Check CS
% cfg = [];
% source_diff_ctf_coordinatesystem = ft_determine_coordsys(source_diff_ctf); %Ans: n  

% Convert source_diff_ctf to 'acpc' = 'mni'
source_diff_mni = ft_convert_coordsys(source_diff_ctf, 'mni'); %mni = acpc = ras
source_diff_mni.coordsys = 'mni'; %acpc = mni
% %Check CS
% cfg = [];
% source_diff_mni_coordinatesystem = ft_determine_coordsys(source_diff_mni); %Ans: n  

% 3D 
%Surface-inflated-CS is 'mni'
for foldup = 1:1
cfg = [];
cfg.method         = 'surface';
cfg.funparameter   = 'pow';
cfg.projmethod     = 'nearest';
cfg.surfinflated   = 'surface_inflated_both_caret.mat'; %'surface_white_both.mat'
%cfg.surfdownsample = 10
cfg.camlight       = 'no';
cfg.projthresh     = 0.5; %more mean less projection
%  if (freqBandMODE == 5)||(freqBandMODE == 8)
%     cfg.funcolorlim    = [-maxPow 0];
%  else
%      cfg.funcolorlim   = [0 maxPow];
%  end
cfg.funcolorlim    = [-maxPow maxPow];

%--------
% Right view
%--------
% cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
cfg.title = [group newline task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
%cfg.colorbartext = strcat('Activation (normalized to max. abs.)');
cfg.colorbartext = strcat('Difference/Baseline (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
ft_sourceplot(cfg, source_diff_mni);
light ('Position',[0 0 40])
light ('Position',[0 20 0])
material dull;
view ([90 0]);
camzoom(0.75);
ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
%  if (freqBandMODE == 5)||(freqBandMODE == 8)
%     colormap(flipud(brewermap(20,'PuBu')));
%  else
%     colormap((brewermap(20,'OrRd'))); 
%  end
colormap(RedBlueTFR0p5);
c = colorbar;
c.Ticks = ticks;
%ylabel (c, strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
ylabel (c, strcat('Difference/Baseline (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
%ylabel (c, strcat('Activation (normalized to max. abs.)'));

    %---
    % SAVING Plot Option
    savingPlotOn    = 1;
    outputPlotName = ['Beamforming_' group '_' task '_SurfaceR_' datum];
    
    if savingPlotOn == 1
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.fig']);      
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.pdf']);
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.fig']); 
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.pdf']);
        savingPlotOn = 0;
    end
    clear outputPlotName;
    %---

%--------    
% Left view
%--------
% cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
%cfg.title = [group newline task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
%cfg.colorbartext = strcat('Activation (normalized to max. abs.)');
cfg.colorbartext = strcat('Difference/Baseline (norm. to abs. max) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
ft_sourceplot(cfg, source_diff_mni);
light ('Position',[0 0 40])
light ('Position',[0 20 0])
material dull;
view ([-90 0]);
camzoom(0.75);
ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
%  if (freqBandMODE == 5)||(freqBandMODE == 8)
%     colormap(flipud(brewermap(20,'PuBu')));
%  else
%     colormap((brewermap(20,'OrRd'))); 
%  end
colormap(RedBlueTFR0p5);
c = colorbar;
c.Ticks = ticks;
%ylabel (c, strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
ylabel (c, strcat('Difference/Baseline (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
%ylabel (c, strcat('Activation (normalized to max. abs.)'));

    %---
    % SAVING Plot Option
    savingPlotOn    = 1;
    outputPlotName = ['Beamforming_' group '_' task '_SurfaceL_' datum];
    
    if savingPlotOn == 1
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.fig']);      
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.pdf']);
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.fig']); 
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.pdf']);
        savingPlotOn = 0;
    end
    clear outputPlotName;
    %---

%--------    
% Top view
%--------
% cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
cfg.title = [group newline task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
%cfg.colorbartext = strcat('Activation (normalized to max. abs.)');
cfg.colorbartext = strcat('Difference/Baseline (norm. to abs. max) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
ft_sourceplot(cfg, source_diff_mni);
light ('Position',[0 0 0])
light ('Position',[0 20 0])
material dull;
view ([180 60]);
camzoom(0.65);
ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
%  if (freqBandMODE == 5)||(freqBandMODE == 8)
%     colormap(flipud(brewermap(20,'PuBu')));
%  else
%     colormap((brewermap(20,'OrRd'))); 
%  end
colormap(RedBlueTFR0p5);
c = colorbar;
c.Ticks = ticks;
%ylabel (c, strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
ylabel (c, strcat('Difference/Baseline (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
%ylabel (c, strcat('Activation (normalized to max. abs.)'));

    %---
    % SAVING Plot Option
    savingPlotOn    = 1;
    outputPlotName = ['Beamforming_' group '_' task '_SurfaceT_' datum];
    
    if savingPlotOn == 1
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.fig']);      
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.pdf']);
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.fig']); 
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.pdf']);
        savingPlotOn = 0;
    end
    clear outputPlotName;
    %---

%--------
% Bottom view
%--------
% cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
cfg.title = [group newline task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
%cfg.colorbartext = strcat('Activation (normalized to max. abs.)');
cfg.colorbartext = strcat('Difference/Baseline (norm. to abs. max) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
ft_sourceplot(cfg, source_diff_mni);
light ('Position',[0 0 0])
light ('Position',[0 0 40])
material dull;
view ([180 -60]);
camzoom(0.65);
ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
%  if (freqBandMODE == 5)||(freqBandMODE == 8)
%     colormap(flipud(brewermap(20,'PuBu')));
%  else
%     colormap((brewermap(20,'OrRd'))); 
%  end
colormap(RedBlueTFR0p5);
c = colorbar;
c.Ticks = ticks;
%ylabel (c, strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
ylabel (c, strcat('Difference/Baseline (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
%ylabel (c, strcat('Activation (normalized to max. abs.)'));

    %---
    % SAVING Plot Option
    savingPlotOn    = 1;
    outputPlotName = ['Beamforming_' group '_' task '_SurfaceBt_' datum];
    
    if savingPlotOn == 1
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.fig']);      
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.pdf']);
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.fig']); 
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.pdf']);
        savingPlotOn = 0;
    end
    clear outputPlotName;
    %---    

%--------    
% Front view
%--------
% cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
cfg.title = [group newline task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];cfg.colorbartext = strcat('Difference [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
%cfg.colorbartext = strcat('Activation (normalized to max. abs.)');
cfg.colorbartext = strcat('Difference/Baseline (norm. to abs. max) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
ft_sourceplot(cfg, source_diff_mni);
light ('Position',[0 0 40])
light ('Position',[0 20 0])
material dull;
view ([180 0]);
camzoom(0.65);
ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
%  if (freqBandMODE == 5)||(freqBandMODE == 8)
%     colormap(flipud(brewermap(20,'PuBu')));
%  else
%     colormap((brewermap(20,'OrRd'))); 
%  end
colormap(RedBlueTFR0p5);
c = colorbar;
c.Ticks = ticks;
%ylabel (c, strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
ylabel (c, strcat('Difference/Baseline (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
%ylabel (c, strcat('Activation (normalized to max. abs.)'));

    %---
    % SAVING Plot Option
    savingPlotOn    = 1;
    outputPlotName = ['Beamforming_' group '_' task '_SurfaceF_' datum];
    
    if savingPlotOn == 1
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.fig']);      
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.pdf']);
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.fig']); 
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.pdf']);
        savingPlotOn = 0;
    end
    clear outputPlotName;
    %---

%--------
% Back view
%--------
% cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
cfg.title = [group newline task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];cfg.colorbartext = strcat('Difference [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
%cfg.colorbartext = strcat('Activation (normalized to max. abs.)');
cfg.colorbartext = strcat('Difference/Baseline (norm. to abs. max) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
ft_sourceplot(cfg, source_diff_mni);
light ('Position',[0 0 40])
light ('Position',[0 20 0])
material dull;
view ([0 0]);
camzoom(0.65);
ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
%  if (freqBandMODE == 5)||(freqBandMODE == 8)
%     colormap(flipud(brewermap(20,'PuBu')));
%  else
%     colormap((brewermap(20,'OrRd'))); 
%  end
colormap(RedBlueTFR0p5);
c = colorbar;
c.Ticks = ticks;
%ylabel (c, strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
ylabel (c, strcat('Difference/Baseline (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
%ylabel (c, strcat('Activation (normalized to max. abs.)'));

    %---
    % SAVING Plot Option
    savingPlotOn    = 1;
    outputPlotName = ['Beamforming_' group '_' task '_SurfaceBk_' datum];
    
    if savingPlotOn == 1
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.fig']);      
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.pdf']);
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.fig']); 
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.pdf']);
        savingPlotOn = 0;
    end
    clear outputPlotName;
    %---

%--------
% Right Inside view
%--------
% cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
cfg.title = [group newline task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
%cfg.colorbartext = strcat('Activation (normalized to max. abs.)');
%cfg.colorbartext = strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
cfg.colorbartext = strcat('Difference/Baseline (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
ft_sourceplot(cfg, source_diff_mni);
light ('Position',[0 0 40])
light ('Position',[0 20 0])
material dull;
view ([180, 0]);
camzoom(0.75);
ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
%  if (freqBandMODE == 5)||(freqBandMODE == 8)
%     colormap(flipud(brewermap(20,'PuBu')));
%  else
%     colormap((brewermap(20,'OrRd'))); 
%  end
colormap(RedBlueTFR0p5);
c = colorbar;
c.Ticks = ticks;
%ylabel (c, strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
ylabel (c, strcat('Difference/Baseline (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
%ylabel (c, strcat('Activation (normalized to max. abs.)'));
set(gca, 'XLim', get(gca, 'XLim')+160);
view ([-90, 0]);
    %---
    % SAVING Plot Option
    savingPlotOn    = 1;
    outputPlotName = ['Beamforming_' group '_' task '_SurfaceRI_' datum];
    
    if savingPlotOn == 1
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.fig']);      
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.pdf']);
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.fig']); 
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.pdf']);
        savingPlotOn = 0;
    end
    clear outputPlotName;
    %---    

%--------
% Left Inside view
%--------
% cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
%cfg.title = [group newline task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
%cfg.colorbartext = strcat('Activation (normalized to max. abs.)');
%cfg.colorbartext = strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
cfg.colorbartext = strcat('Difference/Baseline (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
ft_sourceplot(cfg, source_diff_mni);
light ('Position',[0 0 40])
light ('Position',[0 20 0])
material dull;
view ([180, 0]);
camzoom(0.75);
ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
%  if (freqBandMODE == 5)||(freqBandMODE == 8)
%     colormap(flipud(brewermap(20,'PuBu')));
%  else
%     colormap((brewermap(20,'OrRd'))); 
%  end
colormap(RedBlueTFR0p5);
c = colorbar;
c.Ticks = ticks;
%ylabel (c, strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
ylabel (c, strcat('Difference/Baseline (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
%ylabel (c, strcat('Activation (normalized to max. abs.)'));
set(gca, 'XLim', get(gca, 'XLim')-160);
view ([90, 0]);
    %---
    % SAVING Plot Option
    savingPlotOn    = 1;
    outputPlotName = ['Beamforming_' group '_' task '_SurfaceLI_' datum];
    
    if savingPlotOn == 1
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.fig']);      
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.pdf']);
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.fig']); 
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.pdf']);
        savingPlotOn = 0;
    end
    clear outputPlotName;
    %---    
    
end

%close all;

%--------
% Plot 2D
%--------
% Interestingly Brainnetome-CS is 'mni' but source_diff_mri-CS is 'ctf' but the result is correct

% Load Atlas
brainnetome = ft_read_atlas('C:\Program Files\MATLAB\R2020b\toolbox\fieldtrip-mastar\fieldtrip-20201113\template\atlas\brainnetome\BNA_MPM_thr25_1.25mm.nii')
atlas = brainnetome;

% Load MRI
% mri = ft_read_mri('C:\Program Files\MATLAB\R2020b\toolbox\fieldtrip-mastar\fieldtrip-20201113\template\anatomy\single_subj_T1.nii');
mri = ft_read_mri('Subject01.mri'); %mri-CS is 'ctf'
% %Check CS
% cfg = [];
% mri_coordinatesystem = ft_determine_coordsys(mri); %Ans: n  

% Interpolate the source_diff to the MRI
cfg = [];
cfg.voxelcoord      = 'no';
cfg.parameter       = 'pow';
cfg.interpmethod    = 'nearest';
source_diff_mri = ft_sourceinterpolate(cfg, source_diff, mri);  %source_diff_mri CS is 'ctf'
% % Check CS
% cfg = [];
% source_diff_mri_coordinatesystem = ft_determine_coordsys(source_diff_mri); %Ans: n  

% Plot 2D Slice with mask %Commented
for foldup = 1:1
% source_diff_mri_mask = source_diff_mri;
% source_diff_mri_mask.mask = (source_diff_mri_mask.pow>threshold & source_diff_mri_mask.pow<maxPow) | (source_diff_mri_mask.pow<-threshold & source_diff_mri_mask.pow>-maxPow);
% 
% cfg                 = [];
% cfg.method          = 'slice';
% cfg.atlas           = atlas;
% cfg.anparameter     = 'tissue';
% cfg.maskparameter   = 'mask'
% cfg.funparameter    = 'pow';
% cfg.interpmethod    = 'cubic';
%  if (freqBandMODE == 4) ||(freqBandMODE == 7)
%     cfg.funcolorlim    = [-maxPow 0];
%  else
%      cfg.funcolorlim    = [0 maxPow];
%  end
% cfg.nslices         = 9; 
% %cfg.colormap        = jet;
% %cfg.funcolorlim     = 'maxabs';
% %cfg.crosshair       = 'no';
% %cfg.location        = 'center';
% %cfg.opacitymap      = 'rampdown';
% 
% %Slice x - Sagital
% cfg.slicedim = 1;
% ft_sourceplot(cfg,source_diff_mri_mask);
% ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
%  if (freqBandMODE == 4) ||(freqBandMODE == 7)
%     colormap(flipud(brewermap(20,'PuBu')));
%  else
%     colormap((brewermap(20,'OrRd'))); 
%  end
% camroll(180);
% %title([task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s' newline 'sagital view']);
% title([label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s' newline 'sagital view']);c = colorbar;
% c = colorbar;
% c.Ticks = ticks;
% ylabel (c, strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
% %ylabel (c, strcat('Activation (normalized to max. abs.)'));
% 
%     %---
%     % SAVING Plot Option
%     savingPlotOn    = 1;
%     outputPlotName = ['Beamforming_' group '_' task '_SliceSMask_' datum];
%     
%     if savingPlotOn == 1
%         %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.fig']);      
%         %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.pdf']);
%         saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.fig']); 
%         saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.pdf']);
%         savingPlotOn = 0;
%     end
%     clear outputPlotName;
%     %---
% 
% %Slice y - Frontal
% cfg.slicedim = 2;
% ft_sourceplot(cfg,source_diff_mri_mask);
% ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
%  if (freqBandMODE == 4) ||(freqBandMODE == 7)
%     colormap(flipud(brewermap(20,'PuBu')));
%  else
%     colormap((brewermap(20,'OrRd'))); 
%  end
% camroll(-90);
% %title([task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s' newline 'frontal view']);
% title([label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s' newline 'frontal view']);
% c = colorbar;
% c.Ticks = ticks;
% ylabel (c, strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
% %ylabel (c, strcat('Activation (normalized to max. abs.)'));
% 
%     %---
%     % SAVING Plot Option
%     savingPlotOn    = 1;
%     outputPlotName = ['Beamforming_' group '_' task '_SliceFMask_' datum];
%     
%     if savingPlotOn == 1
%         %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.fig']);      
%         %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.pdf']);
%         saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.fig']); 
%         saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.pdf']);
%         savingPlotOn = 0;
%     end
%     clear outputPlotName;
%     %---
%     
% %Slice z - Transverse
% cfg.slicedim = 3;
% ft_sourceplot(cfg,source_diff_mri_mask);
% ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
%  if (freqBandMODE == 4) ||(freqBandMODE == 7)
%     colormap(flipud(brewermap(20,'PuBu')));
%  else
%     colormap((brewermap(20,'OrRd'))); 
%  end
% %title([task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s' newline 'transverse view']);
% title([label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s' newline 'transverse view']);c = colorbar;
% c.Ticks = ticks;
% ylabel (c, strcat('Difference (norm. to max. abs.) [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));
% %ylabel (c, strcat('Activation (normalized to max. abs.)'));
% 
%     %---
%     % SAVING Plot Option
%     savingPlotOn    = 1;
%     outputPlotName = ['Beamforming_' group '_' task '_SliceTMask_' datum];
%     
%     if savingPlotOn == 1
%         %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.fig']);      
%         %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.pdf']);
%         saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.fig']); 
%         saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.pdf']);
%         savingPlotOn = 0;
%     end
%     clear outputPlotName;
%     %---
%     
% % % Check CS
% % ft_determine_coordsys(source_diff_mri); %Ans: n
% % ft_determine_coordsys(mri); %Ans: n 
end

% Plot 2D Ortho with mask 
for foldup = 1:1
source_diff_mri_mask = source_diff_mri;
source_diff_mri_mask.mask = (source_diff_mri_mask.pow>threshold & source_diff_mri_mask.pow<maxPow) | (source_diff_mri_mask.pow<-threshold & source_diff_mri_mask.pow>-maxPow);

cfg                 = [];
cfg.method          = 'ortho';
cfg.atlas           = atlas;
cfg.anparameter     = 'tissue';
cfg.maskparameter   = 'mask'
cfg.funparameter    = 'pow';
cfg.interpmethod    = 'cubic';
%cfg.colormap        = jet;
%cfg.funcolorlim     = 'maxabs';
%cfg.crosshair       = 'no';
%cfg.location        =  [12 52 61]; %Left STG 41/42
cfg.location        =  [-3 -47 68]; %Right STG 41/42
%cfg.opacitymap      = 'rampdown';
%  if (freqBandMODE == 5)||(freqBandMODE == 8)
%     cfg.funcolorlim    = [-maxPow 0];
%  else
%      cfg.funcolorlim   = [0 maxPow];
%  end
cfg.funcolorlim    = [-maxPow maxPow];
ft_sourceplot(cfg,source_diff_mri_mask);
ft_hastoolbox('brewermap', 1); % ensure this toolbox is on the path
%  if (freqBandMODE == 5)||(freqBandMODE == 8)
%     colormap(flipud(brewermap(20,'PuBu')));
%  else
%     colormap((brewermap(20,'OrRd'))); 
%  end
colormap(RedBlueTFR0p5);
%set(gca,'Ydir','reverse');
figure = gcf;
% ax = gca;
allaxes = findall(figure, 'type', 'axes');
%Top-Left
set(allaxes(4),'Xdir','normal');
set(allaxes(4),'Ydir','normal');
set(allaxes(4),'Zdir','reverse');
set(allaxes(4),'XTick',[]);
set(allaxes(4),'YTick',[]);
set(allaxes(4),'ZTick',[]);
allaxes(4).Title.String = 'frontal view';
%Top-Right
set(allaxes(3),'Xdir','normal');
set(allaxes(3),'Ydir','reverse');
set(allaxes(3),'Zdir','reverse');
set(allaxes(3),'XTick',[]);
set(allaxes(3),'YTick',[]);
set(allaxes(3),'ZTick',[]);
allaxes(3).Title.String = 'sagital view';
%Bottom-Left
set(allaxes(2),'Xdir','normal');
set(allaxes(2),'Ydir','normal');
set(allaxes(2),'Zdir','normal');
set(allaxes(2),'XTick',[]);
set(allaxes(2),'YTick',[]);
set(allaxes(2),'ZTick',[]);
allaxes(2).Title.String = 'transverse view';

    %---
    % SAVING Plot Option
    savingPlotOn    = 1;
    outputPlotName = ['Beamforming_' group '_' task '_OrthoMask_' datum];
    
    if savingPlotOn == 1
        %saveas(gcf,[outputPlotFolder '/' freqBand '/ohneContrast/' outputPlotName '.fig']);      
        saveas(gcf,[outputPlotFolder '/' freqBand '/mitContrast/' outputPlotName '.fig']);     
        savingPlotOn = 0;
    end
    clear outputPlotName;
    %---
    
end

end

close all;

end %Repeat over freqBandMODE

return;

%% JUNK

for foldup = 1:1
%% Parcel
for foldup = 1:1
source_diff_mri_mni = source_diff_mri;
source_diff_mri_mni = ft_convert_coordsys(source_diff_mri, 'mni'); %mni = ras %Junk
source_diff_mri_mni.coordsys = 'mni'; %ctf = als

% Interpolate the atlas to the MRI
cfg = [];
cfg.voxelcoord      = 'no';
cfg.parameter       = 'tissue';
cfg.interpmethod    = 'nearest';
atlas_int = ft_sourceinterpolate(cfg, atlas, mri);
atlas_int_mni = atlas_int;
atlas_int_mni = ft_convert_coordsys(atlas_int, 'mni'); %mni = ras %Junk
atlas_int_mni.coordsys = 'mni'; %ctf = als

atlas_int_mni = ft_convert_coordsys(atlas_int, 'mni'); %mni = ras %Junk
atlas_int_mni.coordsys = 'mni'; %ctf = als

% Parcel as endresult of source_diff alligned to atlas and mri
cfg = [];
parcel = ft_sourceparcellate(cfg, source_diff_mri, atlas_int);

dummy = atlas;
for i = 1:length(parcel.pow)
      dummy.tissue(find(dummy.tissue==i)) = parcel.pow(i);
end
source_diff_mri_mni.parcel = dummy.tissue;

% 3D
for foldup = 1:1
cfg = [];
cfg.method         = 'surface';
cfg.funparameter   = 'parcel'; 
cfg.projmethod     = 'nearest';
cfg.surfinflated   = 'surface_inflated_both_caret.mat'; %'surface_white_both.mat'
%cfg.surfdownsample = 10
cfg.projthresh     = 0.2; %0.2; %more mean less projection
cfg.funcolorlim    = [-maxPow maxPow];
cfg.camlight       = 'no';

cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
%cfg.title = [task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];cfg.colorbartext = strcat('Difference [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
ft_sourceplot(cfg, source_diff_mri);
light ('Position',[0 0 40])
light ('Position',[0 20 0])
material dull;
view ([90 0]);
camzoom(0.75);
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(20,'RdBu')))

% cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
% %cfg.title = [task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];cfg.colorbartext = strcat('Difference [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
% ft_sourceplot(cfg, source_diff_mri);
% light ('Position',[0 0 40])
% light ('Position',[0 20 0])
% material dull;
% view ([-90 0]);
% camzoom(0.75);
% ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
% colormap(flipud(brewermap(20,'RdBu'))) % change the colormap

% cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
% %cfg.title = [task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];cfg.colorbartext = strcat('Difference [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
% ft_sourceplot(cfg, source_diff_mri);
% light ('Position',[0 0 0])
% light ('Position',[0 20 0])
% material dull;
% view ([180 60]);
% camzoom(0.65);
% ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
% colormap(flipud(brewermap(20,'RdBu'))) % change the colormap

% cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
% %cfg.title = [task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
% cfg.colorbartext = strcat('Difference [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
% ft_sourceplot(cfg, source_diff_mri);
% light ('Position',[0 0 40])
% light ('Position',[0 20 0])
% material dull;
% view ([180 0]);
% camzoom(0.65);
% ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
% colormap(flipud(brewermap(20,'RdBu'))) % change the colormap

% cfg.title = [label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
% %cfg.title = [task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s'];
% cfg.colorbartext = strcat('Difference [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']');
% ft_sourceplot(cfg, source_diff_mri);
% light ('Position',[0 0 40])
% light ('Position',[0 20 0])
% material dull;
% view ([0 0]);
% camzoom(0.65);
% ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
% colormap(flipud(brewermap(20,'RdBu'))) % change the colormap
end

% Plot 2D Slice with mask
for foldup = 1:1
% source_diff_mri_mask = source_diff_mri;
% source_diff_mri_mask.mask = (source_diff_mri_mask.pow>threshold & source_diff_mri_mask.pow<maxPow) | (source_diff_mri_mask.pow<-threshold & source_diff_mri_mask.pow>-maxPow);

cfg                 = [];
cfg.method          = 'slice';
cfg.atlas           = atlas_int;
% cfg.anparameter     = 'tissue';
% cfg.maskparameter   = 'mask'
cfg.funparameter   = 'parcel'; 
%cfg.interpmethod    = 'cubic';
cfg.funcolorlim     = [-maxPow maxPow];
cfg.nslices         = 9; 
%cfg.colormap        = jet;
%cfg.funcolorlim     = 'maxabs';
%cfg.crosshair       = 'no';
%cfg.location        = 'center';
%cfg.opacitymap      = 'rampdown';

%Slice x - Sagital
cfg.slicedim = 1;
ft_sourceplot(cfg,source_diff_mri);
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(20,'RdBu'))); % change the colormap
camroll(180);
%title([task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s' newline 'sagital view']);
title([label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s' newline 'sagital view']);c = colorbar;
c.Ticks = ticks;
ylabel (c, strcat('Difference [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));

%Slice y - Frontal
cfg.slicedim = 2;
ft_sourceplot(cfg,source_diff_mri_mask);
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(20,'RdBu')));
camroll(-90);
%title([task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s' newline 'frontal view']);
title([label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s' newline 'frontal view']);
c = colorbar;
c.Ticks = ticks;
ylabel (c, strcat('Difference [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));

%Slice z - Transverse
cfg.slicedim = 3;
ft_sourceplot(cfg,source_diff_mri_mask);
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(20,'RdBu'))); 
%title([task newline label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s' newline 'transverse view']);
title([label '; ' num2str(timeStart) ' s - ' num2str(timeEnd) ' s' newline 'transverse view']);c = colorbar;
c.Ticks = ticks;
ylabel (c, strcat('Difference [re Baseline: ' , '(', num2str(baselineEnd), 's)', ' - ',  '(', num2str(baselineStart), 's)', ']'));

% % Check CS
% ft_determine_coordsys(source_diff_mri); %Ans: n
% ft_determine_coordsys(mri); %Ans: n 
end

% Plot 2D Ortho with mask
for foldup = 1:1
source_diff_mri_mask = source_diff_mri;
source_diff_mri_mask.mask = (source_diff_mri_mask.pow>threshold & source_diff_mri_mask.pow<maxPow) | (source_diff_mri_mask.pow<-threshold & source_diff_mri_mask.pow>-maxPow);

cfg                 = [];
cfg.method          = 'ortho';
cfg.atlas           = atlas_int;
cfg.renderer        = 'zbuffer';
% cfg.anparameter     = 'tissue';
cfg.maskparameter   = 'mask'
cfg.funparameter   = 'parcel'; 
%cfg.interpmethod    = 'cubic';
%cfg.colormap        = jet;
%cfg.funcolorlim     = 'maxabs';
%cfg.crosshair       = 'no';
%cfg.location        =  [12 52 61]; %Left STG 41/42
cfg.location        =  [-3 -47 68]; %Right STG 41/42
%cfg.opacitymap      = 'rampdown';
cfg.funcolorlim = [-maxPow maxPow];
ft_sourceplot(cfg,source_diff_mri_mask);
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(20,'RdBu'))); % change the colormap
%set(gca,'Ydir','reverse');
figure = gcf;
% ax = gca;
allaxes = findall(figure, 'type', 'axes');
%Top-Left
set(allaxes(4),'Xdir','normal');
set(allaxes(4),'Ydir','normal');
set(allaxes(4),'Zdir','reverse');
set(allaxes(4),'XTick',[]);
set(allaxes(4),'YTick',[]);
set(allaxes(4),'ZTick',[]);
allaxes(4).Title.String = 'frontal view';
%Top-Right
set(allaxes(3),'Xdir','normal');
set(allaxes(3),'Ydir','reverse');
set(allaxes(3),'Zdir','reverse');
set(allaxes(3),'XTick',[]);
set(allaxes(3),'YTick',[]);
set(allaxes(3),'ZTick',[]);
allaxes(3).Title.String = 'sagital view';
%Bottom-Left
set(allaxes(2),'Xdir','normal');
set(allaxes(2),'Ydir','normal');
set(allaxes(2),'Zdir','normal');
set(allaxes(2),'XTick',[]);
set(allaxes(2),'YTick',[]);
set(allaxes(2),'ZTick',[]);
allaxes(2).Title.String = 'transverse view';
end
end
    
%% Atlas Registration

%JUNK
for foldup = 1:1
% % PROBLEM: Different coordinate systems
% for foldup = 1:1
% % cfg = [];
% % source_diff_coordinate = ft_determine_coordsys(source_diff);
% % 
% % cfg = [];
% % mri_coordinate = ft_determine_coordsys(mri);
% % 
% % cfg = [];
% % brainnetome_coordinate = ft_determine_coordsys(brainnetome);
% end
% % Transform source_diff to mni
% source_diff_realign = source_diff;
% source_diff_realign.coordsys = 'ctf';
% source_diff_realign = ft_convert_coordsys(source_diff_realign, 'mni');
% cfg = [];
% source_diff_realign_coordinate = ft_determine_coordsys(source_diff_realign); %Ans: n
% % Result: The Coordinate System is the same as Generic MRI, but the scaling is of´ft_f
% for foldup = 1:1
% % Interpolating and Ploting
% % Interpolate
% cfg = [];
% cfg.voxelcoord      = 'no';
% cfg.parameter       = 'pow';
% cfg.interpmethod    = 'nearest';
% %source_diff_atlased = ft_sourceinterpolate(cfg, source_diff, mri);
% source_diff_atlased = ft_sourceinterpolate(cfg, source_diff_realign, mri);
% 
% % Plot 2D
% cfg                 = [];
% cfg.funparameter    = 'pow';
% ft_sourceplot(cfg,source_diff_atlased);
% colormap(jet);
% % ft_hastoolbox('jet', 1);         % ensure this toolbox is on the path
% % colormap(flipud(jet(20,'RdBu'))) % change the colormap
% end
% 
% %SOLUTION 1: Landmark FAILED
% % Creating Landmark for source_diff, to be exact: elecLandmark
% for foldup = 1:1
% % % Possible Solution: Landmark
% % 
% % %1. Creating Landmark
% % load elecAligned_edited_58_edited_listed_finetuned.mat
% % elec = elecAligned_edited_58_edited_listed_finetuned;  
% % 
% % for foldup = 1:1
% % elec.label =    [elec.label(2); elec.label(9); elec.label(13)];          
% % elec.chanunit = [elec.chanunit(2); elec.chanunit(9); elec.chanunit(13)];
% % elec.chantype = [elec.chantype(2); elec.chantype(9); elec.chantype(13)];
% % elec.chanpos  = [elec.chanpos(2,:,:); elec.chanpos(9,:,:); elec.chanpos(13,:,:)];
% % elec.elecpos  = [elec.elecpos(2,:,:); elec.elecpos(9,:,:); elec.elecpos(13,:,:)];
% % elec.tra      = diag(ones(3,1));
% % 
% % %Change Fpz into Nas and change it's location 
% % channelIndex = find(strcmp(elec.label, 'Fpz'));
% % elec.label{channelIndex,1} = 'Nas';
% % elec.chanpos(channelIndex,1)= 126.8071+7;
% % elec.chanpos(channelIndex,2)= -0.3337;
% % elec.chanpos(channelIndex,3)= 73.4536-58;  
% % 
% % %Change T3 into LPA and change it's location 
% % channelIndex = find(strcmp(elec.label, 'T3'));
% % elec.label{channelIndex,1} = 'LPA';
% % elec.chanpos(channelIndex,1)= 16.4086+10;
% % elec.chanpos(channelIndex,2)= 86.5540-3;
% % elec.chanpos(channelIndex,3)= 44.9737-44;  
% % 
% % %Change T4 into LPA and change it's location 
% % channelIndex = find(strcmp(elec.label, 'T4'));
% % elec.label{channelIndex,1} = 'RPA';
% % elec.chanpos(channelIndex,1)= 16.3582+10;
% % elec.chanpos(channelIndex,2)= -86.0247+3;
% % elec.chanpos(channelIndex,3)= 47.1861-47;
% % 
% % elec.elecpos = elec.chanpos;
% % end
% % 
% elecLandmark = elec; 
% 
% load elecLandmark.mat;
% elec = elecLandmark ;
% 
% figure
% %ft_plot_sens(elecAligned_edited_58_edited_listed_finetuned, 'elecsize', 40);
% %hold on;
% ft_plot_sens(elecLandmark, 'elecsize', 40, 'facecolor', 'red');
% ft_plot_headmodel(headmodel, 'facealpha', 0.5);
% view(90, 0);
% end
% for foldup = 1:1
%     % Transform elecLandmark form ctf to mni;
%     elecLandmark_mni = elecLandmark;
%     elecLandmark_mni.coordsys = 'ctf';
%     elecLandmark_mni = ft_convert_coordsys(elecLandmark_mni, 'mni');
%  
%     % Transform elecLandmark form ctf to mni;
%     headmodel_mni = headmodel;
%     headmodel_mni.coordsys = 'ctf';
%     headmodel_mni = ft_convert_coordsys(headmodel_mni, 'mni');
%     
%     % cfg = [];
%     % elecLandmark_mni_coordinate = ft_determine_coordsys(elecLandmark_mni);
%     
%     % Realign
%     channelIndex = find(strcmp(elecLandmark.label, 'Nas'));
%     x_Nas = elecLandmark_mni.chanpos(channelIndex,1);
%     y_Nas = elecLandmark_mni.chanpos(channelIndex,2);
%     z_Nas = elecLandmark_mni.chanpos(channelIndex,3);
%     
%     channelIndex = find(strcmp(elecLandmark.label, 'LPA'));
%     x_LPA = elecLandmark_mni.chanpos(channelIndex,1);
%     y_LPA = elecLandmark_mni.chanpos(channelIndex,2);
%     z_LPA = elecLandmark_mni.chanpos(channelIndex,3);
%     
%     channelIndex = find(strcmp(elecLandmark.label, 'RPA'));
%     x_RPA = elecLandmark_mni.chanpos(channelIndex,1);
%     y_RPA = elecLandmark_mni.chanpos(channelIndex,2);
%     z_RPA = elecLandmark_mni.chanpos(channelIndex,3);
% 
% %% %Check
% cfg = [];
% elecLandmark_mni_coordinate = ft_determine_coordsys(elecLandmark_mni); %Ans: n
% 
% % %Check
% % figure;
% % cfg = [];
% % ft_plot_axes(mri);
% 
% % Manually defining coordinate y,r,a,s,a
% cfg = [];
% mri_coordinate = ft_determine_coordsys(mri);
% 
% %Check if elec and headmodel alligned with mri
% figure
% %ft_plot_sens(elecAligned_edited_58_edited_listed_finetuned, 'elecsize', 40);
% %hold on;
% ft_plot_sens(elecLandmark_mni, 'elecsize', 40, 'facecolor', 'red');
% ft_plot_headmodel(headmodel_mni, 'facealpha', 0.5);
% ft_plot_axes(mri_coordinate);
% view(90, 0);
% 
% % Manually defining nas, lpa and rpa for mri
% cfg = [];
% cfg.method   = 'interactive';
% cfg.coordsys = 'neuromag';
% mri_landmark = ft_volumerealign(cfg,mri);
%     
% %Check
% figure;
% cfg = [];
% ft_plot_axes(mri_landmark);
% cfg = [];
% mri_landmark = ft_determine_coordsys(mri_landmark); %Ans: n  
% 
% % Manually defining coordinate y,r,a,s,a
% cfg = [];
% mri_landmark_corrected = ft_determine_coordsys(mri_landmark);
%     
% %Check
% figure;
% cfg = [];
% ft_plot_axes(mri_landmark_corrected);
% cfg = [];
% mri_landmark_corrected = ft_determine_coordsys(mri_landmark_corrected); %Ans: n
%     
% % Scaled and align with fiducial from elecLandmark
% cfg = [];
% cfg.method   = 'fiducial';
% cfg.coordsys = 'acpc';
% cfg.fiducial.nas    = [x_Nas y_Nas z_Nas]; 
% cfg.fiducial.lpa    = [x_LPA y_LPA z_LPA];
% cfg.fiducial.rpa    = [x_RPA y_RPA z_RPA];
% cfg.parameter       = 'anatomy';
% % cfg.viewresult  = 'yes';
% mri_scaled = ft_volumerealign(cfg, mri_landmark_corrected, elecLandmark_mni_coordinate);
% 
% % Failed
% cfg = [];
% cfg.method              = 'headshape';
% cfg.headshape.headshape = headmodel_mni;
% cfg.headshape.icp       = 'no';
% cfg.coordsys            = 'neuromag';
% mri_landmark_realigned = ft_volumerealign(cfg, mri_landmark_corrected);
% 
% %Check
% figure;
% cfg = [];
% ft_plot_axes(mri_scaled);
% cfg = [];
% mri_scaled_coordinate = ft_determine_coordsys(mri_scaled); %Ans: n
%     
% % MRI ori coordinate
% cfg = [];
% mri_coordinate = ft_determine_coordsys(mri);
% end
% 
% for foldup = 1:1
% % %SOLUTION 2: ft_volumereslice: FAILED
% % cfg = [];
% % cfg.resolution = 2;
% % cfg.xrange     = [-50 50]; 
% % cfg.yrange     = [-80 60];
% % cfg.zrange     = [-50 50]; 
% % mri_resliced = ft_volumereslice(cfg, mri_coordinate);
% 
% % %SOLUTION 3: ft_volumedownsample: FAILED
% % % Manually defining coordinate y,r,a,s,a
% % cfg = [];
% % mri_coordinate = ft_determine_coordsys(mri);
% % cfg = [];
% % cfg.downsample = 2; 
% % mri_volumedownsampled = ft_volumereslice(cfg, mri_coordinate);
% 
% % %SOLUTION 4: ft_volumenormalize: FAILED
% % cfg = [];
% % cfg.nonlinear = 'yes'; 
% % cfg.template = mri;
% % source_diff_realign_normalize = ft_volumenormalise(cfg, source_diff_realign);
% end
end

%JUNK
for foldup = 1:1
% % Load MRI and Interpolate
% % mri = ft_read_mri('C:\Program Files\MATLAB\R2020b\toolbox\fieldtrip-mastar\fieldtrip-20201113\template\anatomy\single_subj_T1.nii');
% mri = ft_read_mri('Subject01.mri');
% % Interpolation
% cfg = [];
% cfg.voxelcoord      = 'no';
% cfg.parameter       = 'pow';
% cfg.interpmethod    = 'cubic';
% source_diff_mri = ft_sourceinterpolate(cfg, source_diff, mri);
% 
% % Load Atlas
% brainnetome = ft_read_atlas('C:\Program Files\MATLAB\R2020b\toolbox\fieldtrip-mastar\fieldtrip-20201113\template\atlas\brainnetome\BNA_MPM_thr25_1.25mm.nii')
% afni = ft_read_atlas('C:\Program Files\MATLAB\R2020b\toolbox\fieldtrip-mastar\fieldtrip-20201113\template\atlas\afni\TTatlas+tlrc.HEAD')
% aal = ft_read_atlas('C:\Program Files\MATLAB\R2020b\toolbox\fieldtrip-mastar\fieldtrip-20201113\template\atlas\aal\ROI_MNI_V4.nii')
% 
% % Manually determine: 'y', 'ras', 'n'
% cfg = [];
% source_diff_coordinate = ft_determine_coordsys(source_diff);
% 
% % % Transform source_diff to mni/acpc or tal
% % source_diff_realign = source_diff;
% % % source_diff_realign.coordsys = 'mni';
% % source_diff_realign = ft_convert_coordsys(atlas, 'tal');
% % % Check
% % cfg = [];
% % source_diff_realign_coordinate = ft_determine_coordsys(source_diff_realign); %Ans: n
% % % Result: The Coordinate System is the same as Generic MRI, but the scaling is off
% 
% %---
% 
% atlas = brainnetome;
% %imagesc(atlas.tissue(:,:,25));
% 
% % Plot 2D of the atlas
% cfg                 = [];
% cfg.method          = 'ortho';
% cfg.atlas           = atlas;
% cfg.anaparameter    = 'brick1';
% ft_sourceplot(cfg,atlas);
% 
% %---
% 
% % Interpolate the source_diff_mri to the atlas, takes a long time: 10 minutes
% cfg                 = [];
% cfg.voxelcoord      = 'no';
% cfg.parameter       = 'pow';
% cfg.interpmethod    = 'nearest';
% source_diff_atlased = ft_sourceinterpolate(cfg, source_diff_mri, atlas);
% 
% % Interpolate the mri to the atlas
% cfg                 = [];
% cfg.voxelcoord      = 'no';
% cfg.parameter       = 'anatomy';
% cfg.interpmethod    = 'nearest';
% mri_atlased = ft_sourceinterpolate(cfg, mri, atlas);
% 
% % Plot 2D
% cfg                 = [];
% cfg.method          = 'ortho';
% cfg.atlas           = atlas;
% cfg.anaparameter    = 'tissue';
% cfg.funparameter    = 'anatomy';
% cfg.colormap        = jet;
% ft_sourceplot(cfg, mri_atlased);
% colormap(jet);
% 
% %---
% 
% % %Failed
% % % Interpolate the atlas to the mri
% % cfg                 = [];
% % cfg.voxelcoord      = 'no';
% % cfg.parameter       = 'brick1';
% % cfg.interpmethod    = 'nearest';
% % atlas_mri = ft_sourceinterpolate(cfg, atlas, mri);
% % 
% % % Plot 2D of the atlas
% % cfg                 = [];
% % cfg.method          = 'ortho';
% % cfg.atlas           = atlas_mri;
% % cfg.anaparameter    = 'brick1';
% % ft_sourceplot(cfg, atlas);
% 
% %---
% 
% % JUNK
% for foldup = 1:1
% % % cfg = [];
% % % cfg.interpmethod = 'cubic';
% % % cfg.parameter    = 'pow';
% % % source_diff_atlased = ft_sourceinterpolate(cfg, source_diff_realign, atlas);
% % 
% % cfg = [];
% % cfg.interpmethod = 'cubic';
% % cfg.parameter    = 'tissue';
% % source_diff_atlased = ft_sourceinterpolate(cfg,atlas, source_diff_realign);
% % 
% % indx = find(source_diff_atlased.tissue==1);
% % 
% % % [~, indx] = max(labels.count);
% % % labels.name(indx);
% % 
% % % cfg = [];
% % % cfg.atlas = atlas;
% % % cfg.maskparameter   = 'inside';
% % % cfg.output          = 'single';
% % % labels = ft_volumelookup(cfg, source_diff_atlased);
% end
% 
% % Plot 2D
% cfg                 = [];
% cfg.method          = 'ortho';
% cfg.atlas           = atlas;
% cfg.anaparameter    = 'tissue';
% cfg.funparameter    = 'pow';
% cfg.colormap        = jet;
% %ft_sourceplot(cfg,atlas);
% %ft_sourceplot(cfg,source_diff); %Failed: if input: 'ras' -> Picture inaccurate and no atlas, if input: 'n' -> Error :(
% %ft_sourceplot(cfg,source_diff_realign); %Failed: showing nothing, error: no anatomy is present and no functional data is selected, please check your cfg.funparameter
% ft_sourceplot(cfg,source_diff_atlased); %Failed: position off, Picture inaccurate
% colormap(jet);
% % ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
% % colormap(flipud(brewermap(20,'RdBu'))) % change the colormap
% 
% % Functioning well
% % Manually determine: 'y', 'ras', 'n'
% %cfg = [];
% %source_diff_coordinate = ft_determine_coordsys(source_diff);
% cfg = [];
% cfg.method         = 'surface';
% cfg.funparameter   = 'pow';
% cfg.projmethod     = 'nearest';
% cfg.surfinflated   = 'surface_inflated_both_caret.mat';
% %cfg.surfdownsample = 10
% cfg.projthresh     = 0.2;
% cfg.camlight       = 'no';
% ft_sourceplot(cfg, source_diff);
% colormap(jet);
% light ('Position',[0 0 50])
% light ('Position',[0 -50 0])
% material dull;
% view ([45 135]);
% %ft_plot_axes(source_diff_coordinate);
end

%% Source Reconstruction

% JUNK
for foldup = 1:1
% %TOI 1
% for foldup = 1:1
% 
% %---
% dataft_post = dataft_post1;
% 
%     cfg = [];
%     cfg.method      = 'mtmfft';
%     cfg.output      = 'powandcsd';
%     cfg.taper       = 'dpss';
%     cfg.keeptrials  = 'yes';
%     cfg.channel     = {'all', '-EB', '-a2', '-VEOR', '-VEOL', '-a1', '-el020'};
%     cfg.tapsmofrq   = taper;
%     %cfg.foi   = choosenFreq;
%     cfg.foilim   = choosenFreqLim;
%     TFR_post = ft_freqanalysis(cfg, dataft_post);
% 
%     %---
% 
%     dataft_prepost = ft_appenddata([], dataft_pre, dataft_post);
%     cfg = [];
%     cfg.method      = 'mtmfft';
%     cfg.output      = 'powandcsd';
%     cfg.taper       = 'dpss';
%     cfg.keeptrials  = 'yes';
%     cfg.channel     = {'all', '-EB', '-a2', '-VEOR', '-VEOL', '-a1', '-el020'};
%     cfg.tapsmofrq   = taper;
%     %cfg.foi   = choosenFreq;
%     cfg.foilim   = choosenFreqLim;
%     TFR_prepost = ft_freqanalysis(cfg, dataft_prepost);
% 
% %---
% 
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.rawtrial            = 'no'; %'yes';
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% cfg.dics.keepfilter     = 'yes';
% cfg.dics.realfilter     = 'yes';
% source_prepost_alltrls = ft_sourceanalysis(cfg, TFR_prepost);
% source_prepost = source_prepost_alltrls;
% %source_prepost = ft_sourceanalysis(cfg, TFR_prepost);
% 
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.rawtrial            = 'no';
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% cfg.dics.keepfilter     = 'yes';
% cfg.dics.realfilter     = 'yes';
% cfg.sourcemodel.filter = source_prepost.avg.filter;
% %cfg.sourcemodel.filter = source_prepost.trial.filter;
% source_pre_con  = ft_sourceanalysis(cfg, TFR_pre);
% source_post_con = ft_sourceanalysis(cfg, TFR_post);
% 
% source_diff = source_post_con;
% source_diff.avg.pow = (source_post_con.avg.pow - source_pre_con.avg.pow) ./ source_pre_con.avg.pow;
% maxval = max(source_diff.avg.pow);
% 
% % cfg               = [];
% % cfg.method        = 'ortho';
% % cfg.funparameter  = 'pow';
% % cfg.funcolorlim   = 'maxabs';
% % ft_sourceplot(cfg, source_diff);
% 
% cfg = [];
% cfg.method         = 'surface';
% cfg.funparameter   = 'pow';
% cfg.maskparameter  = cfg.funparameter;
% cfg.funcolorlim    = limit;%[0.0 maxval]; 
% cfg.opacitylim     = color;%[0.0 maxval]
% cfg.opacitymap     = color;%'rampup';
% cfg.projmethod     = 'nearest';
% cfg.funcolormap    = 'jet';
% cfg.surffile       = 'surface_white_both.mat';
% cfg.surfdownsample = 10;
% ft_sourceplot(cfg, source_diff);
% view ([45 135]);
% 
% %     %---
% %     % SAVING Plot Option
% %     savingPlotOn    = 1;
% %     outputPlotName = ['Source_' subject '_' num2str(freqStart) 'Hz' num2str(freqEnd) 'Hz_' num2str(timeVector(1)) 'sec' num2str(timeVector(2)) 'sec_' datum];
% %     
% %     if savingPlotOn == 1
% %         saveas(gcf,[outputPlotFolder outputPlotName '.fig']);
% %         saveas(gcf,'J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Source_toi1.fig');
% %         savingPlotOn = 0;
% %     end
% %     clear outputPlotName;
% %     %---
%     
% end    
% 
% %TOI 2
% for foldup = 1:1
% 
% %---
% dataft_post = dataft_post2;
% 
%     cfg = [];
%     cfg.method      = 'mtmfft';
%     cfg.output      = 'powandcsd';
%     cfg.taper       = 'dpss';
%     cfg.keeptrials  = 'yes';
%     cfg.channel     = {'all', '-EB', '-a2', '-VEOR', '-VEOL', '-a1', '-el020'};
%     cfg.tapsmofrq   = taper;
%     %cfg.foi   = choosenFreq;
%     cfg.foilim   = choosenFreqLim;
%     TFR_post = ft_freqanalysis(cfg, dataft_post);
% 
%     %---
% 
%     dataft_prepost = ft_appenddata([], dataft_pre, dataft_post);
%     cfg = [];
%     cfg.method      = 'mtmfft';
%     cfg.output      = 'powandcsd';
%     cfg.taper       = 'dpss';
%     cfg.keeptrials  = 'yes';
%     cfg.channel     = {'all', '-EB', '-a2', '-VEOR', '-VEOL', '-a1', '-el020'};
%     cfg.tapsmofrq   = taper;
%     %cfg.foi   = choosenFreq;
%     cfg.foilim   = choosenFreqLim;
%     TFR_prepost = ft_freqanalysis(cfg, dataft_prepost);
% 
% %---
% 
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.rawtrial            = 'no'; %'yes';
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% cfg.dics.keepfilter     = 'yes';
% cfg.dics.realfilter     = 'yes';
% source_prepost_alltrls = ft_sourceanalysis(cfg, TFR_prepost);
% source_prepost = source_prepost_alltrls;
% %source_prepost = ft_sourceanalysis(cfg, TFR_prepost);
% 
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.rawtrial            = 'no';
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% cfg.dics.keepfilter     = 'yes';
% cfg.dics.realfilter     = 'yes';
% cfg.sourcemodel.filter = source_prepost.avg.filter;
% %cfg.sourcemodel.filter = source_prepost.trial.filter;
% source_pre_con  = ft_sourceanalysis(cfg, TFR_pre);
% source_post_con = ft_sourceanalysis(cfg, TFR_post);
% 
% source_diff = source_post_con;
% source_diff.avg.pow = (source_post_con.avg.pow - source_pre_con.avg.pow) ./ source_pre_con.avg.pow;
% maxval = max(source_diff.avg.pow);
% 
% % cfg               = [];
% % cfg.method        = 'ortho';
% % cfg.funparameter  = 'pow';
% % cfg.funcolorlim   = 'maxabs';
% % ft_sourceplot(cfg, source_diff);
% 
% cfg = [];
% cfg.method         = 'surface';
% cfg.funparameter   = 'pow';
% cfg.maskparameter  = cfg.funparameter;
% cfg.funcolorlim    = limit;%[0.0 maxval]; 
% cfg.opacitylim     = color;%[0.0 maxval]
% cfg.opacitymap     = color;%'rampup';
% cfg.projmethod     = 'nearest';
% cfg.funcolormap    = 'jet';
% cfg.surffile       = 'surface_white_both.mat';
% cfg.surfdownsample = 10;
% ft_sourceplot(cfg, source_diff);
% view ([45 135]);
% 
% %     %---
% %     % SAVING Plot Option
% %     savingPlotOn    = 1;
% %     outputPlotName = ['Source_' subject '_' num2str(freqStart) 'Hz' num2str(freqEnd) 'Hz_' num2str(timeVector(2)) 'sec' num2str(timeVector(3)) 'sec_' datum];
% %     
% %     if savingPlotOn == 1
% %         saveas(gcf,[outputPlotFolder outputPlotName '.fig']);
% %         saveas(gcf,'J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Source_toi2.fig');
% %         savingPlotOn = 0;
% %     end
% %     clear outputPlotName;
% %     %---
%     
% end    
% 
% %TOI 3
% for foldup = 1:1
% 
% %---
% dataft_post = dataft_post3;
% 
%     cfg = [];
%     cfg.method      = 'mtmfft';
%     cfg.output      = 'powandcsd';
%     cfg.taper       = 'dpss';
%     cfg.keeptrials  = 'yes';
%     cfg.channel     = {'all', '-EB', '-a2', '-VEOR', '-VEOL', '-a1', '-el020'};
%     cfg.tapsmofrq   = taper;
%     %cfg.foi   = choosenFreq;
%     cfg.foilim   = choosenFreqLim;
%     TFR_post = ft_freqanalysis(cfg, dataft_post);
% 
%     %---
% 
%     dataft_prepost = ft_appenddata([], dataft_pre, dataft_post);
%     cfg = [];
%     cfg.method      = 'mtmfft';
%     cfg.output      = 'powandcsd';
%     cfg.taper       = 'dpss';
%     cfg.keeptrials  = 'yes';
%     cfg.channel     = {'all', '-EB', '-a2', '-VEOR', '-VEOL', '-a1', '-el064'};
%     cfg.tapsmofrq   = taper;
%     %cfg.foi   = choosenFreq;
%     cfg.foilim   = choosenFreqLim;
%     TFR_prepost = ft_freqanalysis(cfg, dataft_prepost);
% 
% %---
% 
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.rawtrial            = 'no'; %'yes';
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% cfg.dics.keepfilter     = 'yes';
% cfg.dics.realfilter     = 'yes';
% source_prepost_alltrls = ft_sourceanalysis(cfg, TFR_prepost);
% source_prepost = source_prepost_alltrls;
% %source_prepost = ft_sourceanalysis(cfg, TFR_prepost);
% 
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.rawtrial            = 'no';
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% cfg.dics.keepfilter     = 'yes';
% cfg.dics.realfilter     = 'yes';
% cfg.sourcemodel.filter = source_prepost.avg.filter;
% %cfg.sourcemodel.filter = source_prepost.trial.filter;
% source_pre_con  = ft_sourceanalysis(cfg, TFR_pre);
% source_post_con = ft_sourceanalysis(cfg, TFR_post);
% 
% source_diff = source_post_con;
% source_diff.avg.pow = (source_post_con.avg.pow - source_pre_con.avg.pow) ./ source_pre_con.avg.pow;
% maxval = max(source_diff.avg.pow);
% 
% % cfg               = [];
% % cfg.method        = 'ortho';
% % cfg.funparameter  = 'pow';
% % cfg.funcolorlim   = 'maxabs';
% % ft_sourceplot(cfg, source_diff);
% 
% cfg = [];
% cfg.method         = 'surface';
% cfg.funparameter   = 'pow';
% cfg.maskparameter  = cfg.funparameter;
% cfg.funcolorlim    = limit;%[0.0 maxval]; 
% cfg.opacitylim     = color;%[0.0 maxval]
% cfg.opacitymap     = color;%'rampup';
% cfg.projmethod     = 'nearest';
% cfg.funcolormap    = 'jet';
% cfg.surffile       = 'surface_white_both.mat';
% cfg.surfdownsample = 10;
% ft_sourceplot(cfg, source_diff);
% view ([45 135]);
% 
% %     %---
% %     % SAVING Plot Option
% %     savingPlotOn    = 1;
% %     outputPlotName = ['Source_' subject '_' num2str(freqStart) 'Hz' num2str(freqEnd) 'Hz_' num2str(timeVector(3)) 'sec' num2str(timeVector(4)) 'sec_' datum];
% %     
% %     if savingPlotOn == 1
% %         saveas(gcf,[outputPlotFolder outputPlotName '.fig']);
% %         saveas(gcf,'J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Source_toi3.fig');
% %         savingPlotOn = 0;
% %     end
% %     clear outputPlotName;
% %     %---
%     
% end    
% 
% %TOI 4
% for foldup = 1:1
% 
% %---
% dataft_post = dataft_post4;
% 
%     cfg = [];
%     cfg.method      = 'mtmfft';
%     cfg.output      = 'powandcsd';
%     cfg.taper       = 'dpss';
%     cfg.keeptrials  = 'yes';
%     cfg.channel     = {'all', '-EB', '-a2', '-VEOR', '-VEOL', '-a1', '-el064'};
%     cfg.tapsmofrq   = taper;
%     %cfg.foi   = choosenFreq;
%     cfg.foilim   = choosenFreqLim;
%     TFR_post = ft_freqanalysis(cfg, dataft_post);
% 
%     %---
% 
%     dataft_prepost = ft_appenddata([], dataft_pre, dataft_post);
%     cfg = [];
%     cfg.method      = 'mtmfft';
%     cfg.output      = 'powandcsd';
%     cfg.taper       = 'dpss';
%     cfg.keeptrials  = 'yes';
%     cfg.channel     = {'all', '-EB', '-a2', '-VEOR', '-VEOL', '-a1', '-el064'};
%     cfg.tapsmofrq   = taper;
%     %cfg.foi   = choosenFreq;
%     cfg.foilim   = choosenFreqLim;
%     TFR_prepost = ft_freqanalysis(cfg, dataft_prepost);
% 
% %---
% 
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.rawtrial            = 'no'; %'yes';
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% cfg.dics.keepfilter     = 'yes';
% cfg.dics.realfilter     = 'yes';
% source_prepost_alltrls = ft_sourceanalysis(cfg, TFR_prepost);
% source_prepost = source_prepost_alltrls;
% %source_prepost = ft_sourceanalysis(cfg, TFR_prepost);
% 
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.rawtrial            = 'no';
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% cfg.dics.keepfilter     = 'yes';
% cfg.dics.realfilter     = 'yes';
% cfg.sourcemodel.filter = source_prepost.avg.filter;
% %cfg.sourcemodel.filter = source_prepost.trial.filter;
% source_pre_con  = ft_sourceanalysis(cfg, TFR_pre);
% source_post_con = ft_sourceanalysis(cfg, TFR_post);
% 
% source_diff = source_post_con;
% source_diff.avg.pow = (source_post_con.avg.pow - source_pre_con.avg.pow) ./ source_pre_con.avg.pow;
% maxval = max(source_diff.avg.pow);
% 
% % cfg               = [];
% % cfg.method        = 'ortho';
% % cfg.funparameter  = 'pow';
% % cfg.funcolorlim   = 'maxabs';
% % ft_sourceplot(cfg, source_diff);
% 
% cfg = [];
% cfg.method         = 'surface';
% cfg.funparameter   = 'pow';
% cfg.maskparameter  = cfg.funparameter;
% cfg.funcolorlim    = limit;%[0.0 maxval]; 
% cfg.opacitylim     = color;%[0.0 maxval]
% cfg.opacitymap     = color;%'rampup';
% cfg.projmethod     = 'nearest';
% cfg.funcolormap    = 'jet';
% cfg.surffile       = 'surface_white_both.mat';
% cfg.surfdownsample = 10;
% ft_sourceplot(cfg, source_diff);
% view ([45 135]);
% 
% %     %---
% %     % SAVING Plot Option
% %     savingPlotOn    = 1;
% %     outputPlotName = ['Source_' subject '_' num2str(freqStart) 'Hz' num2str(freqEnd) 'Hz_' num2str(timeVector(4)) 'sec' num2str(timeVector(5)) 'sec_' datum];
% %     
% %     if savingPlotOn == 1
% %         saveas(gcf,[outputPlotFolder outputPlotName '.fig']);
% %         saveas(gcf,'J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Source_toi4.fig');
% %         savingPlotOn = 0;
% %     end
% %     clear outputPlotName;
% %     %---
%     
% end  
% 
% %TOI 5
% for foldup = 1:1
% 
% %---
% dataft_post = dataft_post5;
% 
%     cfg = [];
%     cfg.method      = 'mtmfft';
%     cfg.output      = 'powandcsd';
%     cfg.taper       = 'dpss';
%     cfg.keeptrials  = 'yes';
%     cfg.channel     = {'all', '-EB', '-a2', '-VEOR', '-VEOL', '-a1', '-el064'};
%     cfg.tapsmofrq   = taper;
%     %cfg.foi   = choosenFreq;
%     cfg.foilim   = choosenFreqLim;
%     TFR_post = ft_freqanalysis(cfg, dataft_post);
% 
%     %---
% 
%     dataft_prepost = ft_appenddata([], dataft_pre, dataft_post);
%     cfg = [];
%     cfg.method      = 'mtmfft';
%     cfg.output      = 'powandcsd';
%     cfg.taper       = 'dpss';
%     cfg.keeptrials  = 'yes';
%     cfg.channel     = {'all', '-EB', '-a2', '-VEOR', '-VEOL', '-a1', '-el064'};
%     cfg.tapsmofrq   = taper;
%     %cfg.foi   = choosenFreq;
%     cfg.foilim   = choosenFreqLim;
%     TFR_prepost = ft_freqanalysis(cfg, dataft_prepost);
% 
% %---
% 
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.rawtrial            = 'no'; %'yes';
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% cfg.dics.keepfilter     = 'yes';
% cfg.dics.realfilter     = 'yes';
% source_prepost_alltrls = ft_sourceanalysis(cfg, TFR_prepost);
% source_prepost = source_prepost_alltrls;
% %source_prepost = ft_sourceanalysis(cfg, TFR_prepost);
% 
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.rawtrial            = 'no';
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% cfg.dics.keepfilter     = 'yes';
% cfg.dics.realfilter     = 'yes';
% cfg.sourcemodel.filter = source_prepost.avg.filter;
% %cfg.sourcemodel.filter = source_prepost.trial.filter;
% source_pre_con  = ft_sourceanalysis(cfg, TFR_pre);
% source_post_con = ft_sourceanalysis(cfg, TFR_post);
% 
% source_diff = source_post_con;
% source_diff.avg.pow = (source_post_con.avg.pow - source_pre_con.avg.pow) ./ source_pre_con.avg.pow;
% maxval = max(source_diff.avg.pow);
% 
% % cfg               = [];
% % cfg.method        = 'ortho';
% % cfg.funparameter  = 'pow';
% % cfg.funcolorlim   = 'maxabs';
% % ft_sourceplot(cfg, source_diff);
% 
% cfg = [];
% cfg.method         = 'surface';
% cfg.funparameter   = 'pow';
% cfg.maskparameter  = cfg.funparameter;
% cfg.funcolorlim    = limit;%[0.0 maxval]; 
% cfg.opacitylim     = color;%[0.0 maxval]
% cfg.opacitymap     = color;%'rampup';
% cfg.projmethod     = 'nearest';
% cfg.funcolormap    = 'jet';
% cfg.surffile       = 'surface_white_both.mat';
% cfg.surfdownsample = 10;
% ft_sourceplot(cfg, source_diff);
% view ([45 135]);
% 
% %     %---
% %     % SAVING Plot Option
% %     savingPlotOn    = 1;
% %     outputPlotName = ['Source_' subject '_' num2str(freqStart) 'Hz' num2str(freqEnd) 'Hz_' num2str(timeVector(5)) 'sec' num2str(timeVector(6)) 'sec_' datum];
% %     
% %     if savingPlotOn == 1
% %         saveas(gcf,[outputPlotFolder outputPlotName '.fig']);
% %         saveas(gcf,'J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Source_toi5.fig');
% %         savingPlotOn = 0;
% %     end
% %     clear outputPlotName;
% %     %---
%     
% end  
% 
% %TOI 6
% for foldup = 1:1
% 
% %---
% dataft_post = dataft_post6;
% 
%     cfg = [];
%     cfg.method      = 'mtmfft';
%     cfg.output      = 'powandcsd';
%     cfg.taper       = 'dpss';
%     cfg.keeptrials  = 'yes';
%     cfg.channel     = {'all', '-EB', '-a2', '-VEOR', '-VEOL', '-a1', '-el064'};
%     cfg.tapsmofrq   = taper;
%     %cfg.foi   = choosenFreq;
%     cfg.foilim   = choosenFreqLim;
%     TFR_post = ft_freqanalysis(cfg, dataft_post);
% 
%     %---
% 
%     dataft_prepost = ft_appenddata([], dataft_pre, dataft_post);
%     cfg = [];
%     cfg.method      = 'mtmfft';
%     cfg.output      = 'powandcsd';
%     cfg.taper       = 'dpss';
%     cfg.keeptrials  = 'yes';
%     cfg.channel     = {'all', '-EB', '-a2', '-VEOR', '-VEOL', '-a1', '-el064'};
%     cfg.tapsmofrq   = taper;
%     %cfg.foi   = choosenFreq;
%     cfg.foilim   = choosenFreqLim;
%     TFR_prepost = ft_freqanalysis(cfg, dataft_prepost);
% 
% %---
% 
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.rawtrial            = 'no'; %'yes';
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% cfg.dics.keepfilter     = 'yes';
% cfg.dics.realfilter     = 'yes';
% source_prepost_alltrls = ft_sourceanalysis(cfg, TFR_prepost);
% source_prepost = source_prepost_alltrls;
% %source_prepost = ft_sourceanalysis(cfg, TFR_prepost);
% 
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.rawtrial            = 'no';
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% cfg.dics.keepfilter     = 'yes';
% cfg.dics.realfilter     = 'yes';
% cfg.sourcemodel.filter = source_prepost.avg.filter;
% %cfg.sourcemodel.filter = source_prepost.trial.filter;
% source_pre_con  = ft_sourceanalysis(cfg, TFR_pre);
% source_post_con = ft_sourceanalysis(cfg, TFR_post);
% 
% source_diff = source_post_con;
% source_diff.avg.pow = (source_post_con.avg.pow - source_pre_con.avg.pow) ./ source_pre_con.avg.pow;
% maxval = max(source_diff.avg.pow);
% 
% % cfg               = [];
% % cfg.method        = 'ortho';
% % cfg.funparameter  = 'pow';
% % cfg.funcolorlim   = 'maxabs';
% % ft_sourceplot(cfg, source_diff);
% 
% cfg = [];
% cfg.method         = 'surface';
% cfg.funparameter   = 'pow';
% cfg.maskparameter  = cfg.funparameter;
% cfg.funcolorlim    = limit;%[0.0 maxval]; 
% cfg.opacitylim     = color;%[0.0 maxval]
% cfg.opacitymap     = color;%'rampup';
% cfg.projmethod     = 'nearest';
% cfg.funcolormap    = 'jet';
% cfg.surffile       = 'surface_white_both.mat';
% cfg.surfdownsample = 10;
% ft_sourceplot(cfg, source_diff);
% view ([45 135]);
% 
% %     %---
% %     % SAVING Plot Option
% %     savingPlotOn    = 1;
% %     outputPlotName = ['Source_' subject '_' num2str(freqStart) 'Hz' num2str(freqEnd) 'Hz_' num2str(timeVector(6)) 'sec' num2str(timeVector(7)) 'sec_' datum];
% %     
% %     if savingPlotOn == 1
% %         saveas(gcf,[outputPlotFolder outputPlotName '.fig']);
% %         saveas(gcf,'J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Source_toi6.fig');
% %         savingPlotOn = 0;
% %     end
% %     clear outputPlotName;
% %     %---
%     
% end  
% 
% %close all;
% 
% % Animation
% for foldup = 1:1
% figure1 = openfig(['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Source_toi1.fig'], 'visible');
% figure1.Name =  ['Time: ' num2str(timeVector(1)) 'sec until ' num2str(timeVector(2)) 'sec - Freq: ' num2str(freqStart) 'Hz until ' num2str(freqEnd) 'Hz']
% pause;
% copyobj(get(figure1, 'CurrentAxes'), figure1);
% 
% figure2 = openfig(['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Source_toi2.fig'], 'visible');
% figure2.Name =  ['Time: ' num2str(timeVector(2)) 'sec until ' num2str(timeVector(3)) 'sec - Freq: ' num2str(freqStart) 'Hz until ' num2str(freqEnd) 'Hz']
% copyobj(get(figure2, 'CurrentAxes'), figure1);
% delete(figure1);
% pause;
% 
% figure3 = openfig(['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Source_toi3.fig'], 'visible');
% figure3.Name =  ['Time: ' num2str(timeVector(3)) 'sec until ' num2str(timeVector(4)) 'sec - Freq: ' num2str(freqStart) 'Hz until ' num2str(freqEnd) 'Hz']
% copyobj(get(figure3, 'CurrentAxes'), figure2);
% delete(figure2);
% pause;
% 
% figure4 = openfig(['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Source_toi4.fig'], 'visible');
% figure4.Name =  ['Time: ' num2str(timeVector(4)) 'sec until ' num2str(timeVector(5)) 'sec - Freq: ' num2str(freqStart) 'Hz until ' num2str(freqEnd) 'Hz']
% copyobj(get(figure4, 'CurrentAxes'), figure3);
% delete(figure3);
% pause;
% 
% figure5 = openfig(['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Source_toi5.fig'], 'visible');
% figure5.Name =  ['Time: ' num2str(timeVector(5)) 'sec until ' num2str(timeVector(6)) 'sec - Freq: ' num2str(freqStart) 'Hz until ' num2str(freqEnd) 'Hz']
% copyobj(get(figure5, 'CurrentAxes'), figure4);
% delete(figure4);
% pause;
% 
% figure6 = openfig(['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\Source_toi6.fig'], 'visible');
% figure6.Name =  ['Time: ' num2str(timeVector(6)) 'sec until ' num2str(timeVector(7)) 'sec - Freq: ' num2str(freqStart) 'Hz until ' num2str(freqEnd) 'Hz']
% copyobj(get(figure6, 'CurrentAxes'), figure5);
% delete(figure5);
% %pause;
% 
% end

end

%% EXTRA NOTE of PART III: SOURCE LOCALIZATION

%The lambda value is a scaling factor that is responsible for scaling the noise-covariance matrix. 
%If it is zero the noise-covariance estimation will be not taken into account during the computation of the inverse solution. 
%Noise-covariance is estimated in each trial separately and then averaged, 
%while the functional data (of which we calculate the source-analysis) is simply averaged across all the trials. 
%Therefore, the higher the number of trials the lower the noise is in the averaged, functional data, 
%but the number trials is not reducing the noise in the noise-covariance estimation. 
%This is the reason while it is useful to use a scaling factor for the noise-covariance matrix if we want to estimate more realistically the amount of noise.

for foldup = 1:1
% cfg                     = [];
% cfg.method              = 'dics';
% cfg.frequency           = choosenFreqLim;
% cfg.grid                = leadfield;
% cfg.headmodel           = headmodel;
% cfg.senstype            = 'EEG'; % Remember this must be specified as either EEG, or MEG
% cfg.dics.projectnoise   = 'yes';
% cfg.dics.lambda         = '15%';
% source_post_nocontrast = ft_sourceanalysis(cfg, TFR_post);
% maxval = max(source_post_nocontrast.avg.pow);
% 
% % cfg               = [];
% % cfg.method        = 'ortho';
% % cfg.funparameter  = 'pow';
% % cfg.funcolorlim   = 'maxabs';
% % ft_sourceplot(cfg, sourcePost_nocontrast);
% 
% cfg = [];
% cfg.method         = 'surface';
% cfg.funparameter   = 'pow';
% cfg.maskparameter  = cfg.funparameter;
% cfg.funcolorlim    = [0.0 maxval]; 
% cfg.opacitylim     = [0.0 maxval]
% cfg.opacitymap     = 'rampup';
% cfg.projmethod     = 'nearest';
% cfg.funcolormap    = 'jet';
% cfg.surffile       = 'surface_white_both.mat';
% cfg.surfdownsample = 10;
% ft_sourceplot(cfg, source_post_nocontrast);
% view ([45 135]);
end

%% JUNK

%% PART IIB: ONE SUBJECT, ONE FREQUENCY, ONE TIME

for foldup = 1:1
%--------------------------------------------------------------------------
%PLEASE CHECK!
%DEFINE Subject
subject                 = 'ANRO34';

% DEFINE INPUT Data
preprocessedDataName    = 'dataft_preprocessed_TFR';

% DEFINE Noise
NoiseInd                = 1; %NoiseInd: 1: In Quiet - 2: In Noise

% DEFINE Analysis Datum
datum                   = '220713';
%--------------------------------------------------------------------------

% Naming
task                    = 'Stroop Task'; %'Vowel Identification';
taskShort               = 'ST'; %'VI';

cond1                   = 'Congruent';
cond1Short              = 'Con';
cond2                   = 'Incongruent';
cond2Short              = 'Incon';

% Group
group                   = 'NHYoung';

if NoiseInd == 1
    condDataFolder = 'STQuiet'; %'VIQuiet';
else if NoiseInd == 2
        condDataFolder = 'STNoise'; %'VINoise';
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

%INPUT DATA
preprocessedDataFolder	= ['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\' taskShort '\' group '\' subject '\' condDataFolder '\Preprocessing\Data\'];

% %OUTPUT DATA
% outputDataFolder        = ['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\' subject '\Data\'];
% mkdir(outputDataFolder);
% 
% %OUTPUT PLOT
% % DEFINE Plot All Channel
% plotAllChannelOn        = 0;
% 
% % DEFINE Plot Location
% outputPlotFolder        = ['J:\Brilliant_Dokumenten\Daten\Brilliant_Datenmaster\MarkersOfAuditoryCognitiveAging\Brilliant_Analysis\MACA_IL\MASTER\Beamforming\' subject '\Plot\'];
% mkdir(outputPlotFolder);
% 
% %% IMPORT PREPROCESSED DATA
% 
load ([preprocessedDataFolder preprocessedDataName], '-mat' );
% %save([outputDataFolder 'dataft_preprocessed_TFR.mat'], 'dataft_preprocessed_TFR');
% 
dataft_aktuell = dataft_preprocessed_TFR;
% 
%% REREFERENCE COMMON AVG

cfg = [];
cfg.reref = 'yes';
cfg.refmethod = 'avg';
cfg.refchannel = dataft_preprocessed_TFR.label(1:58);
data_avgreref = ft_preprocessing(cfg, dataft_aktuell);

dataft_aktuell = data_avgreref;

% return;

%% REDEFINE BEAMED TOI

cfg = [];
cfg.toilim = [-0.7 -0.3]; %[-0.8 -0.2]; %[-0.3 -0.1]; 
dataft_pre = ft_redefinetrial(cfg, dataft_aktuell);

% DEFINE TOI
%--------------------------------------------------------------------------
timeStart   = 0.2; %0; 
timeEnd     = 0.6;  %0.2;
%timeStep    = 0.4;  %0.2;  %see toilim Baseline
%--------------------------------------------------------------------------

cfg = [];
cfg.toilim = [timeStart timeEnd];
dataft_post = ft_redefinetrial(cfg, dataft_aktuell);

% nTime = ((timeEnd - timeStart)/timeStep)+1;
% timeVector = linspace(timeStart,timeEnd,round(nTime));
% 
% %How many toi will depend on nTime (nTime-1)
% toi1 = [timeVector(1) timeVector(2)];
% toi2 = [timeVector(2) timeVector(3)];
% toi3 = [timeVector(3) timeVector(4)];
% toi4 = [timeVector(4) timeVector(5)];
% toi5 = [timeVector(5) timeVector(6)];
% toi6 = [timeVector(6) timeVector(7)];
% 
% cfg = [];
% cfg.toilim = toi1;
% dataft_post1 = ft_redefinetrial(cfg, dataft_aktuell);
% 
% cfg.toilim = toi2;
% dataft_post2 = ft_redefinetrial(cfg, dataft_aktuell);
% 
% cfg.toilim = toi3;
% dataft_post3 = ft_redefinetrial(cfg, dataft_aktuell);
% 
% cfg.toilim = toi4;
% dataft_post4 = ft_redefinetrial(cfg, dataft_aktuell);
% 
% cfg.toilim = toi5;
% dataft_post5 = ft_redefinetrial(cfg, dataft_aktuell);
% 
% cfg.toilim = toi6;
% dataft_post6 = ft_redefinetrial(cfg, dataft_aktuell);
% 
% return;
end
end
