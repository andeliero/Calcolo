clear all;
% dato il polinomio ... , dire che esso interpola i punti ... significa
% aver imposto le condizioni di passaggio ...
% il che conduce al sistema ....
% In Matlab/Octave lo si può risolvere chiamndo "polyfit()", che restituisce i coefficienti del polinomio interpolante :

% funzione di Runge
f='1./(1+x.^2)';


% interpolazione agli zeri di Chebychev:
E=zeros(15,1); %E(i) = massimo errore assoluto commesso dall'interpolazione ne ciclo n
a=-5; b=5;
for n=1:15
  x=-5:0.05:5;
  x=(a+b)/2 - (b-a)/2*cos(pi*(0:n)/n); 
  c=polyfit(x,eval(f),length(x)-1);
  x=-5:0.05:5; 
  %plot(x,polyval(c,x),'b-');
  E(n)=max(abs( eval(f)-polyval(c,x)));
  
end;

semilogy([1:15]',E,'bd');

%semplicemente si può notare che l'interpolazione con i nodi
%di cheb. converge uniformemente
