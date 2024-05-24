function q = normQuat(q)
    %% Quaternion normieren
    Z = sqrt(q(:,1).^2 + q(:,2).^2 + q(:,3).^2 + q(:,4).^2);
    q = [q(:,1)./Z q(:,2)./Z q(:,3)./Z q(:,4)./Z];
end    