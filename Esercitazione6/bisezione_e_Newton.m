
% provare a combinare i due metodi, bisezione e Newton, in modo da ottenere 
% un metodo avente convergenza certa ed una velocitÃ  superiore alla semplice bisezione.
% parto da [a,b] con x(0)=a
% calcolo x(i+1) con newton
% se il punto appartiene ad [a,b] continuo con newton e aggiorno bisezione
% altrimenti faccio un passo di bisezione
clc;
                                
funzioni = {'2*x.^2-1' 'atan(2*x-0.5)' '5-3*x' 'log(x)-0.001' '3*x' 'atan(2*x-0.5)'};
dfunzioni = {'4*x' '2/(1+(2*x-0.5)^2)' '-3' '1/x' '3' '2/(1+(2*x-0.5)^2)'};
tempi_alg = zeros(length(funzioni),1);
tempi_fsolve = zeros(length(funzioni),1);
intervalli = [[-0.5 3]; [-1.5 3]; [0 3]; [0.5 2];[-1 1]; [-9 1000]];

for i = 1:length(funzioni)
    
    f=char(funzioni(i))  % la funzione di cui cercare lo zero
    df=char(dfunzioni(i))
    a = intervalli(i,1);
    b = intervalli(i,2);
    xa=a;
    xb=b;
    toll = 0.000001;
    % parto da [a,b] con x(1)=a
    num_iter=1;
    X(1)=a; 
    last_used =0; % ultimo medoto usato, 0 -> newton, 1 -> bisezione
    diff=toll+1;
    tic;% inizio a misurare il tempo del mio algoritmo
    while (last_used==0 && abs(diff)>toll) || (last_used == 1 && num_iter <= ceil(log2((b-a)/toll)-1))
        
        x=X(num_iter); % necessario per eval
        diff = -eval(f)/eval(df);
        X(num_iter+1)= x+diff;

        % se il punto appartiene ad [a,b] continuo con newton e aggiorno bisezione
        if X(num_iter + 1) >= xa && X(num_iter+1)<= xb
            last_used = 0;
            x=[xa X(num_iter + 1) xb]; %@1 
            val_f=eval(f);
            if val_f(1)*val_f(2)<0
                xb=x(2); 
            elseif val_f(2)*val_f(3)<0
                xa=x(2);
            else
                break;
            end;
        else
            last_used=1;
            x = [xa (xa+xb)/2 xb]; %@2 
            val_f=eval(f);
            if val_f(1)*val_f(2)<0
                xb=x(2); 
            elseif val_f(2)*val_f(3)<0
                xa=x(2);
            end;
        end;
        num_iter = num_iter+1;
    end;
    % se l'ultimo passaggio e' stato fatto con newton il risultato e' in x(2)
    % [vedi @1]
    % se l'ultimo passaggio e' stato fatto con la bisezione il risultato e'
    % comunque in x(2) [vedi @2]
    tempi_alg(i)=toc;
    
    disp(' ')
    disp('---------------------------------------------------------------')
    disp(['Zero di f in x = ' num2str(x(2)) ' Iterazioni usate: ' num2str(num_iter-1) ' Tolleranza: ' num2str(toll)]);
    disp('---------------------------------------------------------------')
   
end;
tempi_alg

%Commento sui risultati a parità di tolleranza (10^-6)
% Funzione 1: i risultati sono diversi perchè fsolve non è limitato
% nell'intervallo [-0.5 3], se si prende l'intervallo [-3 0.5] il risultato
% è identico.
% Funzione 2: fsolve è molto più veloce dato che l'algorito
% Newton+Bisezione applica sempre la bisezione che è più lenta
% Funzione 3 e 5: Netwon+Bisezione converge in una solo iterazione perchè
% la derivata è costante, di conseguenza è più veloce di fsolve
% Funzione 4: Newton+Bisezione applica sempre Newton che è più veloce di
% fsolve.
