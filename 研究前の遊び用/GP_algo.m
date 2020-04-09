function GP_algo(n) 
set_appearance();
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


r=0.5;
count=0;

for i=1:n
    for j=1:n
        if(i~=j)
            D=((X(i)-X(j))^2+(Y(i)-Y(j))^2+(Z(i)-Z(j))^2)^(1/2);
            t=r-D;
            if(t>0)
               count=count+1; 
            end
        end
    end
    
end
A0=count
Cm=count/n/n
A1=log(Cm)
A2=log(r)
vm=log(Cm)/log(r)


