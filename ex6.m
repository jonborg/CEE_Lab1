ex4
[num,dem]=ss2tf(A,b,c,0);
sist=tf(num,dem);
[num,dem]=ss2tf(A,L,ones(1,4),0)
comp1=tf(num,dem);
cs=tf(1,c);
comp2=feedback(comp1,cs,-1);
Ks=tf(1,K);
comp3=series(comp2,Ks);
[num,dem]=ss2tf(b*K,b,K,0);
comp4=tf(num,dem);
comp5=series(sist^-1,comp4);
transf=feedback(feedback(sist,comp3,-1),comp5,-1)
bode(transf)