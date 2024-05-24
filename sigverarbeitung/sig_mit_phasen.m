%addpath('Ergebniss_structs');
%load('Ergebnisse_ohne_Atemphasen');
%A=load('ASUB.mat');
function [z] =sig_mit_phasen(phasen,allouts,t,A)


    j=1;
    for h=1:length(t)
           
          for p=1:length(phasen) 
              
              phase=phasen{p};
                full_signal=floor(h);
                subj=t(full_signal).sub;
                pos=t(full_signal).position;
                index=find (strcmp((phase),{A.(subj).(pos).annotations.description}));
                
%                 if strcmp('spont.Atmung_1', phase) 
%                     index=find (strcmp(('spont. Atmung'),{A.(subj).(pos).annotations.description}));
%                     index=index(1);
%                 else strcmp('spont.Atmung_2', phase) 
%                     index=find (strcmp(('spont. Atmung'),{A.(subj).(pos).annotations.description}));
%                     index=index(2);
%                 end
          U=length(index);
         for k=1:U
             %index=index(k);
  
        
    %anotationen für phasen auslesen 
    start_s(k)=A.(subj).(pos).annotations(index(k)).start;
    stop_s(k)=A.(subj).(pos).annotations(index(k)).stop;
         end
   %% Parameter
  
     z(j).sub=subj;
     z(j).position=pos;
     z(j).phase=phase;
     z(j).smoker=A.(subj).parameters.smoker;
     z(j).age=A.(subj).parameters.age.value;
     z(j).height=A.(subj).parameters.height.value;
     z(j).chest=A.(subj).parameters.chest.value;
     z(j).waist=A.(subj).parameters.waist.value;
     z(j).weight=A.(subj).parameters.weight.value;
     z(j).gender=A.(subj).parameters.gender;
     
        for p=1:length(allouts)
            
            data=allouts{p}; 

        
%% Signale schneiden
%start stop von s noch sample 

    mult=1000;
    mult_ref=1000;
    
    start=start_s*mult;
    stop=stop_s*mult;
    
     z(j).ref=[];
     z(j).(data)=[];
     
    for k=1:U
   %ref_sig=resample(t(full_signal).ref,1,10);
    ref_sig=t(full_signal).ref;
    start_ref(k)=start_s(k)*mult_ref;
    stop_ref(k)=stop_s(k)*mult_ref;

     a=ref_sig(start_ref(k):stop_ref(k));
     
     z(j).ref=[z(j).ref;a];
    %z(h).ref=t(full_signal).ref(start_ref:stop_ref);
    b=t(full_signal).(data)(start(k):stop(k));
    z(j).(data)=[z(j).(data);b];
    end
        end
        j=j+1;
        end
    end
    filepath= pwd;
    filename='\Ergebniss_structs\Signale_mit_Atemphasen';
    fname=[filepath filename];
    save(fname,'z','-v7.3','-nocompression');
end