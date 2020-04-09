function X=Rossler_equation(n) 
set_appearance();
a=0.2;b=0.2;c=5.7;
h = 0.01; % step
X=linspace(0,0,n); 
Y=linspace(0,0,n);
Z=linspace(0,0,n);

X(1) = 1;
Y(1) = 1;
Z(1) = 1; 

for i=1:n-1
    X(i+1) =X(i)+h*(-Y(i)-Z(i));
    Y(i+1) = Y(i)+h*(X(i)+a*Y(i));
    Z(i+1) =  Z(i)+h*(b+X(i)*Z(i)-c*Z(i)); 

end
plot3(X,Y,Z);
xlabel('x');
ylabel('y');
zlabel('z');
hold on

X(1) = 1.1;
Y(1) = 1;
Z(1) = 1; 

for i=1:n-1
 X(i+1) =X(i)+h*(-Y(i)-Z(i));
    Y(i+1) = Y(i)+h*(X(i)+a*Y(i));
    Z(i+1) =  Z(i)+h*(b+X(i)*Z(i)-c*Z(i)); 

end

plot3(X,Y,Z)
hold off
