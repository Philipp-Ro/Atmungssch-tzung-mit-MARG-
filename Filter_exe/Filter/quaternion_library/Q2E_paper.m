function euler = Q2E_paper(q)
    %% Quaternion normieren
    %Z = sqrt(q(:,1).^2 + q(:,2).^2 + q(:,3).^2 + q(:,4).^2);
    %q_z = [q(:,1)./Z q(:,2)./Z q(:,3)./Z q(:,4)./Z];
    
    Yaw     = atan2( 2*q_z(:,2)*q_z(:,3) - 2*q_z(:,1)*q_z(:,4) , 2*q_z(:,1)^2 + 2*q_z(:,2)^2 - 1);  % Yaw   = psi
    Pitch   =  asin( 2*q_z(:,2)*q_z(:,4) + 2*q_z(:,1)*q_z(:,3) );                                   % Pitch = theta
    Roll    = atan2( 2*q_z(:,3)*q_z(:,4) - 2*q_z(:,1)*q_z(:,2) , 2*q_z(:,1)^2 + 2*q_z(:,4)^2 - 1);  % Roll  = phi
    
    euler = [Yaw, Pitch, Roll];
end