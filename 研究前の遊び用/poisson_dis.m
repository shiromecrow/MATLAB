function poisson_dis(n,lammda) 
x=linspace(1,n,n);
y=linspace(0,0,n);
E1=linspace(0,0,n);
E2=linspace(0,0,n);
for i=1:n
   y(i) =exp(lammda)*(lammda^(x(i)))/factorial(x(i));
   E1(i)=x(i)*y(i);
   E2(i)=(x(i)^2)*y(i);
end
y_sigma=sum(y)
E1_real=sum(E1)
E1_ideal=lammda
E2_real=sum(E2)-E1_real^2
E2_ideal=lammda

plot(x,y)

