clear all;
%  Fattorizzazione LU "sul posto" della matrice A (A=L*U) con la sequenza "kji"
%  e pivoting su righe
%
Aini = [1 2 0.1 1.1; 1.2 5 3 0.3; 1.1 0.8 0.5 2.1; 0.3 1.2 3 5];
Aini, disp('A iniziale (premi un tasto per continuare)'), pause
A = Aini;
n=size(A,1);
p = 1:n;  % "p" è il vettore degli indici permutati
for k=1:n-1
  [Y I]=max(abs(A(k:n,k))); % cerco il massimo pivot sulla k-esima colonna  
  ip = k + I(1)-1;  % "ip" è l'indice-riga del massimo pivot
  if ip>k  % il massimo pivot non sta sulla diagonale, quindi faccio la permutazione
    temp_subriga=A(k,:);  A(k,:)=A(ip,:);  A(ip,:)=temp_subriga;
    temp_i=p(k);          p(k)=p(ip);      p(ip)=temp_i;
  end
  A(k+1:n,k)=A(k+1:n,k)/A(k,k); % calcolo una sub-colonna in un'unica operazione
  for j=k+1:n, 
    for i=k+1:n 
      A(i,j)=A(i,j)-A(i,k)*A(k,j) ;
    end, 
  end 
end

P = zeros(n);  % "P" è la matrice di permutazione, che andiamo a costruire tramite il vettore delle permutazioni "p"
for i=1:n  P(i,p(i))=1; end;
disp('P = ');
P
disp(' ');
disp(' ');
disp('verifica:  P*A = L*U');
disp(' ');
disp('P*A = ');
P*Aini
disp('L*U = ');
L = eye(n)+tril(A,-1);
U = triu(A,0);
L*U

