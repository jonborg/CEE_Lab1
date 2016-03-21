function [num, den] = ss_bode( A, B, C, D )
%ss_bode: Shows bode diagram of the system given its space state model
%   Assuming a system defined by space state equations:
%   dx/dt=Ax+Bu
%   y=Cx+Du

[num,den]=ss2tf(A,B,C,D);
bode(tf(num,den));

end

