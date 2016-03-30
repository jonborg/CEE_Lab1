A=[0 0 1 0; 0 0 0 1; 0 566 -37 0; 0 -922 37 0];
b=[0 0 65 -65]';
c=[1 1 0 0];

C=[b A*b A*A*b A*A*A*b];

if rank(C)==4
    display('Controlable system');
else
    display('Not fully controllable system');
end

O=[c; c*A; c*A*A; c*A*A*A];

if rank(O)==4
    display('Observable system');
else
    display('Not fully observable system');
end

%%
[NUM,DEN] = ss2tf(A,b,c,0);
sys = tf(NUM,DEN);
bode(sys);

%%
a1=charpoly(A);
a=a1(2:5);
alphac1=poly([-70 -20 -10 -10]);
alphac=alphac1(2:5);
M=[1 0 0 0; a(1) 1 0 0; a(2) a(1) 1 0; a(3) a(2) a(1) 1];

K=(alphac-a)*((M^-1)')*(C^-1)

alphao1=poly([-50 -50 -30 -30]);
alphao=alphao1(2:5);

L=(O^-1)*(M^-1)*(alphao-a)'

eig(A+b*K)
eig(A+L*c)
eig([(A+b*K) (b*K); (zeros(4)) (A+L*c)])

%%
syms s;
gc=-K*((s*eye(4)-A+L*c+b*K)^-1)*L
%%
%run simulink
plot(symout);
hold;
plot(symout1);
%xlabel,ylabel,legend obrigatorios