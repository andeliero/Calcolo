clear all;
vn=100:100:2000;
tempi=zeros(length(vn),1);
i=1;
Atot=rand(vn(end),vn(end));
Btot=rand(vn(end),vn(end));
for n=vn
	A=Atot(1:n,1:n);
	B=Btot(1:n,1:n);
	tic;
	C=A*B;
	tempi(i)=toc;
	disp([ 'n=' num2str(n) ' elapsed time = ' num2str(tempi(i))])
	i=i+1;
end
figure(1);
plot(vn,tempi,'b-');

%notare che i tempi di calcolo di una matrice aumentano in modo esponenziale
%per n che tende ad infinito , precisamente O(n^3)
