addpath('C:\Users\philipp\Desktop\Uni\Bachelorarbeit\Matlab_files\the file\ergebniss_structs');
load('cc_lage');
load('cc_lage_abs');
load('cc_phase');
load('cc_phase_abs');
load('ME_lage');
load('ME_phase');
load('MAE_lage');
load('MAE_phase');
load('NMSE_lage');
load('NMSE_phase');

 allouts={'Madgwick_PCA','Kalman_PCA_ACC','Kalman_PCA_ACC_MAG','PCA_ACC','PCA_GYRO','PCA_MAG','PCA_ACC_GYRO','PCA_ACC_MAG','PCA_GYRO_MAG','PCA_ALL','gesamt'};
 lagen = {'supine','latral','prone','alle_Lagen'};
 phasen={'spont. Atmung','6 bpm','18 bpm','36 bpm','alle_Phasen'};

for p=length(allouts):-1:1
    filter=allouts{p};
    for n = 1:length(lagen)
        lage=lagen{n};
        if strcmp(filter,'gesamt')&& strcmp(lage,'alle_Lagen')
        idx1=4;
        idx2=4;
        idx3=4;
        idx4=4;
        idx5=4;
        
        cc_lage(idx1).(filter)='-';
         cc_lage_abs(idx2).(filter)='-';
         ME_lage(idx3).(filter)='-';
         MAE_lage(idx4).(filter)='-';
         NMSE_lage(idx5).(filter)='-';
        
        else
            
            
       idx1 = find (strcmp({cc_lage.lage},lage));
       idx2 = find (strcmp({cc_lage_abs.lage},lage));
       idx3 = find (strcmp({ME_lage.lage},lage));
       idx4 = find (strcmp({MAE_lage.lage},lage));
       idx5 = find (strcmp({NMSE_lage.lage},lage));
        
         cc_lage(idx1).(filter)=round(cc_lage(idx1).(filter),3);
         cc_lage_abs(idx2).(filter)=round(cc_lage_abs(idx2).(filter),3);
         ME_lage(idx3).(filter)=round(ME_lage(idx3).(filter),3);
         MAE_lage(idx4).(filter)=round(MAE_lage(idx4).(filter),3);
         NMSE_lage(idx5).(filter)=round(NMSE_lage(idx5).(filter),3);
       
         cc_lage(idx1).(filter)=[num2str(cc_lage(idx1).(filter)(1)), '$\pm$', num2str(cc_lage(idx1).(filter)(2))];
         cc_lage_abs(idx2).(filter)=([num2str(cc_lage_abs(idx2).(filter)(1)),'$\pm$',num2str(cc_lage_abs(idx2).(filter)(2))]);
         ME_lage(idx3).(filter)=([num2str(ME_lage(idx3).(filter)(1)),'$\pm$',num2str(ME_lage(idx3).(filter)(2))]);
         MAE_lage(idx4).(filter)=([num2str(MAE_lage(idx4).(filter)(1)),'$\pm$',num2str(MAE_lage(idx4).(filter)(2))]);
         NMSE_lage(idx5).(filter)=([num2str(NMSE_lage(idx5).(filter)(1)),'$\pm$',num2str(NMSE_lage(idx5).(filter)(2))]);
        end
    end
    
end

for p=length(allouts):-1:1
    filter=allouts{p};
    for n = 1:length(phasen)
        phase=phasen{n};
        if strcmp(filter,'gesamt')&& strcmp(phase,'alle_Phasen')
        idx1=5;
        idx2=5;
        idx3=5;
        idx4=5;
        idx5=5;
        
        cc_phase(idx1).(filter)='-';
         cc_phase_abs(idx2).(filter)='-';
         ME_phase(idx3).(filter)='-';
         MAE_phase(idx4).(filter)='-';
         NMSE_phase(idx5).(filter)='-';
        
        else
            
            
       idx1 = find (strcmp({cc_phase.phase},phase));
       idx2 = find (strcmp({cc_phase_abs.phase},phase));
       idx3 = find (strcmp({ME_phase.phase},phase));
       idx4 = find (strcmp({MAE_phase.phase},phase));
       idx5 = find (strcmp({NMSE_phase.phase},phase));
       
       
        
         cc_phase(idx1).(filter)=round(cc_phase(idx1).(filter),3);
         cc_phase_abs(idx2).(filter)=round(cc_phase_abs(idx2).(filter),3);
         ME_phase(idx3).(filter)=round(ME_phase(idx3).(filter),3);
         MAE_phase(idx4).(filter)=round(MAE_phase(idx4).(filter),3);
         NMSE_phase(idx5).(filter)=round(NMSE_phase(idx5).(filter),2);
       
         cc_phase(idx1).(filter)=[num2str(cc_phase(idx1).(filter)(1)), '$\pm$', num2str(cc_phase(idx1).(filter)(2))];
         cc_phase_abs(idx2).(filter)=([num2str(cc_phase_abs(idx2).(filter)(1)),'$\pm$',num2str(cc_phase_abs(idx2).(filter)(2))]);
         ME_phase(idx3).(filter)=([num2str(ME_phase(idx3).(filter)(1)),'$\pm$',num2str(ME_phase(idx3).(filter)(2))]);
         MAE_phase(idx4).(filter)=([num2str(MAE_phase(idx4).(filter)(1)),'$\pm$',num2str(MAE_phase(idx4).(filter)(2))]);
         NMSE_phase(idx5).(filter)=([num2str(NMSE_phase(idx5).(filter)(1)),'$\pm$',num2str(NMSE_phase(idx5).(filter)(2))]);
         
        end
    end
    
end

alltables_lage(1).tabelle=cc_lage;
alltables_lage(1).name='CC_{nach Lage}';

alltables_lage(2).tabelle=cc_lage_abs;
alltables_lage(2).name='|CC|_{nach Lage}';

alltables_phase(1).tabelle=cc_phase;
alltables_phase(1).name='CC_{nach Phase}';

alltables_phase(2).tabelle=cc_phase_abs;
alltables_phase(2).name='|CC|_{nach Phase}';

alltables_lage(3).tabelle=ME_lage;
alltables_lage(3).name='ME_{nach Lage}';

alltables_phase(3).tabelle=ME_phase;
alltables_phase(3).name='ME_{nach Phase}';

alltables_lage(4).tabelle=MAE_lage;
alltables_lage(4).name='MAE_{nach Lage}';

alltables_phase(4).tabelle=MAE_phase;
alltables_phase(4).name='MAE_{nach Phase}';

alltables_lage(5).tabelle=NMSE_lage;
alltables_lage(5).name='NMSE_{nach Lage}';

alltables_phase(5).tabelle=NMSE_phase;
alltables_phase(5).name='NMSE_{nach Phase}';


for a=1: length(alltables_lage)

            old_T = struct2table(alltables_lage(a).tabelle);
            YourArray = table2array(old_T);
            T=transpose(YourArray);
%             T = YourArray.';
%             T = flip(T,2);
            T(1,:)={'supine','latral','prone','alle Lagen'};
            
            C={'Filter';'Madgwick';'Kalman__{ACC}';'Kalman__{ACC,MAG}';'PCA__{ACC}';'PCA__{GYRO}';'PCA__{MAG}';'PCA__{ACC,GYRO}';'PCA__{ACC,MAG}';'PCA__{GYRO,MAG}';'PCA__{ALL}';'gesamt'};
            T=[C T];
            T=cell2table(T);
            
            
            
input.data=T;
input.transposeTable = 0;
input.tablePositioning = 'hbt';
input.filename=['table' (a)];
input.tableBorders = 1;
input.tableCaption = alltables_lage(a).name;
input.tableLabel = alltables_lage(a).name;

 latex = latexTable(input);

    %mat2tex(input);     
end 

for b=1: length(alltables_phase)
            old_T = struct2table(alltables_phase(b).tabelle);
            YourArray = table2array(old_T);
            T=transpose(YourArray);
%             T = YourArray.';
%              T = flip(T,2);
            T(1,:)={'Atmung_{spont.}','Atmung_{6 Bpm}','Atmung_{18 Bpm}','Atmung_{36 Bpm}','alle Phasen'};
            C={'Filter';'Madgwick';'Kalman__{ACC}';'Kalman__{ACC,MAG}';'PCA__{ACC}';'PCA__{GYRO}';'PCA__{MAG}';'PCA__{ACC,GYRO}';'PCA__{ACC,MAG}';'PCA__{GYRO,MAG}';'PCA__{ALL}';'gesamt'};
            T=[C T];
            T=cell2table(T);
         
input.data=T;
input.tablePositioning = 'H';
input.filename=['table' (b)];
input.transposeTable = 0;
input.tableBorders = 1;
input.tableCaption = alltables_phase(b).name;
input.tableLabel = alltables_phase(b).name;
input.tableColLabels = {'Phasen''Madgwick','Kalman_{PCA_ACC}','Kalman_{PCA_ACC_MAG}','PCA_{ACC}','PCA_{GYRO}','PCA_{MAG}','PCA_{ACC_GYRO}','PCA_{ACC_MAG}','PCA_{GYRO_MAG}','PCA_{ALL}'};

latex = latexTable(input);

         
         
end 
