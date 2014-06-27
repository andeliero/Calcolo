clear all;
close all;

n=5000;
vn=10:100:n;
t1=zeros(length(vn),1);
t2=zeros(length(vn),1);

b=rand(max(vn),1);


k=1;
for i=vn
  
  %2 vettori con valori cos([0,pi]) di lunghessa i
  vx=cos(linspace(0,pi,i));
  vy=cos(linspace(0,pi,i));
  
  b=rand(i,1);
  
  %precalcolo la matrice A una matrice densa 
  %(se fosse sparsa octave implementerebbe algoritmi più efficenti)
  A=(vx' * vy);
  
  
  tic;
  R1= A * b(1:i,1); %ha un costo dell'ordine di  O(n^2)
  t1(k)=toc;

  tic
  R2= vx' * (vy * b(1:i,1));%complessità dell'ordine di  O(n)
  t2(k)=toc;
  
  RR=norm(R1)-norm(R2);
  k=k+1;
end

figure (1);
plot(vn,t1,'--b',vn,t2,'--r');

