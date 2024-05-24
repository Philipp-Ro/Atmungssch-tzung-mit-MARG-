function [cc] = correcoeff(z,allouts)


 for h=1:length(z)          
     
     cc(h).sub=z(h).sub;
     cc(h).position=z(h).position;
     cc(h).phase=z(h).phase;
     cc(h).smoker=z(h).smoker;
     cc(h).age=z(h).age;
     cc(h).height=z(h).height;
     cc(h).chest=z(h).chest;
     cc(h).waist=z(h).waist;
     cc(h).weight=z(h).weight;
     cc(h).gender=z(h).gender;
     
     


     
%% correlations coefficent
    for p=1:length(allouts)
         
            
            data=allouts{p}; 
            
           % Signal=resample(z(h).(data),10,1);
            
            Signal=z(h).(data);
            feld=(data);
            cc(h).(feld)=corr(Signal,z(h).ref);
    end
 end
 filepath= pwd;
 filename='\Ergebniss_structs\cc';
 fname=[filepath filename];
 save(fname,'cc');
end
