function q = makeQuat(theta,quaternion)
    Z = sqrt(quaternion(:,1).^2 + quaternion(:,2).^2 + quaternion(:,3).^2 + quaternion(:,4).^2);
    q = cos(theta./2.) + sin(theta./2.) * (Z.*(quaternion));
end