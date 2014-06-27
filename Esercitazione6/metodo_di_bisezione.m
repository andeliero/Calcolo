clear all;
close all;

f='2*x.^2-1';  % è la funzione di cui cercare lo zero
a=-0.5;
b=3;

toll=0.01;
xa=a; xb=b;
for i=1:ceil(log2((b-a)/toll)-1)
  x=[xa (xa+xb)/2 xb]; val_f=eval(f);
  if val_f(1)*val_f(2)<0
    xb=x(2); 
  elseif val_f(2)*val_f(3)<0
    xa=x(2);
  else
    break;
  end;
  I=xb-xa;  disp(['lunghezza dell''intervallo al passo ' num2str(i) ' = ' num2str(I)]);
end;
disp(['zero di f  x=' num2str(x(2))]);

%provare il metodo nei due casi seguenti :    f(x) = 5-3*x   f(x) = log(x)-0.001

%f(x) = 5-3*x
%scelto a=1 e b=2 il metodo converge con 6 passi di iterazione 

%f(x) = log(x)-0.001
%scelto a=1 e b=2 il metodo converge con 6 passi di iterazione
