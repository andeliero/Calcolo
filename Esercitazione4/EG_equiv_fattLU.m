clear all;
% consideriamo la stessa matrici dell'esempio precedente:

A1 = [4 2 0.1 1.1; 1.2 5 3 0.3; 1.1 0.8 4 2.1; 0.3 1.2 3 5];
A2 = [4 2 0.1 1.1; 1.2 5 3 0.3; 1.1 0.8 4 2.1; 0.3 1.2 3 5];
b = [1; 1; 1; 1];
A1, b, disp('A e b iniziali (premi un tasto per continuare)'), pause

n = size(A1,1); 
prodM=eye(n);
for k=1:n-1  
  for j=k+1:n
    m(j,1) = A1(j,k)/A1(k,k);  % elemento pivotale
    for i=k:n 
      A1(j,i) = A1(j,i) - m(j,1)*A1(k,i); 
    end
  end
  M=eye(n); M(k+1:n,k) = - m(k+1:n,1);
  A2 = M * A2;
  A1, A2, disp('(premi un tasto per continuare)'), pause
  prodM = M * prodM;
end 

U = A1;  
U
disp('U è il fattore triangolare superiore'), pause

% se prendiamo il prodotto di tutte le matrici "M" così calcolate e lo
% invertiamo, otteniamo il fattore triangolare "L" . Infatti, chiamando
% M_i la matrice "M" creata alla i-esima iterazione, l'algoritmo
% pre-moltiplica la matrice "A" per "M_i" fino ad ottenere una matrice triangolare
% superiore "U", cioè:   M_(n-1)*...*M_1*A = prodM*A = U e quindi , pre-moltiplicando
% entrambi i menbri di questa espressione per l'inversa di prodM,
% inv(prodM), si ha  inv(prodM)*prodM*A = I*A = A = inv(prodM)*U , da cui
% "L = inv(prodM)".
L = inv(prodM);
L
disp('L è il fattore triangolare infriore (notare che ha tutti "1" sulla diagonale)'), pause

A3=L*U;
A3
disp('verifica: L*U=A '), pause

% soluzione del sistema L*y=b
y(1,1) = b(1)/L(1,1); 
for i=2:n 
  y(i,1) = ( b(i) - L(i,1:i-1)*y(1:i-1,1) ) / L(i,i); 
end; 

% soluzione del sistema U*x=y
x(n,1) = y(n)/U(n,n);
for j=n-1:-1:1
  x(j,1) = ( y(j) - U(j,j+1:n)*x(j+1:n,1) ) / U(j,j);
end;
x
A3*x-b  % verifica
