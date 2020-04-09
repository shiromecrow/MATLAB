function Lyapunov_test(n) 
set_appearance();
p=10;r=28;b=8/3;
h = 0.01; % step
X1=linspace(0,0,n); 
Y1=linspace(0,0,n);
Z1=linspace(0,0,n);
X2=linspace(0,0,n); 
Y2=linspace(0,0,n);
Z2=linspace(0,0,n);
t=[0:h:h*(n-1)];
D=linspace(0,0,n);
X1(1) = 1;
Y1(1) = 1;
Z1(1) = 1; 

for i=1:n-1
    X1(i+1) =X1(i)+h*(-p*X1(i)+p*Y1(i));
    Y1(i+1) = Y1(i)+h*(-Z1(i)*X1(i)+r*X1(i)-Y1(i));
    Z1(i+1) =  Z1(i)+h*(X1(i)*Y1(i)-b*Z1(i)); 

end
subplot(2,1,1);
plot3(X1,Y1,Z1);
hold on

X2(1) = 1.000000000000001;
Y2(1) = 1;
Z2(1) = 1; 

for i=1:n-1
    X2(i+1) =X2(i)+h*(-p*X2(i)+p*Y2(i));
    Y2(i+1) = Y2(i)+h*(-Z2(i)*X2(i)+r*X2(i)-Y2(i));
    Z2(i+1) =  Z2(i)+h*(X2(i)*Y2(i)-b*Z2(i)); 

end

plot3(X2,Y2,Z2);
hold off

for i=1:n
    D(i)=((X1(i)-X2(i))^2+(Y1(i)-Y2(i))^2+(Z1(i)-Z2(i))^2)^(1/2);

end

subplot(2,1,2);
plot(t,D);

