clear all;

%  Fattorizzazione LU "sul posto" della matrice A (A=L*U) con la sequenza "kji"
%  e pivoting su righe
%
Aini = [1 2 0.1 1.1; 1.2 5 3 0.3; 1.1 0.8 0.5 2.1; 0.3 1.2 3 5];
Aini, disp('A iniziale (premi un tasto per continuare)'), pause


A = Aini;
n=size(A,1);
pc = 1:n;
pr = 1:n;  % "p" è il vettore degli indici permutati
for k=1:n-1
 	[Y I]=max(abs(A(k:n,k:n)));
	[Q R]=max(Y);
  	icp = k + R(1)-1;
	if icp>k
		temp_subcolonna=A(:,k);
		A(:,k)=A(:,icp);
		A(:,icp)=temp_subcolonna;
		temp_ic=pc(k);
		pc(k)=pc(icp);
		pc(icp)=temp_ic;
	end	

	irp = k + I(R(1))-1;
	if irp>k
		temp_subriga=A(k,:);
		A(k,:)=A(irp,:);
		A(irp,:)=temp_subriga;
		temp_ir=pr(k);
		pr(k)=pr(irp);
		pr(irp)=temp_ir;
	end
	A(k+1:n,k)=A(k+1:n,k)/A(k,k); % calcolo una sub-colonna in un'unica operazione
	for j=k+1:n, 
		for i=k+1:n 
			A(i,j)=A(i,j)-A(i,k)*A(k,j) ;
    		end, 
	end 
end


P = zeros(n);  % "P" è la matrice di permutazione righe, che andiamo a costruire tramite il vettore delle permutazioni "p"
for i=1:n  P(i,pr(i))=1; end;
P
disp(' ');

Q = zeros(n);  % "Q" è la matrice di permutazione colonne, che andiamo a costruire tramite il vettore delle permutazioni "p"
for i=1:n  Q(pc(i),i)=1; end;
Q
disp(' ');

disp('verifica:  P*A*Q = L*U');
disp(' ');
disp('P*A*Q = ');P*Aini*Q

disp('L*U = ');
L = eye(n)+tril(A,-1);
U = triu(A,0);
L*U
