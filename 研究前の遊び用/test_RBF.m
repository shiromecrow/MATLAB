function test_RBF(n)
set_appearance();
X=linspace(-1,1,n); 
b=3;

A=radbas(X,b);
for i=1:n
Y(i)=exp(-X(i)^2/b);
end
plot(X,A);
hold on 
plot(X,Y);
hold off