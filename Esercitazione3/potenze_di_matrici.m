clear all;


%vn vettore degli esponenti di a potenze di 2
vn=1:100;
vn=vn.^2;


A=rand(5,5);
tempi1=zeros(length(vn),1);
tempi2=zeros(length(vn),1);


k=1;
for n=vn

	C=A;
	tic;
	for w=2:n
		C=C*A;%costo O(n)
	end
	tempi1(k)=toc;
	
	D=A;
	tic;
	for p=1:log2(n)
		D=D*D;%costo O(log2(n))
	end
	tempi2(k)=toc;
  k=k+1;
end

figure(1);
plot(vn,tempi1,'b-',vn,tempi2,'r-'); 
