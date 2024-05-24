function [Mad_PCA,Kal_PCA_ACC,Kal_PCA_ACC_MAG,PCA_ACC,PCA_GYRO,PCA_MAG,PCA_ACC_GYRO,PCA_ACC_MAG,PCA_GYRO_MAG,PCA_ALL,ref,Accelerometer,Gyroscope, Magnetometer] = Filter_exe(a,b,c,ref_asub)

[ref,Accelerometer,Gyroscope,Magnetometer,nSamples] = SignalVorbereitung(a,b,c,ref_asub);
    % Magnetometerdaten ableiten 
    Magnetometer_diff=diff(Magnetometer,1,1);
    extention=[0,0,0];
    Magnetometer_diff=vertcat(Magnetometer_diff,extention);

    Accelerometer_diff=diff(Accelerometer,1,1);
    extention=[0,0,0];
    Accelerometer_diff=vertcat(Accelerometer_diff,extention);

%% Filter

%% Madgwick
    [output_Mad] = Madwick_filter(nSamples,Gyroscope,Accelerometer,Magnetometer);
   
%% diff    
    output_Mad=[transpose(diff(transpose(output_Mad(1,:))));transpose(diff(transpose(output_Mad(2,:))));transpose(diff(transpose(output_Mad(3,:))));transpose(diff(transpose(output_Mad(1,:))))];
%%   PCA 
        coeff=pca(transpose(output_Mad));     
        coeff_LD=coeff(:,1);
    Mad_PCA_raw=transpose(output_Mad)*coeff_LD;

%% Kalman 

Magnetometer_input= Magnetometer_diff;

     
    [output_Kalman_ACC,output_Kalman_ACC_MAG] = Kalman_filter(nSamples,Accelerometer,Gyroscope,Magnetometer_input);
    %% Diff
    output_Kalman_ACC=[transpose(diff(transpose(output_Kalman_ACC(1,:))));transpose(diff(transpose(output_Kalman_ACC(2,:))));transpose(diff(transpose(output_Kalman_ACC(3,:))));transpose(diff(transpose(output_Kalman_ACC(4,:))))];
    output_Kalman_ACC_MAG=[transpose(diff(transpose(output_Kalman_ACC_MAG(1,:))));transpose(diff(transpose(output_Kalman_ACC_MAG(2,:))));transpose(diff(transpose(output_Kalman_ACC_MAG(3,:))));transpose(diff(transpose(output_Kalman_ACC_MAG(4,:))))];

    %% PCA
        coeff=pca(transpose(output_Kalman_ACC));
        coeff_LD=coeff(:,1);
    Kal_PCA_raw_ACC=transpose(output_Kalman_ACC)*coeff_LD;
    
     coeff=pca(transpose(output_Kalman_ACC_MAG));
        coeff_LD=coeff(:,1);
    Kal_PCA_raw_ACC_MAG=transpose(output_Kalman_ACC_MAG)*coeff_LD;

%% PCA  

 
    [output_PCA_ACC,output_PCA_GYRO,output_PCA_MAG,output_PCA_ACC_GYRO,output_PCA_ACC_MAG,output_PCA_GYRO_MAG,output_PCA_ALL] = PCA_filter(Accelerometer_diff,Gyroscope,Magnetometer_diff);
    PCA_ACC_raw=output_PCA_ACC;
    PCA_GYRO_raw=output_PCA_GYRO;
    PCA_MAG_raw=output_PCA_MAG;
    PCA_ACC_GYRO_raw=output_PCA_ACC_GYRO;
    PCA_ACC_MAG_raw=output_PCA_ACC_MAG;
    PCA_GYRO_MAG_raw=output_PCA_GYRO_MAG;
    PCA_ALL_raw=output_PCA_ALL;
   
    

 %% Smoothing 
 [Mad_PCA,Kal_PCA_ACC,Kal_PCA_ACC_MAG,PCA_ACC,PCA_GYRO,PCA_MAG,PCA_ACC_GYRO,PCA_ACC_MAG,PCA_GYRO_MAG,PCA_ALL] = SignalNachbearbeitung(Mad_PCA_raw,Kal_PCA_raw_ACC,Kal_PCA_raw_ACC_MAG,PCA_ACC_raw,PCA_GYRO_raw,PCA_MAG_raw,PCA_ACC_GYRO_raw,PCA_ACC_MAG_raw,PCA_GYRO_MAG_raw,PCA_ALL_raw);


end

