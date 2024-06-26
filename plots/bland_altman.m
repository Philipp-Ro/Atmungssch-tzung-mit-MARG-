function bland_altman(rr,bewertung,lage,phase)
allouts ={'Madgwick_PCA','PCA_ACC','PCA_ACC_GYRO','Kalman_PCA_ACC','PCA_GYRO','PCA_ACC_MAG','Kalman_PCA_ACC_MAG','PCA_MAG','PCA_GYRO_MAG','PCA_ALL'};
titletext={'Madgwick','PCA_{ACC}','PCA_{ACC,GYRO}','Kalman_{ACC}','PCA_{GYRO}','PCA_{ACC,MAG}','Kalman_{ACC,MAG}','PCA_{MAG}','PCA_{GYRO,MAG}','PCA_{ALL}'};
 
hFig = figure;
figure(hFig);
set(gcf,'color','white')
ax = gca;
if strcmp('nach_lage',bewertung)
    idx = find (strcmp((lage),{rr.position}));
    plot_title=lage;
    
elseif strcmp('nach_phase',bewertung)
    plot_title=phase;

    if strcmp('spontanes_Atmen', phase)

        sa1=find (strcmp(('spontanes_Atmen_1'),{rr.phase}));
        sa2=find (strcmp(('spontanes_Atmen_2'),{rr.phase}));
        idx=[sa1, sa2];
    else
        
    idx = find (strcmp((phase),{rr.phase}));
    end
else
   
    idx=find(~arrayfun(@isempty,rr));
    plot_title='Bland-Altman Plot �ber alle Lagen und alle Phasen';

end

  i=1;

for p=1:length(allouts)
    c=0;
 data=allouts{p}; 
 feld=data;
 
    for a=1:length(idx)
        
        for b = 1:length(rr(idx(a)).(feld))
               c=c+1;
            s1=rr(idx(a)).ref(b);
            s2=rr(idx(a)).(feld)(b);

            avg(c)=(s1+s2)/2;
            error(c)=(s1-s2);
        end
        
    end
        
        meanDiff = mean(error);
        sdDiff = std(error);
        CR = [meanDiff + 1.96 * sdDiff, meanDiff - 1.96 * sdDiff];
        meantxt={'mean:',[num2str(round(meanDiff,2)),'bpm']};
        maxCR={'+1.96\sigma',[num2str(round(CR(1),2)),' bpm']};
        minCR={'-1.96\sigma',[num2str(round(CR(2),2)),' bpm']};
        
  
    if i ==10
        i=12;
    end

           subplot(4,3,i);
            i=i+1;
            
            x=linspace(0,50);
           
            
            %hold on
            plot(x,ones(1,length(x)).*meanDiff,'--k')
            t1=text(min(x),meanDiff,meantxt);
            t1.FontSize=9;
            t1.HorizontalAlignment='left';
            
            hold on
            plot(x,ones(1,length(x)).*CR(1),'--r')
            t2=text(max(x),CR(1),maxCR);
            t2.FontSize=9;
            t2.HorizontalAlignment='right';
            
            hold on
            plot(x, ones(1,length(x)).*CR(2),'--r')
            t3=text(max(x),CR(2),minCR);
            t3.FontSize=9;
            t3.HorizontalAlignment='right';
            
            hold on
            plot(avg,error,'o')
            
            
            xlabel('Durchnitt in bpm') 
            ylabel('Unterschied in bpm') 
            title([titletext{p},])
            sgtitle(plot_title)

            hold off
            
end

print(figure(1), '-append', '-dpsc2', 'C:\Users\philipp\Desktop\Uni\Bachelorarbeit\Matlab_files\the file\ergebniss_structs\BA.ps');
end
