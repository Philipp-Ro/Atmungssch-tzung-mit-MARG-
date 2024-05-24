function [k]= kgain(p2)
H=[1,0,0,0;
   0,1,0,0;
   0,0,1,0;
   0,0,0,1];

R=100*eye(4);

k=p2*transpose(H)/(H*p2*transpose(H)+R);
%calculating Kalman gain
end