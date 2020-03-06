function X=Lorenz_equation(n) 
p=10;r=28;b=8/3;
h = 0.01; % step
X=linspace(0,0,n); 
Y=linspace(0,0,n);
Z=linspace(0,0,n);
X(1) = 1;
Y(1) = 1;
Z(1) = 1; 

for i=1:n-1
    X(i+1) =X(i)+h*(-p*X(i)+p*Y(i));
    Y(i+1) = Y(i)+h*(-Z(i)*X(i)+r*X(i)-Y(i));
    Z(i+1) =  Z(i)+h*(X(i)*Y(i)-b*Z(i)); 

end
plot3(X,Y,Z);
hold on

X(1) = 1.1;
Y(1) = 1;
Z(1) = 1; 

for i=1:n-1
    X(i+1) =X(i)+h*(-p*X(i)+p*Y(i));
    Y(i+1) = Y(i)+h*(-Z(i)*X(i)+r*X(i)-Y(i));
    Z(i+1) =  Z(i)+h*(X(i)*Y(i)-b*Z(i)); 

end

plot3(X,Y,Z)
hold off

%subplot(2,1,2);
%plot(T,X);

