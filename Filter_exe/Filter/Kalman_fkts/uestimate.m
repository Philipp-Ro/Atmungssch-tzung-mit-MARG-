function [qx3,qz2]= uestimate  (qx2,k,qz1)
H=eye(4);
qx3=qx2+k*(qz1-H*qx2);
%update the state estimate qx3 with the mesurement qz1
qz2=qz1;
end