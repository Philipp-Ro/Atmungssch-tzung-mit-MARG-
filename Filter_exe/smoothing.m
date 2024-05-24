function [Mad_PCA,Mad_Prod,Mad_Norm,Kal_PCA,Kal_Prod,Kal_Norm,PCA_ACC,PCA_GYRO,PCA_MAG,PCA_ACC_GYRO,PCA_ACC_MAG,PCA_GYRO_MAG,PCA_ALL] = smoothing(Mad_PCA_raw,Mad_Prod_raw,Mad_Norm_raw,Kal_PCA_raw,Kal_Prod_raw,Kal_Norm_raw,PCA_ACC_raw,PCA_GYRO_raw,PCA_MAG_raw,PCA_ACC_GYRO_raw,PCA_ACC_MAG_raw,PCA_GYRO_MAG_raw,PCA_ALL_raw)

%% Smoothing 
%gloay smoothing oder and framelength
order=3;
framelen=2001;

%movmean windowlength baseline removal
winlength=20000;

%golaysmoothing


Mad_PCA_fil=sgolayfilt(Mad_PCA_raw,order,framelen);
Mad_Prod_fil=sgolayfilt(Mad_Prod_raw,order,framelen);
Mad_Norm_fil=sgolayfilt(Mad_Norm_raw,order,framelen);

Kal_PCA_fil=sgolayfilt(Kal_PCA_raw,order,framelen);
Kal_Prod_fil=sgolayfilt(Kal_Prod_raw,order,framelen);
Kal_Norm_fil=sgolayfilt(Kal_Norm_raw,order,framelen);

PCA_ACC_fil=sgolayfilt(PCA_ACC_raw,order,framelen);
PCA_GYRO_fil=sgolayfilt(PCA_GYRO_raw,order,framelen);
PCA_MAG_fil=sgolayfilt(PCA_MAG_raw,order,framelen);
PCA_ACC_GYRO_fil=sgolayfilt(PCA_ACC_GYRO_raw,order,framelen);
PCA_ACC_MAG_fil=sgolayfilt(PCA_ACC_MAG_raw,order,framelen);
PCA_GYRO_MAG_fil=sgolayfilt(PCA_GYRO_MAG_raw,order,framelen);
PCA_ALL_fil=sgolayfilt(PCA_ALL_raw,order,framelen);

%movmean


Mad_PCA= Mad_PCA_fil - movmean(Mad_PCA_fil, winlength);
Mad_Prod= Mad_Prod_fil - movmean(Mad_Prod_fil, winlength);
Mad_Norm= Mad_Norm_fil - movmean(Mad_Norm_fil, winlength);

Kal_PCA= Kal_PCA_fil - movmean(Kal_PCA_fil, winlength);
Kal_Prod= Kal_Prod_fil - movmean(Kal_Prod_fil, winlength);
Kal_Norm= Kal_Norm_fil - movmean(Kal_Norm_fil, winlength);

PCA_ACC = PCA_ACC_fil - movmean(PCA_ACC_fil, winlength);
PCA_GYRO = PCA_GYRO_fil - movmean(PCA_GYRO_fil, winlength);
PCA_MAG = PCA_MAG_fil - movmean(PCA_MAG_fil, winlength);
PCA_ACC_GYRO = PCA_ACC_GYRO_fil - movmean(PCA_ACC_GYRO_fil, winlength);
PCA_ACC_MAG = PCA_ACC_MAG_fil - movmean(PCA_ACC_MAG_fil, winlength);
PCA_GYRO_MAG = PCA_GYRO_MAG_fil - movmean(PCA_GYRO_MAG_fil, winlength);
PCA_ALL = PCA_ALL_fil - movmean(PCA_ALL_fil, winlength);






end

