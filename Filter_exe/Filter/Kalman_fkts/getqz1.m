function [qz1] = getqz1(fx,fy,fz,mx,my,mz,qz2,zorg)

normieren=1/(sqrt(fx^2+fy^2+fz^2));
fx=normieren*fx;
fy=normieren*fy;
fz=normieren*fz;

g=9.81;

Accelerometervec=[fx,fy,fz];
Magnetometervec=[mx,my,mz];


mD=dot(Accelerometervec,Magnetometervec);
mN=sqrt(1-mD^2);
    

if strcmp('ACC',zorg)
%% ACC ONLY
phi=atan2((fy),sqrt(fx^2+fz^2));
theta=atan2(sqrt(fx^2+fy^2),(fz));
psi=atan2((fx),sqrt(fy^2+fz^2));




qz1=(4/3)*[cos(phi/2)*cos(theta/2)*cos(psi/2)+sin(phi/2)*sin(theta/2)*sin(psi/2);
           sin(phi/2)*cos(theta/2)*cos(psi/2)-cos(phi/2)*sin(theta/2)*sin(psi/2);
           cos(phi/2)*sin(theta/2)*cos(psi/2)+sin(phi/2)*cos(theta/2)*sin(psi/2);
           cos(phi/2)*cos(theta/2)*sin(psi/2)-sin(phi/2)*sin(theta/2)*cos(psi/2);];
       
elseif strcmp('ACC+MAG',zorg) 
%% ACC + MAG
       W_a=[fz,fy,-fx,0;
           fy,-fz,0,fx;
           -fx,0,-fz,fy;
           0,fx,fy,fz];
       
       W_m=[mN*mx+mD*mz,mD*my,mN*mz-mD*mx,-mN*my;
           mD*my,mN*mx-mD*mz,mN*my,mN*mz+mD*mx;
           mN*mz-mD*mx,mN*my,-mN*mx-mD*mz,mD*my;
           -mN*my,mN*mz+mD*mx,mD*my,-mN*mx+mD*mz];
       
       qz1=(1/4)*(W_a+eye(4))*(W_m+eye(4))*qz2;
end
end

