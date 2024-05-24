%addpath('Filter_exe');
%A=load('ASUB.mat');

function[t] = sig_ohne_phasen(A)
addpath('Filter_exe');
msg='Please Wait';
    x=0;
   f = waitbar(x,msg);
    xi=1/(15);
    
      
for h =14:-1:1
x=x+xi;
waitbar(x);

 if(h==1)
        subj='SUB001';
        pos='supine';
        
    elseif(h==2)
       subj='SUB001';
       pos='latral';
       
    elseif(h==3)
       subj='SUB001';
       pos='prone'; 
       
    elseif(h==4)
       subj='SUB002';
       pos='supine'; 
   
    elseif(h==5)
       subj='SUB002';
       pos='latral'; 
       
    elseif(h==6)
       subj='SUB002';
       pos='prone'; 
       
    elseif(h==7)
       subj='SUB003';
       pos='supine';
       
    elseif(h==8)
       subj='SUB003';
       pos='latral';
       
    elseif(h==9)
       subj='SUB003';
       pos='prone';
       
    elseif(h==10)
       subj='SUB004';
       pos='supine';
       
    elseif(h==11)
       subj='SUB004';
       pos='latral';
       
    elseif(h==12)
       subj='SUB004';
       pos='prone';
     
    elseif(h==13)
       subj='SUB005';
       pos='supine';
       
    elseif(h==14)
       subj='SUB005';
       pos='prone';
       
 end
%% Parameters
    t(h).sub=subj;
    t(h).position=pos;
    t(h).smoker=A.(subj).parameters.smoker;
    t(h).age=A.(subj).parameters.age.value;
    t(h).height=A.(subj).parameters.height.value;
    t(h).chest=A.(subj).parameters.chest.value;
    t(h).waist=A.(subj).parameters.waist.value;
    t(h).weight=A.(subj).parameters.weight.value;
    t(h).gender=A.(subj).parameters.gender;
    
    
%% Filter_Ausgänge

    a= A.(subj).(pos).accelerometer.signal;
    b=A.(subj).(pos).gyrometer.signal;
    c=A.(subj).(pos).magnetometer.signal;
    ref_asub = A.(subj).(pos).pneumotachometer.signal;
    
    %Fliter_exe beinhaltet die komplette Vor- und Nachbereitung der SIgnale
    %sowie Kalman- und Madgwickfilter sovie die unterschiedlichen PCAs 
    
  [Mad_PCA,Kal_PCA_ACC,Kal_PCA_ACC_MAG,PCA_ACC,PCA_GYRO,PCA_MAG,PCA_ACC_GYRO,PCA_ACC_MAG,PCA_GYRO_MAG,PCA_ALL,ref,Accelerometer,Gyroscope, Magnetometer] = Filter_exe(a,b,c,ref_asub);
  
  

  
  %% in t schreiben 
    t(h).ACC_1=Accelerometer(:,1);
    t(h).ACC_2=Accelerometer(:,2);
    t(h).ACC_3=Accelerometer(:,3);
    t(h).GYRO_1=Gyroscope(:,1);
    t(h).GYRO_2=Gyroscope(:,2);
    t(h).GYRO_3=Gyroscope(:,3);
    t(h).MAG_1=Magnetometer(:,1);
    t(h).MAG_2=Magnetometer(:,2);
    t(h).MAG_3=Magnetometer(:,3);
    t(h).ref=ref;
    t(h).Madgwick_PCA=Mad_PCA;
%     t(h).Madgwick_q1=Mad(:,1);
%     t(h).Madgwick_q2=Mad(:,2);
%     t(h).Madgwick_q3=Mad(:,3);
%     t(h).Madgwick_q4=Mad(:,4);
%     t(h).Madgwick_Norm=Mad_Norm;
%     t(h).Madgwick_Prod=Mad_Prod;
    t(h).Kalman_PCA_ACC=Kal_PCA_ACC;
    t(h).Kalman_PCA_ACC_MAG=Kal_PCA_ACC_MAG;
%     t(h).Kalman_q1=Kal(:,1);
%     t(h).Kalman_q2=Kal(:,2);
%     t(h).Kalman_q3=Kal(:,3);
%     t(h).Kalman_q4=Kal(:,4);
%     t(h).Kalman_Norm=Kal_Norm;
%     t(h).Kalman_Prod=Kal_Prod;
    t(h).PCA_ACC=PCA_ACC;
    t(h).PCA_GYRO=PCA_GYRO;
    t(h).PCA_MAG=PCA_MAG;
    t(h).PCA_ACC_GYRO=PCA_ACC_GYRO;
    t(h).PCA_ACC_MAG=PCA_ACC_MAG;
    t(h).PCA_GYRO_MAG=PCA_GYRO_MAG;
    t(h).PCA_ALL=PCA_ALL;
    
  


end
    filepath= pwd;
    filename='\Ergebniss_structs\Signale_ohne_Atemphasen';
    fname=[filepath filename];
    save(fname,'t','-v7.3','-nocompression');
end
