function [rr] = resp_rate(z,allouts)
allouts=['ref',allouts];
fs=1000;
method='fft';
varargin={'frames',30,50};

   msg='Please Wait';
   x=0;
   f = waitbar(x,msg);
    xi=1/(70);
    
    
 for h=length(z):-1:1           
     x=x+xi;
     waitbar(x);

     
     
     
     rr(h).sub=z(h).sub;
     rr(h).position=z(h).position;
     rr(h).phase=z(h).phase;
     rr(h).smoker=z(h).smoker;
     rr(h).age=z(h).age;
     rr(h).height=z(h).height;
     rr(h).chest=z(h).chest;
     rr(h).waist=z(h).waist;
     rr(h).weight=z(h).weight;
     rr(h).gender=z(h).gender;
     
     for p=1:length(allouts)
            
            data=allouts{p}; 
            feld=(data);
                [frames,rates] = respFreq(z(h).(data),fs,method,'frames',30,50);
            
            resprate_Bpm=60*rates;
            rr(h).(feld)=resprate_Bpm;
     end
 end
  filepath= pwd;
    filename='\Ergebniss_structs\rr';
    fname=[filepath filename];
    save(fname,'rr');
end
