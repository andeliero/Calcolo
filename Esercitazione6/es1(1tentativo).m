  clear all;
  close all;

  f='atan(2*x-0.5)';
  df='2/(1+(2*x-0.5)^2)';
  a=-0.4;
  b=3;

  figure(1); fplot(f,[a b]); axis([a b -1.5 1.5]); hold on; plot([a b],[0 0],'k-'); plot([0 0],[-2 18],'k-');
  title('metodo di Newton e bisezione')

  niter=0;%numero di iterazioni
  nitermax=100;%limite massimo di iterazioni
  toll=0.0001;
  xa=a; xb=b;
  x=xa;%punto iniziale
  figure(1); plot(x,0,'r*');
  pause
  X(1)=x;
  diff=toll+1;
  while abs(diff)>toll && niter<=nitermax
    figure(1); plot([x x],[0 eval(f)],'g--'); plot(x,eval(f),'g*');
    niter=niter+1;
    diff= -eval(f)/eval(df);
    figure(1); plot(x+diff,0,'r*'); plot([x x+diff],[eval(f) 0],'m-');
    px=x+diff;
    if(px<xa || px>xb)
      x=(xa+xb)/2;
    else
      x=px;
    end
    X(niter+1)=x;
    if xa*x<0
      xb=x; 
    elseif x*xb<0
      xa=x;
    else
      break;
    end;
    pause
  end