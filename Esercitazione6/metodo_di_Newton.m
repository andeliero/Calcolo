clear all;
close all;


f='2*x.^2-1';  % è la funzione di cui cercare lo zero
df='4*x';
a=-0.5;
b=3;
niter=0; nitermax=100;
toll=0.0001;
x=2.5;
X(1)=x;
diff=toll+1;
while abs(diff)>toll & niter<=nitermax  
  niter=niter+1;
  diff= -eval(f)/eval(df);
  x=x+diff;
  X(niter+1)=x;
end;
if niter<=nitermax  
  zero=x;
  disp(['zero di f è x=' num2str(x)]);
  for i=1:niter-1
    p = 2;
    disp(['p=' num2str(p) '; C=' num2str(abs(X(i+1)-zero)/abs(X(i)-zero)^p) ]);
  end;
end;

%individuare per quale classe di funzioni f(x) il metodo di Newton converge in una sola iterazione
%il metodo di newton converge in una sola iterazione nel caso di polinomi di 1o grado