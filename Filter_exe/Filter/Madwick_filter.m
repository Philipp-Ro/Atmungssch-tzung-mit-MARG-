function [output_Mad] = Madwick_filter(nSamples,Gyroscope,Accelerometer,Magnetometer)
addpath('Filter_exe/Filter/quaternion_library');
%output_raw=zeros(4,nSamples);
quaternion = zeros(nSamples, 4);

 AHRS = MadgwickAHRS('SamplePeriod', 1/1000, 'Beta', 0.001);
% AHRS = MahonyAHRS('SamplePeriod', 1/sampleperiod, 'Kp', 1);
%% Madgwick 
for t = 1:(nSamples)
    AHRS.Update(Gyroscope(t,:)*(pi/180) , Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
    quaternion(t,:) = AHRS.Quaternion;
   
    
    output_Mad(:,t) = transpose(quaternion(t,:));
    
   
end
end

