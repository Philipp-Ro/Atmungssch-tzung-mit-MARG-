function [qx,phi,theta,psi] = getqx(phi,theta,psi)

%phi=Gyroscope(:,3)*(pi/180);
%theta=Gyroscope(:,2)* (pi/180);
%psi=Gyroscope(:,1)* (pi/180);
 

qx=[cos(phi/2)*cos(theta/2)*cos(psi/2)+sin(phi/2)*sin(theta/2)*sin(psi/2);
    sin(phi/2)*cos(theta/2)*cos(psi/2)-cos(phi/2)*sin(theta/2)*sin(psi/2);
    cos(phi/2)*sin(theta/2)*cos(psi/2)+sin(phi/2)*cos(theta/2)*sin(psi/2);
    cos(phi/2)*cos(theta/2)*sin(psi/2)-sin(phi/2)*sin(theta/2)*cos(psi/2);];

end

