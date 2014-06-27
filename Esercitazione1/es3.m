clear all;
E=1:1:10

vn=(2).^E

tempi=zeros(length(vn),1);
tempi1=zeros(length(vn),1);
tempi2=zeros(length(vn),1);
tempi3=zeros(length(vn),1);

l=1;
for n=vn
	disp([num2str(n)]);
	A=rand(n,n);
	B=rand(n,n);


	%operazione std dell'interprete
	tic;
	C=A*B;
	tempi(l)=toc;

	%algoritmo blas1
%	tic;
%	for i=1:n
%		for j=1:n
%			C(i,j)=A(i,:)*B(:,j);
%		end
%	end
%	tempi1(l)=toc;
%
%	%algoritmo blas2
%	tic;
%	for i=1:n
%		for j=1:n
%			C(i,j)=A(i,:)*B(:,j);
%		end
%	end
%	tempi2=toc;

N2 = n/2^14;%input('immetti il numero di blocchi di colonne in cui suddividere le matrici (N2) : ');
N3 = n/2^14;%input('immetti il numero di blocchi quadrati in cui suddividere le matrici (N3) : ');
%n = input('immetti il numero totale di righe (colonne) delle matrici (n) : ');
ncb2=n/N2;  % numero di colonne per blocco
ncb3=n/N3;  % numero di righe/colonne per blocco quadrato
%if floor(n/N2)~=n/N2 | floor(n/N3)~=n/N3
%  error('''n'' deve essere un multiplo di ''N2'' e di ''N3'' !')
%end
A=repmat(1.1,n,n); B=repmat(1.1,n,n);


% moltiplicazione con chiamate a funzioni di tipo BLAS3 (compilato)
C=repmat(0.0,n,n);
tic
% ATTENZIONE: "A" e "B" sono due matrici e quindi chiedendo l'operazione "*" Matlab
% applica il prodotto di matriciForm a block matrix of size m by n, with a copy of matrix A as each element. nel senso classico dell'algebra lineare, mentre Python (Numeric) applicherebbe il
% prodotto di matrici "per componenti".
C=C+A*B;
t=toc;
disp(['tempo impiegato per il calcolo di tipo BLAS3 (compilato, N3 scelto da Octave): ' num2str(t) '  sec']);
C_3_comp = C;

% moltiplicazione con chiamate a funzioni di tipo BLAS3 (interpretato)
% NB: ha prestazioni ragionevoli solo per "n" grande.
C=repmat(0.0,n,n);
tic
for i=1:N3
  im=(i-1)*ncb3+1:i*ncb3;
  for j=1:N3
    jm=(j-1)*ncb3+1:j*ncb3;
    for k=1:N3
      km=(k-1)*ncb3+1:k*ncb3;
      % ATTENZIONE: "A(im,km)" e "B(km,jm)" sono due blocchi delle matrici "A" e "B" (e quindi sono a loro volta due matrici): 
      % chiedendo l'operazione "*" Matlab applica il prodotto di matrici nel senso classico dell'algebra lineare, mentre 
      % Python (Numeric) applicherebbe il prodotto di matrici "per componenti".
      C(im,jm)=C(im,jm)+A(im,km)*B(km,jm);
    end
  end    
end
tempi3(l)=t=toc;
disp(['tempo impiegato per il calcolo di tipo BLAS3 (interpretato): ' num2str(t) '  sec']);
C_3_interp = C;


% moltiplicazione con chiamate a funzioni di tipo BLAS2
C=repmat(0.0,n,n);
tic
for j=1:N2
  ic=(j-1)*ncb2+1:j*ncb2;
  for k=1:n
    C(:,ic)=C(:,ic)+A(:,k)*B(k,ic);
  end    
end
tempi2(l)=t=toc;
disp(['tempo impiegato per il calcolo di tipo BLAS2 (interpretato): ' num2str(t) '  sec']);
C_2_interp = C;


% moltiplicazione con chiamate a funzioni di tipo BLAS1
C=repmat(0.0,n,n);
tic
for i=1:n
  for j=1:n
    C(i,j)=C(i,j)+A(i,:)*B(:,j);
  end    
end
tempi1(l)=t=toc;
disp(['tempo impiegato per il calcolo di tipo BLAS1 (interpretato): ' num2str(t) '  sec']);
C_1_interp = C;

	l=l+1;
end


figure(1);
plot ( vn , tempi , 'g-' , vn , tempi1 , 'b-' , vn , tempi2 , 'r-' , vn , tempi3 , 'y-' );
