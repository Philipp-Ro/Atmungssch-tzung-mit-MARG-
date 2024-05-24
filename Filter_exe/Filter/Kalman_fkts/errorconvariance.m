function [ p3 ] = errorconvariance( p2,k )
H=eye(4);
p3=p2-k*H*p2;


end

