function hist_plot(cc,bewertung,lage,phase)
hFig = figure(2);    
figure(hFig)

if strcmp('nach_lage',bewertung)
    idx = find (strcmp((lage),{cc.position}));
     plot_title=lage;
    
elseif strcmp('nach_phase',bewertung)
     plot_title=phase;

    if strcmp('spontanes_Atmen', phase)

        sa1=find (strcmp(('spontanes_Atmen_1'),{cc.phase}));
        sa2=find (strcmp(('spontanes_Atmen_2'),{cc.phase}));
        idx=[sa1, sa2];
    else
        
    idx = find (strcmp((phase),{cc.phase}));
    end
else
    disp('ERROR PLEASE CORRECT BEWERTUNG INPUT');
    idx=find(~arrayfun(@isempty,cc));
    plot_title='alle lagen und phasen';
end

allouts={'PCA_ACC_MAG','Madgwick_PCA','PCA_ACC','PCA_ACC_GYRO','Kalman_PCA_ACC','PCA_GYRO','PCA_GYRO_MAG','Kalman_PCA_ACC_MAG','PCA_MAG','PCA_ALL'};
titletext={'PCA_{ACC+MAG}','Madgwick_{PCA}','PCA_{ACC}','PCA_{ACC+GYRO}','Kalman_{PCA-ACC}','PCA_{GYRO}','PCA_{GYRO+MAG}','Kalman_{PCA-ACC+MAG}','PCA_{MAG}','PCA_{ALL}'};

 for n=1:length(allouts)
     c=0;
 
      filter=allouts{n};
      name=(filter);
 
    for a=1:length(idx)
        
       
    allvalue=transpose(arrayfun(@(x) x.(name),cc));
    out(a)=allvalue(idx(a));

        
       
        
    end
       hPlot(n) = subplot(ceil(length(allouts)/3),3,n);
       
            histogram(out,15);         
            title([titletext{n},' CC=',num2str(mean(out),'%1.3f'),'\pm',num2str(std(out),'%1.3f'),' (Abs: ',num2str(mean(abs(out)),'%1.3f'),'\pm',num2str(std(abs(out)),'%1.3f'),')'])
             sgtitle(plot_title)
             
            hold on
    
      
 end
 set(hPlot(1:7),'xticklabel',[]);
    set(hPlot,'xlim',[-1 1])
%  linkaxes([hPlot(1),hPlot(4),hPlot(7),hPlot(10)],'xy');
% 
%  linkaxes([hPlot(2),hPlot(5),hPlot(8)],'xy');
% 
%  linkaxes([hPlot(3),hPlot(6),hPlot(9)],'xy');
end
