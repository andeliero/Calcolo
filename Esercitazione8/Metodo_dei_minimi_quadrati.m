clear all;
close all;

x = linspace(0,10,8);
n = length(x);
y = ((x+3)*(4/3).*x)-4;
pr=sin(3.*x)*1*rand(n);
y=y+pr;
y=y';

% approssimazione ai minimi quadrati:
for q=[2 3 4]
  figure(1); 
  plot(x,y,'ro'); 
  hold on;
  A=vander(x); A=A(:,end-q+1:end);
  
  c=(A'*A) \(A' * y);
  
  [Q R]=qr(A);
  l=R \(Q' * y);
  
  errsq1=sum((y'-polyval(c,x)).^2);
  errsq2=sum((y'-polyval(l,x)).^2);
  
  disp(['MQ gradopol=' num2str(q) '   sqm=' num2str(errsq1)]);
  disp(['QR gradopol=' num2str(q) '   sqm=' num2str(errsq2)]);
  
  plot(x,polyval(c,x),'b-'); 
  plot(x,polyval(l,x),'g-');
  hold off;
  title(['grado del polinomio =' num2str(q)]);
  pause;
end;


  