clear all;

vn= [200 800 3200 4000 4800];


t_riga=zeros(length(vn),1);
t_col=zeros(length(vn),1);
tempi=zeros(length(vn),1);

i=1;
for n=vn
	A=rand(n,n);
	B=rand(n,n);
	tic
	c= A(1,:) .* B(1,:);
	t_riga(i)=toc;
	tic
	c=A(:,1) .* B(:,1);
	t_col(i)=toc;
	tempi(i)= (t_col(i)./t_riga(i));
	i=i+1;
end


plot(vn,t_riga./t_col);

%da notare che gli acessi in memoria lenta frequenti 
%per n che tende ad infinito perchè octave salva i dati per colonna
%e quindi gli accessi per la riga sono più costosi
