function lambda=Lyapunov_Lorenz(n) 
set_appearance();
p=10;r=28;b=8/3;
h = 0.01; % step
X=linspace(0,0,n); 
Y=linspace(0,0,n);
Z=linspace(0,0,n);
J=zeros(3,3,n-1);
Q=zeros(3,3,n*2-2);
R=zeros(3,3,n*2-2);
lambda=[0,0,0];
X(1) = 1;
Y(1) = 1;
Z(1) = 1; 

for i=1:n-1
    X(i+1) =X(i)+h*(-p*X(i)+p*Y(i));
    Y(i+1) = Y(i)+h*(-Z(i)*X(i)+r*X(i)-Y(i));
    Z(i+1) =  Z(i)+h*(X(i)*Y(i)-b*Z(i)); 
    J(1,1,i)=-p*h;
    J(1,2,i)=p*h;
    J(1,3,i)=0;
    J(2,1,i)=(r-Z(i))*h;
    J(2,2,i)=-1*h;
    J(2,3,i)=-X(i)*h;
    J(3,1,i)=Y(i)*h;
    J(3,2,i)=X(i)*h;
    J(3,3,i)=-b*h;
    for j=1:3
        J(j,j,i)=J(j,j,i)+1;
    end
    if i==1
        [Q(:,:,i),R(:,:,i)]=qr(J(:,:,i));
    else
        [Q(:,:,i),R(:,:,i)]=qr(J(:,:,i)*Q(:,:,i-1));
    end
end
for i=n:2*n-2
    [Q(:,:,i),R(:,:,i)]=qr(J(:,:,2*n-2-i+1)*Q(:,:,i-1)); 
end
for j=1:3
for i=1:2*n-2
    lambda(j)=lambda(j)+log(abs(R(j,j,i)));
end

end

lambda=lambda/(2*n-2);



