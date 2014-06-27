clear all;
close all;


f='2*x.^2-1';  % è la funzione di cui cercare lo zero
a=-0.5;
b=3;
figure(1); fplot(f,[a b]); axis([a b -2 18]); hold on; plot([a b],[0 0],'k-'); plot([0 0],[-2 18],'k-'); plot([a b],[0 0],'r*'); 
pause
toll=0.01;
xa=a; xb=b;
for i=1:ceil(log2((b-a)/toll)-1)
  x=[xa (xa+xb)/2 xb]; val_f=eval(f);
  figure(1); plot([xa xb],[0 0],'g*');
  if val_f(1)*val_f(2)<0
    xb=x(2); 
  elseif val_f(2)*val_f(3)<0
    xa=x(2);
  else
    break;
  end;
  figure(1); plot([xa xb],[0 0],'r*');
  pause
end;
disp(['zero di f è x=' num2str(x(2))]);
figure(1); hold off;

