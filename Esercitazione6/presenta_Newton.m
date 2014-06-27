clear all;
close all;


f='2*x.^2-1';  % è la funzione di cui cercare lo zero
df='4*x';
a=-0.5;
b=3;
figure(1); fplot(f,[a b]); axis([a b -2 18]); hold on; plot([a b],[0 0],'k-'); plot([0 0],[-2 18],'k-');
title('metodo di Newton in un caso convergente')
niter=0; nitermax=10;
toll=0.01;
x=2.5; figure(1); plot(x,0,'r*'); 
pause
diff=toll+1;
while abs(diff)>toll & niter<=nitermax  
  figure(1); plot([x x],[0 eval(f)],'g--'); plot(x,eval(f),'g*');
  niter=niter+1;
  diff= -eval(f)/eval(df);
  figure(1); plot(x+diff,0,'r*'); plot([x x+diff],[eval(f) 0],'m-');
  x=x+diff;
  pause
end;
if niter<=nitermax  disp(['zero di f è x=' num2str(x)]); end;
figure(1); hold off;


pause


f='atan(2*x-0.5)';
df='2/(1+(2*x-0.5)^2)';
a=-1.5;
b=3.5;
figure(1); fplot(f,[a b]); axis([a b -1.5 1.5]); hold on; plot([a b],[0 0],'k-'); plot([0 0],[-2 18],'k-');
title('metodo di Newton in un caso convergente')
% NB: questo esempio non converge perchè f(x) non ha derivata seconda continua !!!
niter=0; nitermax=10;
toll=0.01;
x=-0.4; figure(1); plot(x,0,'r*'); 
pause
diff=toll+1;
while abs(diff)>toll & niter<=nitermax  
  figure(1); plot([x x],[0 eval(f)],'g--'); plot(x,eval(f),'g*');
  niter=niter+1;
  diff= -eval(f)/eval(df);
  figure(1); plot(x+diff,0,'r*'); plot([x x+diff],[eval(f) 0],'m-');
  x=x+diff;
  pause
end;
if niter<=nitermax  disp(['zero di f è x=' num2str(x)]); end;
figure(1); hold off;


pause


f='atan(2*x-0.5)';
df='2/(1+(2*x-0.5)^2)';
a=-1.5;
b=3.5;
figure(1); fplot(f,[a b]); axis([a b -1.5 1.5]); hold on; plot([a b],[0 0],'k-'); plot([0 0],[-2 18],'k-');
title('metodo di Newton in un caso NON convergente')
% NB: questo esempio non converge perchè f(x) non ha derivata seconda continua !!!
niter=0; nitermax=10;
toll=0.01;
x=-0.5; figure(1); plot(x,0,'r*'); 
pause
diff=toll+1;
while abs(diff)>toll & niter<=nitermax  
  figure(1); plot([x x],[0 eval(f)],'g--'); plot(x,eval(f),'g*');
  niter=niter+1;
  diff= -eval(f)/eval(df);
  figure(1); plot(x+diff,0,'r*'); plot([x x+diff],[eval(f) 0],'m-');
  x=x+diff;
  pause
end;
if niter<=nitermax  disp(['zero di f è x=' num2str(x)]); end;
figure(1); hold off;

