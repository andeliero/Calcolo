
echo on;

% vediamo un semplice esempio, talmente banale da non avere utilita' 
% pratica diretta, ma in cui appare in modo semplice e chiaro la 
% propagazione dell'errore di arrotondamento. Il problema e' il seguente:
% vogliamo calcolare, dato un valore iniziale di "acc" pari ad "acc0", 
% una sequenza di: somma 1 ad "acc" e sottrai 1 ad "acc", ripetuta N volte. 
% Dunque, il valore finale di "acc" deve essere identico ad "acc0".
%
% Dato che "1" possiede una rappresentazione esatta nell'aritmetica 
% floating-point che utilizziamo, partendo da un valore "acc0"
% anch'esso rappresentabile esattamente, otteniamo un valore finale 
% di "acc" esattamente uguale ad "acc0", e cioe' un errore
% di arrotondamento sempre nullo (e dunque anche a propagazione nulla):
%
% questo risultato ha luogo perche' essendo "eps" per definizione 
% la distanza tra "1" ed il numero floating-point immediatamente 
% superiore, anche "1+eps" e' rappresentabile esattamente e dunque 
% questo algoritmo funziona correttamente  (mentre, ad esempio,
% "2+eps" non sarebbe rappresentabile esattamente)

echo off;

N=10000;
errore=zeros(N,1);

acc0=eps;
if acc0==0 error('non assegnare "acc0" al valore zero !'); end;
acc=acc0;
for i=1:N
  acc=acc+1;
  acc=acc-1;
  errore(i)=(acc-acc0)/acc0;
end;
plot(1:N,errore,'b-'); 
ylabel('errore relativo')
title('rappresentazione esatta');  

pause

echo on;
% Ora, se vogliamo velocizzarne l'esecuzione, come spesso accade 
% nella pratica, possiamo ad esempio passare all'implementazione seguente:

echo off;
acc=acc0;
for i=1:N
  acc=acc+1-1;
  errore(i)=(acc-acc0)/acc0;
end;
plot(1:N,errore,'b-'); 
ylabel('errore relativo')
title('come prima, implementazione più veloce'); 

echo on;
% ed il risultato e' invariato.
pause


% Ora, supponiamo che ci risulti conveniente sostituire l'"1" 
% nella sottrazione con un'espressione ben nota dalla trigonometria:
% 1 == cos(x)^2 +sen(x)^2
% Questo e' perfettamente equivalente dal punto di vista matematico, 
% e dunque a precisione infinita (cioe', se fossero disponibili
% infinite cifre per rappresentare i numeri nel calcolatore) 
% il risultato risulterebbe inalterato.
% In verita', la rappresentazione di cos(x) e sen(x) non e' in generale 
% esatta in precisione finita, e dunque questa sostituzione comporta 
% un errore di arrotondamento, compiuto ad ogni passo (e dunque ne 
% vengono compiuti ed accumulati N).
% Inoltre, tale errore di arrotondamento varia al variare di "x", 
% come si puo' vedere facilmente:

echo off;
I=2*pi*(1:10000)/10000; 
plot(I,1-(cos(I).^2+sin(I).^2),'r-');  
title('andamento dell''errore di arrotondamento in funzione di ''x'''); 
ylabel('errore assoluto')
pause


echo on;
% Nella pratica succede proprio questo: l'errore di arrotondamento 
% e' piccolo, ma in generale variabile e di cui non si conosce
% in genere la distribuzione. In questo caso particolare noi 
% lo possiamo controllare assegnando un valore opportuno ad "x".
% Vediamo cosa puo' succedere in due situazioni estreme:
% nella prima, manteniamo il valore di "x" costante per tutto il ciclo; 
% in questo modo l'errore puo' essere considerato
% "sistematico" (e quindi, talvolta, eliminato o compensato)

echo off;
acc=acc0;
x=0.0999999;
q=cos(x)^2+sin(x)^2;
for i=1:N
  acc=acc+(1-q);
  errore(i)=(acc-acc0)/acc0;
end;
plot(1:N,errore,'b-');
title('l''errore relativo esplode: algoritmo instabile!')
ylabel('errore relativo')

echo on;
% si nota che l'errore relativo cresce velocemente 
% (perche' l'errore di arrotondamento viene accumulato ed in piu' 
% il risultato e l'errore di arrotondamento sono dello stesso ordine 
% di grandezza): il comportamento dell'algoritmo e' instabile!

pause


% Ora, vediamo il comportamento dell'implementazione piu' lenta 
% vista in precedenza 
% NB: ora, a differenza di quanto succedeva prima, il comportamento 
% delle due non e' piu' lo stesso!

echo off;
acc=acc0;
x=0.099999;
q=cos(x)^2+sin(x)^2;
for i=1:N
  acc=acc+1;
  acc=acc-q;
  errore(i)=(acc-acc0)/acc0;
end;
plot(1:N,errore,'b-');
axis([0,10000,0.4,1.6])
title('comportamento paradossale: il risultato non ha niente a che vedere con quello esatto ma sembra invece accurato')
ylabel('errore relativo')

echo on;
% qui "q" dista da "1" di "eps/2" ed e' il numero rappresentabile 
% esattamente piu' vicino ad uno dal basso. Quando "acc" vale 
% "1+eps", sottraendogli "q" rimane "1.5*eps", da cui l'errore 
% relativo pari a "1.5". Pero', quando sommiamo nuovamente "1", 
% cioe' all'iterazione successiva, il "eps/2" viene perso ed 
% abbiamo nuovamente "acc==1+eps", per cui l'errore rimane costante
% e non vi e' accumulo nella sua propagazione

pause

% Vediamo cosa succede nell'implementazione veloce (instabile) 
% se modifichiamo il valore assegnato ad "acc0": 

echo off;
acc0=1;
acc=acc0;
x=0.1;
q=cos(x)^2+sin(x)^2;
for i=1:N
  acc=acc+(1-q);
  errore(i)=(acc-acc0)/acc0;
end;
plot(1:N,errore,'b-');
title('altro paradosso: modificando il valore iniziale, l''errore si annulla')
ylabel('errore relativo')

echo on;
% qui "1-q == eps/2" ed "acc0 == 1", dunque "acc == 1+eps/2" non puo' 
% essere rappresentato esattamente e viene arrotondato a "1"
% (mentre "acc == 0.5+eps/2" verrebbe rappresentato esattamente). 
% In sostanza l'errore "1-q" viene perso per mancanza di cifre
% nella rappresentazione del risultato 

pause


% vediamo ora cosa succede se l'errore di arrotondamento non e' piu'
% costante, bensi' varia in modo casuale (come e' lecito
% attendersi in molte circostanze):

echo off;
acc0=eps;
acc=acc0;
%rand('state',sum(100*clock)); % setta il generatore di numeri casuali ad un valore diverso ad ogni esecuzione 
x=rand(N,1)*2*pi;
for i=1:N
  q=cos(x(i))^2+sin(x(i))^2;
  acc=acc+(1-q);
  errore(i)=(acc-acc0)/acc0;
end;
plot(1:N,errore,'b-');
title('instabilita'' con errore ad andamento casuale')
ylabel('errore relativo')

echo on;
pause

% Domanda: perche' l'errore relativo ha comunque un andamento crescente ?
%
% Abbiamo potuto osservare che il comportamento di un algoritmo 
% in presenza di errore di arrotondamento (che e' la situazione
% ordinaria), puo' variare sostanzialmente pur variando solamente 
% alcuni particolari, e questo gia' in un algoritmo piuttosto semplice, 
% per cui la pura osservazione empirica del suo comportamento e' 
% una strada di dubbia utilita' pratica per valutarne l'affidabilita'.
% Questo ci fa capire come lo studio dell'errore di arrotondamento 
% sia in generale un fenomeno piuttosto complesso, e che
% garantire che un algoritmo numerico sia stabile rispetto all'errore 
% di arrotondamento richiede l'utilizzo di strumenti
% di analisi piuttosto sofisticati. Nei primi anni '60 Wilkinson 
% propose lo strumento oggi di riferimento: l'"analisi all'indietro"
% dell'errore.
