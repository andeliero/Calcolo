A = [4 2 0.1 1.1; 1.2 5 3 0.3; 1.1 0.8 4 2.1; 0.3 1.2 3 5];
b = [1; 1; 1; 1];
A, b, disp('A e B iniziali (premi un tasto per continuare)'), pause

n = size(A,1); 
for k=1:n-1  
  for j=k+1:n
    m = A(j,k)/A(k,k);  % elemento pivotale
    for i=k:n 
      A(j,i) = A(j,i) - m*A(k,i); 
    end
    b(j) = b(j) - m*b(k);
  end
  A, b, disp('(premi un tasto per continuare)'), pause
end 

% metodo delle sostituzioni all'indietro
x(n,1) = b(n)/A(n,n);
for j=n-1:-1:1
  x(j,1) = ( b(j) - A(j,j+1:n)*x(j+1:n,1) ) / A(j,j);
end;
x
A*x-b  % verifica
