

% dato il polinomio ... , dire che esso interpola i punti ... significa
% aver imposto le condizioni di passaggio ...
% il che conduce al sistema ....
% In Matlab/Octave lo si può risolvere chiamndo "polyfit()", che restituisce i coefficienti del polinomio interpolante :

% funzione di Runge
f='1./(1+x.^2)';

% interpolazione su nodi equispaziti:
for i=2:2:30
  figure(1); x=-5:0.05:5; plot(x,eval(f),'r--'); hold, 
             x=-5:10/i:5; c=polyfit(x,eval(f),length(x)-1); 
             x=-5:0.05:5; plot(x,polyval(c,x),'b-'); hold,
             title('interpolazione su nodi equi-spaziati'), pause;
end;


% interpolazione agli zeri di Chebychev:
a=-5; b=5;
for n=1:15
  figure(1); x=-5:0.05:5; plot(x,eval(f),'r--'); hold, 
             x=(a+b)/2 - (b-a)/2*cos(pi*(0:n)/n); c=polyfit(x,eval(f),length(x)-1); 
             x=-5:0.05:5; plot(x,polyval(c,x),'b-'); hold,
             title('interpolazione agli zeri di Chebychev'), pause;
end;



% interpolazione lineare composita:
for i=2:2:30
  figure(1); x=-5:0.05:5; plot(x,eval(f),'r--'); hold, x=-5:10/i:5; plot(x,eval(f),'b-'); hold,
             % IDEM:  x=-5:10/i:5; plot(x,interp1(x,eval(f),x,'linear'),'b-'); hold,
             title('interpolazione lineare composita'); pause,
end;



% interpolazione con splines cubiche interpolatorie:
for i=2:2:30
  figure(1); x=-5:0.05:5; plot(x,eval(f),'r--'); hold,
             x=-5:10/i:5; xi=-5:0.05:5; yi=interp1(x,eval(f),xi,'spline');
             plot(xi,yi,'b-'); hold,
             title('interpolazione con spline cubica'); pause,
end;





