function [ref,Accelerometer,Gyroscope,Magnetometer,nSamples] = SignalVorbereitung(a,b,c,ref_asub)

%% Daten skalieren 
    FS_accl         = 2/(2^15);
    FS_gyro         = 500/(2^15);
    FS_mag          = 8/(2^15);
    
    Accelerometer_raw=transpose(a).* FS_accl ;
    Gyroscope_raw=transpose(b).*FS_gyro;
    Magnetometer_lowsample=transpose(c).* FS_mag;
    
    %Magnetometer daten mit sample and hold auffüllen
    Magnetometer_raw= resample(Magnetometer_lowsample(1:end,:),10,1);
  
    
    %Pneumotachometersignal skalieren 
    %ref_raw = ref_raw(1:10:numel(ref_raw));
    ref_mean  = mean_and_normalize_pneumo(ref_asub);
    ref_raw=transpose(ref_mean);
    ref_raw=resample(ref_raw,1,10);
    
    %time vector erstellen
    time =1:length(Gyroscope_raw(:,1));

  
   

     addpath('Filter_exe/Filter');
    
    nSamples = round(length(time)/1);


%% tp und baselineremoval der rohsignale
 % windowsize movmean TP
    wintp=100;
    %windowsizebaseline removal
    winbl=100000;
    
    ref_tp = movmean(ref_raw,wintp);
    ref = ref_tp - movmean(ref_tp,winbl);
    
    for n=1:3
     Accelerometer_tp(:,n) = movmean( Accelerometer_raw(:,n),wintp);
     Accelerometer(:,n) =  Accelerometer_tp(:,n) - movmean( Accelerometer_tp(:,n),winbl);
     
     Gyroscope_tp(:,n) = movmean( Gyroscope_raw(:,n),wintp);
     Gyroscope(:,n) =  Gyroscope_tp(:,n) - movmean( Gyroscope_tp(:,n),winbl);
     
     Magnetometer_tp(:,n)= movmean( Magnetometer_raw(:,n),wintp);
     Magnetometer(:,n) =  Magnetometer_tp(:,n) - movmean( Magnetometer_tp(:,n),winbl);
     
     
    end
    
    

end

