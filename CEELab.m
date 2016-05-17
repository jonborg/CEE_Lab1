%% Ex.1
% Matriz de Controlabilidade
A=[0 0 1 0; 0 0 0 1; 0 566 -37 0; 0 -922 37 0];
b=[0 0 65 -65]';
c=[1 1 0 0];

CM=[b A*b A*A*b A*A*A*b]
    
if rank(CM)<4
    display('The system is NOT controlable');
else
    display('The system IS controlable');
end

%% Ex.2
% Matriz de Observalidade

OM=[c;c*A;c*A*A;c*A*A*A]
  
if rank(OM)<4
    display('The system is NOT observable');
else
    display('The system IS observable');
end
%% Ex.3
% Diagrama de Bode para o sistema em cadeia aberta
    
[num,den]=ss2tf(A,b,c,0);
comp=tf(num,den)
poles=pole(comp)
bode(comp);

%% Ex.4
% Projecção dos ganhos K e L

alphaK=poly([-70 -20 -10 -10]);
alphaL=poly([-50 -50 -30 -30]);
a=poly(A);

M=[1 0 0 0; a(2) 1 0 0; a(3) a(2) 1 0; a(4) a(3) a(2) 1];

K=(alphaK(2:5)-a(2:5))*inv(M)'*inv(CM)
L=inv(OM)*inv(M)*(alphaL(2:5)-a(2:5))'

%% Ex.5
% Simulação do sistema com compensador

open_system('p5');
sim('p5');
figure
plot(ref);
hold on
plot(y,'r');
hold off
xlabel('Time(s)');
ylabel('y');
%% Ex.6
% Diagrama de Bode para o sistema em cadeia fechada

[num,dem]=ss2tf(A,b,c,0);
sist=tf(num,dem);
[num,dem]=ss2tf(A-L*c-b*K,-L,-K,0);
comp=tf(num,dem);
transf=series(comp,sist);
transf=feedback(transf,1)
bode(transf)
p=pole(transf)
z=zero(transf)

%% Ex.7
% Ensaio com o sistema real

load('matlab_ex7_com2filtros.mat');
plot(rf(:,1),rf(:,2),p(:,1),p(:,2)+g(:,2),'r')
xlabel('Time(s)');
ylabel('y');
%% Ex.7-Continuação
% Ensaio com integrador

A=[0 0 1 0; 0 0 0 1; 0 566 -37 0; 0 -922 37 0];
b=[0 0 65 -65]';
c=[1 1 0 0];

A2=[A b;0 0 0 0 0];
b2=[zeros(4,1); 1];
c2=[c 0];

alphaK=poly([-70 -20 -10 -10 -50])
alphaL=poly([-50 -50 -30 -30 -30])
a=poly(A2)

CM2=[b2 A2*b2 A2*A2*b2 A2*A2*A2*b2 A2*A2*A2*A2*b2]
OM2=[c2;c2*A2;c2*A2*A2;c2*A2*A2*A2;c2*A2*A2*A2*A2]
M2=[1 0 0 0 0; 
    a(2) 1 0 0 0; 
    a(3) a(2) 1 0 0; 
    a(4) a(3) a(2) 1 0; 
    a(5) a(4) a(3) a(2) 1];
K=(alphaK(2:6)-a(2:6))*inv(M2)'*inv(CM2)
L=inv(OM2)*inv(M2)*(alphaL(2:6)-a(2:6))'

load('matlab_exint.mat');
plot(rf(:,1),rf(:,2),p(:,1),p(:,2)+g(:,2),'r')
xlabel('Time(s)');
ylabel('y');

%% Ex.8
% Ensaio sem pré-filtro

load('matlab_ex8_semfiltro.mat')
plot(rf(:,1),rf(:,2),p(:,1),p(:,2)+g(:,2),'r')
xlabel('Time(s)');
ylabel('y');
%% Ex.9
% Efeito da frequência de corte do pré-filtro

load('matlab_ex9_wn1_2566.mat')
plot(rf(:,1),rf(:,2),p(:,1),p(:,2)+g(:,2),'r')
xlabel('Time(s)');
ylabel('y');

%% Ex.10
% Ensaio sem sinal do extensómetro

load('matlab_ex7_com2filtros.mat')
original=[p(:,1) p(:,2)+g(:,2)];
load('matlab_ex10_comfiltro.mat');
plot(rf(:,1),rf(:,2),p(:,1),p(:,2),'r',original(:,1),original(:,2))
xlabel('Time(s)');
ylabel('y');

%% Ex.11a
% Projeção de outros ganhos - 1ª Sugestão
alphaK=poly([-70 -20 -10 -10]);
alphaL=poly([-75 -75 -45 -45]);
a=poly(A);
M=[1 0 0 0; a(2) 1 0 0; a(3) a(2) 1 0; a(4) a(3) a(2) 1];

K=(alphaK(2:5)-a(2:5))*inv(M)'*inv(CM)
L=inv(OM)*inv(M)*(alphaL(2:5)-a(2:5))'

load('matlab_ex11a.mat')
plot(rf(:,1),rf(:,2),p(:,1),p(:,2)+g(:,2),'r')
xlabel('Time(s)');
ylabel('y');

%% Ex.11b
% Projeção de outros ganhos - 2ª Sugestão

alphaK=poly([-70 -20 -1+5*1i -1-5*1i]);
alphaL=poly([-50 -50 -30 -30]);
a=poly(A);
M=[1 0 0 0; a(2) 1 0 0; a(3) a(2) 1 0; a(4) a(3) a(2) 1];

K=(alphaK(2:5)-a(2:5))*inv(M)'*inv(CM)
L=inv(OM)*inv(M)*(alphaL(2:5)-a(2:5))'

load('matlab_ex11b.mat')
plot(rf(:,1),rf(:,2),p(:,1),p(:,2)+g(:,2),'r')
xlabel('Time(s)');
ylabel('y');
