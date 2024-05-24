function [ qx2,p2 ] = kestimate( p,q,r,qx1,p1 )
%creating the estimate state variable
A=eye(4,4)+1/(1000)*0.5*[0,-p,-q,r;
                         p,0,r,-q;
                         q,-r,0,p;
                         r,q,-p,0;];
              

qx2=A*qx1; 

%creating the estimate for error convariance matrix
Q=1/10000*eye(4);
p2=A*p1*transpose(A)+Q;

end

