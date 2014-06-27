
clear all
% In Matlab/Octave lo si può risolvere con la function "polyfit()".
% La function polyfit fornisce i coefficienti del polinomio interpolatore.
% La sintassi di polyfit è:
% p=polyfit(x,y,n)
% dove x contiene i nodi xi , y contiene i valori della funzione yi e n è il grado
% del polinomio interpolatore.
% y=polyval(p,x)
% restituisce il vettore y contenente i valori di un polinomio di grado n
% calcolati nei punti x. Il vettore p di n + 1 componenti deve contenere i
% coefficienti del polinomio corrispondenti alle potenze in ordine decrescente.





%   Caso test con esempio di malcondizionamento.

 x=[1200.5 1201.5 1202.5 1203 1204 1205];
 y=[3 1.5 1.5 1 1 0];


xp=linspace(x(1),x(end),100);
n=length(x)-1;


% calcolo della matrice di Vandermonde
V = vander(x);
% calcolo dei coefficienti
c = V\y';

plot(x,y,'o',xp,polyval(c,xp),'m:')
hold

                      
xp=xp';
for i=1:length(xp)
 yint(i)=interLagrange(x,y,xp(i));
end
plot(xp,yint,'g')

legend('dati','coefficienti ind.','Lagrange');


pause

% La matrice di Vandermonde consiste di colonne che crescono di colonna in colonna
% 1, xi, xi^2,xi^3,.., xi^5
% Per questo caso test, si va da 1 a elementi dell'ordine di 10^15. 
% La matrice è molto mal condizionata e la soluzione del sistema lineare
% non può dare risultati affidabili, il vettore che fornisce i coefficienti
% del polinomio interpolatore è errato.
% Infatti MATLAB fornisce un messaggio di warning durante la
% risoluzione del sistema con la matrice di Vandermonde e durante la chiamata di polyfit


