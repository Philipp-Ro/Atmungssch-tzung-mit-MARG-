function [output_Kalman_ACC,output_Kalman_ACC_MAG] = Kalman_filter(nSamples,Accelerometer,Gyroscope,Magnetometer_input)
addpath('Filter_exe/Filter/Kalman_fkts');

    %Initial condition für Kalman definieren   
    p1=eye(4);
    qx1=[1;0;0;0];
    qz2=[1;0;0;0];
    output_raw=zeros(4,nSamples);



    %angular velocity from deg/s to rad/s
    p=Gyroscope(:,1)*(pi/180);
    q=Gyroscope(:,2)*(pi/180);
    r=Gyroscope(:,3)*(pi/180);

%% Kalman filter
    for n= 1:2
        if n ==1
            zorg='ACC';
        elseif n== 2
            zorg='ACC+MAG';
        end
    
        for t = 1:(nSamples)
    
   
            %Prediction
            [qx2,p2]= kestimate(p(t),q(t),r(t),qx1,p1);
   
            %KalmanGain
            k=kgain(p2);
  
            %Measurement
            qz1=getqz1(Accelerometer(t,1),Accelerometer(t,2),Accelerometer(t,3),Magnetometer_input(t,1),Magnetometer_input(t,2),Magnetometer_input(t,3),qz2,zorg);
   
            %Fusion
            qx3=uestimate(qx2,k,qz1);
   
            %ErrorMatrix
            p3=errorconvariance(p2,k);
    
            %Sample n = Sample n-1
            p1=p3;
            qx1=qx3;
    
            %output
            if n ==1
                output_Kalman_ACC(:,t) = qx3;
            elseif n== 2
                output_Kalman_ACC_MAG(:,t) = qx3;
            end
    
        end
   
    end
    
end

