function [cc_lage_abs, cc_lage,cc_phase_abs,cc_phase] = cc_tabellen(phasen,lagen,allouts,cc)
for n =length(lagen):-1 :1
    lage=lagen{n};
    f=1;
    
    Idx=0;
    vector=0;
    
    %index bleibt gleich 
    idx = find (strcmp((lage),{cc.position}));
    cc_lage_abs(n).lage=lage;
    cc_lage(n).lage=lage;

    
    for p=length(allouts):-1:1
        filter= allouts{p};
       
        vector_gesamt_filter=vertcat(cc.(filter));
        
        
        for m=length(idx):-1:1
            row=idx(m);
            
            vector(m)=cc(row).(filter); 
            vector_gesamt_lage(f)=cc(row).(filter);
            
            f=f+1;
            
        end
        cc_lage_abs(n).(filter)=([mean(abs(vector)),std(abs(vector))]);
        
        cc_lage(n).(filter)=([mean(vector),std(vector)]);
        
        
        
        
        h=length(lagen)+1;
        
            cc_lage_abs(h).lage='alle_Lagen';
            cc_lage(h).lage='alle_Lagen';
            
        cc_lage_abs(h).(filter)=([mean(abs(vector_gesamt_filter)),std(abs(vector_gesamt_filter))]);
        
        cc_lage(h).(filter)=([mean(vector_gesamt_filter),std(vector_gesamt_filter)]);
        
        
        
    end
    cc_lage_abs(n).gesamt=([mean(abs(vector_gesamt_lage)),std(abs(vector_gesamt_lage))]);
    
    cc_lage(n).gesamt=([mean(vector_gesamt_lage),std(vector_gesamt_lage)]);
    
end


for n =length(phasen):-1 :1
    phase=phasen{n};
    f=1;
    Idx=0;
    vector=0;
    
    %index bleibt gleich 
    
        
        idx = find (strcmp((phase),{cc.phase}));
      
    
   cc_phase_abs(n).phase=phase;
   cc_phase(n).phase=phase; 
   
    for p=length(allouts):-1:1
        filter=allouts{p};
       
        vector_gesamt_filter=vertcat(cc.(filter));
        
        for m=length(idx):-1:1
            row=idx(m);
            vector(m)=cc(row).(filter);
            
            vector_gesamt_phase(f)=cc(row).(filter);
            
            f=f+1;
            
        end
        cc_phase_abs(n).(filter)=([mean(abs(vector)),std(abs(vector))]);
        
        cc_phase(n).(filter)=([mean(vector),std(vector)]);
        
        
        
        h=length(phasen)+1;
        
            cc_phase_abs(h).phase='alle_Phasen';
            cc_phase(h).phase='alle_Phasen';
            
        cc_phase_abs(h).(filter)=([mean(abs(vector_gesamt_filter)),std(abs(vector_gesamt_filter))]);
        
        
        cc_phase(h).(filter)=([mean(vector_gesamt_filter),std(vector_gesamt_filter)]);
        
       
        
    end
    cc_phase_abs(n).gesamt=([mean(abs(vector_gesamt_phase)),std(abs(vector_gesamt_phase))]);
      
    cc_phase(n).gesamt=([mean(vector_gesamt_phase),std(vector_gesamt_phase)]);
   
end
filepath= pwd;

    tabelle_lage='\Ergebniss_structs\cc_lage';
    fname=[filepath tabelle_lage];
    save(fname,'cc_lage');
    
    tabelle_lage_abs='\Ergebniss_structs\cc_lage_abs';
    fname=[filepath tabelle_lage_abs];
    save(fname,'cc_lage_abs');
    
    tabelle_phase='\Ergebniss_structs\cc_phase';
    fname=[filepath tabelle_phase];
    save(fname,'cc_phase');
    
    tabelle_phase_abs='\Ergebniss_structs\cc_phase_abs';
    fname=[filepath tabelle_phase_abs];
    save(fname,'cc_phase_abs');
    
    
end