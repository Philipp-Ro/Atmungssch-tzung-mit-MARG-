function[ME_lage,MAE_lage,NMSE_lage,ME_phase,MAE_phase, NMSE_phase] =rr_fehler_tabellen(phasen,lagen,allouts,rr)
for g=length(rr):-1:1
    
     for b=1:length(allouts)
         filter= allouts{b}; 
         filter_RR=filter;
         
         ME(g).(filter)=sum(rr(g).(filter_RR)-rr(g).ref)/length(rr(g).(filter_RR));
         ME(g).position=rr(g).position;
         ME(g).phase=rr(g).phase;
         
         MAE(g).(filter)=sum(abs(rr(g).(filter_RR)-rr(g).ref))/length(rr(g).(filter_RR));
         MAE(g).position=rr(g).position;
         MAE(g).phase=rr(g).phase;
         
         NMSE(g).(filter)=sum((rr(g).(filter_RR)-rr(g).ref).^2)*100/sum((rr(g).ref.^2));
         NMSE(g).position=rr(g).position;
         NMSE(g).phase=rr(g).phase;   
     end
end


for n =1 :length(lagen)
    lage=lagen{n};
    f=1;
    
    Idx=0;
    vector=0;
    
    %index bleibt gleich 
    idx = find (strcmp((lage),{ME.position}));
    
    ME_lage(n).lage=lage;
    MAE_lage(n).lage=lage;
    NMSE_lage(n).lage=lage;

    
    for p=1:length(allouts)
        filter= allouts{p};
       
        vector_gesamt_filter1=vertcat(ME.(filter));
        vector_gesamt_filter2=vertcat(MAE.(filter));
        vector_gesamt_filter3=vertcat(NMSE.(filter));
        
        for m=1:length(idx)
            row=idx(m);
            vector1(m)=ME(row).(filter);
            vector2(m)=MAE(row).(filter);
            vector3(m)=NMSE(row).(filter);
            
            vector_gesamt_lage1(f)=ME(row).(filter);
            vector_gesamt_lage2(f)=MAE(row).(filter);
            vector_gesamt_lage3(f)=NMSE(row).(filter);
            f=f+1;
            
        end
        string1=([num2str(mean(abs(vector1))),'$\pm$',num2str(std(abs(vector1)))]);
        ME_lage(n).(filter)=string1;
        
        string2=([num2str(mean(abs(vector2))),'$\pm$',num2str(std(abs(vector2)))]);
        MAE_lage(n).(filter)=string2;
        
        string3=([num2str(mean(abs(vector3))),'$\pm$',num2str(std(abs(vector3)))]);
        NMSE_lage(n).(filter)=string3;
        
        
        h=length(lagen)+1;
        
            ME_lage(h).lage='alle Lagen';
            MAE_lage(h).lage='alle Lagen';
            NMSE_lage(h).lage='alle Lagen';
        
        string_gesamt_filter1=([num2str(mean(abs(vector_gesamt_filter1))),'$\pm$',num2str(std(abs(vector_gesamt_filter1)))]);
        ME_lage(h).(filter)=string_gesamt_filter1;
        
        string_gesamt_filter2=([num2str(mean(abs(vector_gesamt_filter1))),'$\pm$',num2str(std(abs(vector_gesamt_filter1)))]);
        MAE_lage(h).(filter)=string_gesamt_filter2;
        
        string_gesamt_filter3=([num2str(mean(abs(vector_gesamt_filter1))),'$\pm$',num2str(std(abs(vector_gesamt_filter1)))]);
        NMSE_lage(h).(filter)=string_gesamt_filter3;
        
        
    end
    string_gesamt_lage1=([num2str(mean(abs(vector_gesamt_lage1))),'$\pm$',num2str(std(abs(vector_gesamt_lage1)))]);
    ME_lage(n).gesammt=string_gesamt_lage1;
    
     string_gesamt_lage2=([num2str(mean(abs(vector_gesamt_lage2))),'$\pm$',num2str(std(abs(vector_gesamt_lage2)))]);
    MAE_lage(n).gesammt=string_gesamt_lage2;
    
     string_gesamt_lage3=([num2str(mean(abs(vector_gesamt_lage3))),'$\pm$',num2str(std(abs(vector_gesamt_lage3)))]);
    NMSE_lage(n).gesammt=string_gesamt_lage3;
end
n=0;
p=0;
m=0;


for n =1 :length(phasen)
    phase=phasen{n};
    f=1;
    
    Idx=0;
    vector=0;
    
     if strcmp('spontanes_Atmen', phase)

        sa1=find (strcmp(('spontanes_Atmen_1'),{ME.phase}));
        sa2=find (strcmp(('spontanes_Atmen_2'),{ME.phase}));
        idx=[sa1, sa2];
      else
        
        idx = find (strcmp((phase),{ME.phase}));
      end
 
    
    ME_phase(n).phase=phase;
    MAE_phase(n).phase=phase;
    NMSE_phase(n).phase=phase;

    
    for p=1:length(allouts)
        filter= allouts{p};
       
        vector_gesamt_filter1=vertcat(ME.(filter));
        vector_gesamt_filter2=vertcat(MAE.(filter));
        vector_gesamt_filter3=vertcat(NMSE.(filter));
        
        for m=1:length(idx)
            row=idx(m);
            vector1(m)=ME(row).(filter);
            vector2(m)=MAE(row).(filter);
            vector3(m)=NMSE(row).(filter);
            
            vector_gesamt_phase1(f)=ME(row).(filter);
            vector_gesamt_phase2(f)=MAE(row).(filter);
            vector_gesamt_phase3(f)=NMSE(row).(filter);
            f=f+1;
            
        end
        string1=([num2str(mean(abs(vector1))),'$\pm$',num2str(std(abs(vector1)))]);
        ME_phase(n).(filter)=string1;
        
        string2=([num2str(mean(abs(vector2))),'$\pm$',num2str(std(abs(vector2)))]);
        MAE_phase(n).(filter)=string2;
        
        string3=([num2str(mean(abs(vector3))),'$\pm$',num2str(std(abs(vector3)))]);
        NMSE_phase(n).(filter)=string3;
        
        
        h=length(phasen)+1;
         
            ME_phase(h).phase='alle phasen';
            MAE_phase(h).phase='alle phasen';
            NMSE_phase(h).phase='alle phasen';
            
        string_gesamt_filter1=([num2str(mean(abs(vector_gesamt_filter1))),'$\pm$',num2str(std(abs(vector_gesamt_filter1)))]);
        ME_phase(h).(filter)=string_gesamt_filter1;
        
        string_gesamt_filter2=([num2str(mean(abs(vector_gesamt_filter1))),'$\pm$',num2str(std(abs(vector_gesamt_filter1)))]);
        MAE_phase(h).(filter)=string_gesamt_filter2;
        
        string_gesamt_filter3=([num2str(mean(abs(vector_gesamt_filter1))),'$\pm$',num2str(std(abs(vector_gesamt_filter1)))]);
        NMSE_phase(h).(filter)=string_gesamt_filter3;
        
        
    end
    string_gesamt_phase1=([num2str(mean(abs(vector_gesamt_phase1))),'$\pm$',num2str(std(abs(vector_gesamt_phase1)))]);
    ME_phase(n).gesamt=string_gesamt_phase1;
    
     string_gesamt_phase2=([num2str(mean(abs(vector_gesamt_phase2))),'$\pm$',num2str(std(abs(vector_gesamt_phase2)))]);
    MAE_phase(n).gesamt=string_gesamt_phase2;
    
     string_gesamt_phase3=([num2str(mean(abs(vector_gesamt_phase3))),'$\pm$',num2str(std(abs(vector_gesamt_phase3)))]);
    NMSE_phase(n).gesamt=string_gesamt_phase3;
end
filepath= pwd;

    me_p='\Ergebniss_structs\me_phase';
    fname=[filepath me_p];
    save(fname,'ME_phase');
    
    mae_p='\Ergebniss_structs\mae_phase';
    fname=[filepath mae_p];
    save(fname,'MAE_phase');
    
    nmse_p='\Ergebniss_structs\nmse_phase';
    fname=[filepath nmse_p];
    save(fname,'NMSE_phase');
    
    me_l='\Ergebniss_structs\me_lage';
    fname=[filepath  me_l];
    save(fname,'ME_lage');
    
    mae_l='\Ergebniss_structs\mae_lage';
    fname=[filepath mae_l];
    save(fname,'MAE_lage');
    
    nmse_l='\Ergebniss_structs\nmse_lage';
    fname=[filepath nmse_l];
    save(fname,'NMSE_lage');
end