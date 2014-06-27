clear all;
%latitudini
x=[-55 -45 -35 -25 -15 -5 5 15 25 35 45 55 65];
%campionamenti per K=0.65
y=[-3.25 -3.37 -3.35 -3.2 -3.12 -3.02 -3.02 -3.07 -3.17 -3.32 -3.3 -3.22 -3.1];



%denoto questo polinomio di grado 5 con p1
x1=x(1, [1 4 7 10 13]); %prendere 5 punti a caso
y1=y(1, [1 4 7 10 13]);
xp1=linspace(x1(1),x1(end),100);
xp1=xp1';
for i=1:length(xp1)
 y1int(i)=interLagrange(x1,y1,xp1(i));
end

%questo polinomio lo denoto con p2
x2=x;
y2=y;
xp2=linspace(x2(1),x2(end),100);
xp2=xp2';
for i=1:length(xp2)
 y2int(i)=interLagrange(x2,y2,xp2(i));
end



plot(xp1,y1int,'g',xp2,y2int,'r',x,y,'*b');

%a colpo d'occhio noto che per i primi intervalli interpola meglio p1 anche se
%non passa per alcuni punti mentre per gli ultimi intervalli interpola meglio p2.
%Suindi deduco che sia un leggero fenomeno di Runghe
%risolvibile soltanto con un campionamento dei nodi come i nodi di Cheb.
%(in questo caso impossibile)

pause