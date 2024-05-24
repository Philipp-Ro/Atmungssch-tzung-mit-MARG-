function [output_PCA_ACC,output_PCA_GYRO,output_PCA_MAG,output_PCA_ACC_GYRO,output_PCA_ACC_MAG,output_PCA_GYRO_MAG,output_PCA_ALL] = PCA_filter(Accelerometer_diff,Gyroscope,Magnetometer_diff)



%% PCA ACCELEROMETER
coeff=pca(Accelerometer_diff);
coeff_LD=coeff(:,1);
output_PCA_ACC=Accelerometer_diff*coeff_LD;

%% PCA GYROSCOPE
coeff=pca(Gyroscope);
coeff_LD=coeff(:,1);
output_PCA_GYRO=Gyroscope*coeff_LD;

%% PCA MAGNETOMETER
coeff=pca(Magnetometer_diff);
coeff_LD=coeff(:,1);
output_PCA_MAG=Magnetometer_diff*coeff_LD;

%% PCA ACC+GYRO
ACC_GYRO=cat(2,Accelerometer_diff,Gyroscope);
coeff=pca(ACC_GYRO);
coeff_LD=coeff(:,1);
output_PCA_ACC_GYRO=ACC_GYRO*coeff_LD;


%% PCA ACC+MAG
ACC_MAG=cat(2,Accelerometer_diff,Magnetometer_diff);
coeff=pca(ACC_MAG);
coeff_LD=coeff(:,1);
output_PCA_ACC_MAG=ACC_MAG*coeff_LD;


%% PCA GYRO+MAG
GYRO_MAG=cat(2,Gyroscope,Magnetometer_diff);
coeff=pca(GYRO_MAG);
coeff_LD=coeff(:,1);
output_PCA_GYRO_MAG=GYRO_MAG*coeff_LD;

%% PCA ALL
ALL=cat(2,Accelerometer_diff,Gyroscope,Magnetometer_diff);
coeff=pca(ALL);
coeff_LD=coeff(:,1);
output_PCA_ALL=ALL*coeff_LD;
end

