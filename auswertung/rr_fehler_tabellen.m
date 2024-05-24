%in den tabellen ist der erste wert jedes eintrags der mittelwert und der
%zweite die standartabweichung

function[ME_lage,MAE_lage,NMSE_lage,ME_phase,MAE_phase, NMSE_phase] =rr_fehler_tabellen(phasen,lagen,allouts,rr)
for g=length(rr):-1:1
    
     for b=length(allouts):-1:1
         filter= allouts{b}; 
         filter_RR=filter;
         
         ME(g).(filter)=sum(rr(g).(filter_RR)-rr(g).ref)/length(rr(g).(filter_RR));
         ME(g).position=rr(g).position;
         ME(g).phase=rr(g).phase;
         
         MAE(g).(filter)=sum(abs(rr(g).(filter_RR)-rr(g).ref))/length(rr(g).(filter_RR));
         MAE(g).position=rr(g).position;
         MAE(g).phase=rr(g).phase;
         
         NMSE(g).(filter)=(sum((rr(g).(filter_RR)-rr(g).ref).^2)/sum((rr(g).ref.^2)))*100;
         NMSE(g).position=rr(g).position;
         NMSE(g).phase=rr(g).phase;   
     end
end


for n =length(lagen):-1 :1
    lage=lagen{n};
    f=1;
    
    Idx=0;
    vector=0;
    
    %index bleibt gleich 
    idx = find (strcmp((lage),{ME.position}));
    
    ME_lage(n).lage=lage;
    MAE_lage(n).lage=lage;
    NMSE_lage(n).lage=lage;

    
    for p=length(allouts):-1:1
        filter= allouts{p};
       
        vector_gesamt_filter1=vertcat(ME.(filter));
        vector_gesamt_filter2=vertcat(MAE.(filter));
        vector_gesamt_filter3=vertcat(NMSE.(filter));
        
        for m=length(idx):-1:1
            row=idx(m);
            vector1(m)=ME(row).(filter);
            vector2(m)=MAE(row).(filter);
            vector3(m)=NMSE(row).(filter);
            
            vector_gesamt_lage1(f)=ME(row).(filter);
            vector_gesamt_lage2(f)=MAE(row).(filter);
            vector_gesamt_lage3(f)=NMSE(row).(filter);
            f=f+1;
            
        end
        ME_lage(n).(filter)=[mean(abs(vector1)),std(abs(vector1))];
        
        
        MAE_lage(n).(filter)=[mean(abs(vector2)),std(abs(vector2))];
        
        
        NMSE_lage(n).(filter)=[mean(abs(vector3)),std(abs(vector3))];
        
        
        
        h=length(lagen)+1;
        
            ME_lage(h).lage='alle_Lagen';
            MAE_lage(h).lage='alle_Lagen';
            NMSE_lage(h).lage='alle_Lagen';
        
        ME_lage(h).(filter)=[mean(abs(vector_gesamt_filter1)),std(abs(vector_gesamt_filter1))];
       
        MAE_lage(h).(filter)=[mean(abs(vector_gesamt_filter2)),std(abs(vector_gesamt_filter2))];
        
        NMSE_lage(h).(filter)=[mean(abs(vector_gesamt_filter3)),std(abs(vector_gesamt_filter3))];
        
        
        
    end
     ME_lage(n).gesamt=[mean(abs(vector_gesamt_lage1)),std(abs(vector_gesamt_lage1))];

     MAE_lage(n).gesamt=[mean(abs(vector_gesamt_lage2)),std(abs(vector_gesamt_lage2))];
    
     NMSE_lage(n).gesamt=[mean(abs(vector_gesamt_lage3)),std(abs(vector_gesamt_lage3))];
    
end
n=0;
p=0;
m=0;


for n =length(phasen):-1 :1
    phase=phasen{n};
    f=1;
    
    Idx=0;
    vector=0;

        
        idx = find (strcmp((phase),{ME.phase}));
      
 
    
    ME_phase(n).phase=phase;
    MAE_phase(n).phase=phase;
    NMSE_phase(n).phase=phase;

    
    for p=length(allouts):-1:1
        filter= allouts{p};
       
        vector_gesamt_filter1=vertcat(ME.(filter));
        vector_gesamt_filter2=vertcat(MAE.(filter));
        vector_gesamt_filter3=vertcat(NMSE.(filter));
        
        for m=length(idx):-1:1
            row=idx(m);
            vector1(m)=ME(row).(filter);
            vector2(m)=MAE(row).(filter);
            vector3(m)=NMSE(row).(filter);
            
            vector_gesamt_phase1(f)=ME(row).(filter);
            vector_gesamt_phase2(f)=MAE(row).(filter);
            vector_gesamt_phase3(f)=NMSE(row).(filter);
            f=f+1;
            
        end
        ME_phase(n).(filter)=[mean(abs(vector1)),std(abs(vector1))];
        
        
        MAE_phase(n).(filter)=[mean(abs(vector2)),std(abs(vector2))];
        
        
        NMSE_phase(n).(filter)=[mean(abs(vector3)),std(abs(vector3))];
        
        
        h=length(phasen)+1;
         
            ME_phase(h).phase='alle_Phasen';
            MAE_phase(h).phase='alle_Phasen';
            NMSE_phase(h).phase='alle_Phasen';
            
        ME_phase(h).(filter)=[mean(abs(vector_gesamt_filter1)),std(abs(vector_gesamt_filter1))];
        
         MAE_phase(h).(filter)=[mean(abs(vector_gesamt_filter2)),std(abs(vector_gesamt_filter2))];
        
        NMSE_phase(h).(filter)=[mean(abs(vector_gesamt_filter3)),std(abs(vector_gesamt_filter3))];
        
        
        
    end
    ME_phase(n).gesamt=[mean(abs(vector_gesamt_phase1)),std(abs(vector_gesamt_phase1))];
    
     MAE_phase(n).gesamt=[mean(abs(vector_gesamt_phase2)),std(abs(vector_gesamt_phase2))];
    
    
     NMSE_phase(n).gesamt=[mean(abs(vector_gesamt_phase3)),std(abs(vector_gesamt_phase3))];
    
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