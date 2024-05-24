%dies ist ein callerscript welches alle funktionen nacheinander aufruft
%die jeweiligen ergebnisse werden im ordner 'ergebniss_structs' gespeichert
%mit der execute variable kann man einzelne schritte auführen oder mit all
%alle zusammen andere möglichkeiten: 

%filter : führt die Signalverabeitung durch und gibt die ergebnisstructs
%aus die die geschtätzten Signale beinhalten(sig_ohne_phasen,sig_mit_phasen)  und speichert diese in
%Ergebniss_stucts

%cc&rr : läd sig_mit_phasen -> errechnet Die korrelationskoeffizienten und
% atemraten der signale und des ref signals und speichert diese in Ergebniss_stucts
 
%tabellen: läd rr und cc -> erstellt tabellen des ME MAE NMSE der Atemrate und des cc und
%|cc| über jeweils alle phase und lagen und speichert diese in Ergebniss_stucts

%plots:läd rr und cc -> erstellt einen bland altman plot der atremrate der
%signale und des ref signals und einen histogram plot der cc
execute='all';
addpath('ergebniss_structs');


 allouts={'PCA_ALL','PCA_GYRO_MAG','PCA_ACC_MAG','PCA_ACC_GYRO','PCA_MAG','PCA_GYRO','PCA_ACC','Kalman_PCA_ACC_MAG','Kalman_PCA_ACC','Madgwick_PCA'};
 phasen={'spont. Atmung','6 bpm','18 bpm','36 bpm'};
 lagen = {'supine','latral','prone'};

%% Filter über gesammt Signale und einzelne Phasen
if (strcmp('filter', execute)||strcmp('all', execute))
A=load('ASUB.mat');
addpath('sigverarbeitung');

[t] = sig_ohne_phasen(A);

[z] = sig_mit_phasen(phasen,allouts,t,A);

%% Auswertung in Tabellen
end
if (strcmp('cc&rr', execute)||strcmp('all', execute))
 addpath('auswertung');   
     
load('Signale_mit_Atemphasen');

[cc] = correcoeff(z,allouts);
[rr] = resp_rate(z,allouts);
end
if (strcmp('tabellen', execute)||strcmp('all', execute))
    addpath('auswertung');
    load('rr');
    load('cc');
    
[cc_lage_abs, cc_lage,cc_phase_abs,cc_phase] = cc_tabellen(phasen,lagen,allouts,cc);
[ME_lage,MAE_lage,NMSE_lage,ME_phase,MAE_phase, NMSE_phase] =rr_fehler_tabellen(phasen,lagen,allouts,rr);
end
%% Plots
if (strcmp('plots', execute)||strcmp('all', execute))
load('rr.mat')
load('cc');
    addpath('plots');


%Berwertung setzen auf 'nach_lage' oder 'nach_phase' falls ein anderer wert
%angegeben wird alle Phasen und Lagen zusammen ausgewertet

        bewertung='alle';

% konkrete Phase  oder lage wähelen 

        lage={'prone'};
        phase={'Atmung_36bpm'};

    
bland_altman(rr,bewertung,lage,phase);
hist_plot(cc,bewertung,lage,phase);
end