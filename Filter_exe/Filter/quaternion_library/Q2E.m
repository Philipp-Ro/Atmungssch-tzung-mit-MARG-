%% nach DIN70000
function euler = Q2E(q)
    %% Quaternion normieren
    Z = sqrt(q(:,1).^2 + q(:,2).^2 + q(:,3).^2 + q(:,4).^2);
    qz = [q(:,1)./Z q(:,2)./Z q(:,3)./Z q(:,4)./Z];
    
    %% Quaternion in Euler umrechnen
    Yaw     = atan2(2.0*(qz(:,2)*qz(:,3)+qz(:,1)*qz(:,4)),(qz(:,1)^2+qz(:,2)^2-qz(:,3)^2-qz(:,4)^2)) * 180.0/pi;
    Pitch   = asin(2.0*(qz(:,1)*qz(:,3)-qz(:,2)*qz(:,4))) * 180.0/pi;
    Roll    = atan2(2.0*(qz(:,3)*qz(:,4)+qz(:,1)*qz(:,2)),-(qz(:,1)^2-qz(:,2)^2-qz(:,3)^2+qz(:,4)^2)) * 180.0/pi;
    
    euler = [Yaw, Pitch, Roll];
end