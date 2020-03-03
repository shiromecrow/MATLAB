function Rossler_equation(n) 
a=0.2;b=0.2;c=5.7;
h = 0.01; % step
X=zeros(n); % èâä˙
Y=zeros(n);
Z=zeros(n);

X(1) = 1;
Y(1) = 1;
Z(1) = 1; 

for i=1:n-1
    X(i+1) =X(i)+h*(-Y(i)-Z(i));
    Y(i+1) = Y(i)+h*(X(i)+a*Y(i));
    Z(i+1) =  Z(i)+h*(b+X(i)*Z(i)-c*Z(i)); 

end
plot3(X,Y,Z);
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
