clear all;
close all;

x = 100:100:2300;
n = length(x);
y = [0.002232 0.000537 0.001747 0.003923 0.007564 0.012614 0.017853 0.040259 0.021593 0.026588 0.035832 0.049552 0.063829 0.072091 0.092468 0.10167 0.13206 0.14484 0.17106 0.18974 0.21779 0.24561 0.3015];
y=y';

% approssimazione ai minimi quadrati:
for q=[2 3 4]
  figure(1); 
  plot(x,y,'ro'); 
  hold on;
  A=vander(x); A=A(:,end-q+1:end);
  [Q R]=qr(A);
  c=R \(Q' * y);
  errsq=sum((y'-polyval(c,x)).^2);
  disp(['gradopol=' num2str(q) '   sqm=' num2str(errsq)]);
  plot(x,polyval(c,x),'b-'); 
  hold off;
  title(['grado del polinomio =' num2str(q)]);
  pause;
end;