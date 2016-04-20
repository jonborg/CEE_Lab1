A=[0 0 1 0; 0 0 0 1; 0 566 -37 0; 0 -922 37 0];
b=[0 0 65 -65]';
c=[1 1 0 0];

alphaK=poly([-70 -20 -1+5*1i -1-5*1i]);
alphaL=poly([-50 -50 -30 -30]);
a=poly(A);

CM=controlability(A,b);
OM=observability(A,c);
M=[1 0 0 0; a(2) 1 0 0; a(3) a(2) 1 0; a(4) a(3) a(2) 1];

K=(alphaK(2:5)-a(2:5))*inv(M)'*inv(CM)
L=inv(OM)*inv(M)*(alphaL(2:5)-a(2:5))'