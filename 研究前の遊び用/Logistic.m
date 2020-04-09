function X=Logistic(n,y_noise) 
set_appearance();
h = 0.01; % step
t=linspace(0,n,n);
X=linspace(0,0,n); 
Y=linspace(0,0,n); 

modein = 'What is mode? 0=amine,1=graph,2=‰Šú’l‰s•q«‚ÌŠm”F,3=•ªŠò},4=ƒmƒCƒY‚ ‚è,6=aw’è';
mode = input(modein);

if mode==0
for j=1:200
    a=0.02*j;
X(1) = 0.3;
for i=1:n-1
    X(i+1) =a*X(i)*(1-X(i));
end
plot(t,X);
xlabel(['a=',num2str(a)]);
ylim([-0.1 1.1]);
F=getframe;
end
movie(F)
end

if mode==1
    hold on
for j=1:5
    a=0.8*j;
X(1) = 0.3;
for i=1:n-1
    X(i+1) =a*X(i)*(1-X(i));
end
plot(t,X);
ylim([-0.1 1.1]);
end
plot(0,0)
xlabel('t');
ylabel('x');
ylim([-0.1 1.1]);
legend(['a=',num2str(0.8*1)],['a=',num2str(0.8*2)],['a=',num2str(0.8*3)],['a=',num2str(0.8*4)],['a=',num2str(0.8*5)]);
hold off
end

if mode==2
for j=1:200
    a=0.02*j;
X(1) = 0.3;
Y(1) = 0.30000001;
for i=1:n-1
    X(i+1) =a*X(i)*(1-X(i));
    Y(i+1) =a*Y(i)*(1-Y(i));
end
plot(t,X);
hold on
plot(t,Y);
hold off
xlabel(['a=',num2str(a)]);
ylim([-0.1 1.1]);
F=getframe;
end
movie(F)
end

if mode==3
    n_over=200;
    a_count=300;
    if n<=n_over
        return
    end
    lambda=linspace(0,0,a_count);
    A=linspace(2.5,4.0,a_count);
    B=linspace(2.5,4.0,a_count);
    Xnext=linspace(0,0,n);
    deltaX=0.01
    for i=n_over:n-1
    A=[A;B];
    end
A=A';
for j=1:a_count
    a=A(j);
    
X(1) = 0.7;
lambda(j)=0;
for i=1:n-1
    X(i+1) =a*X(i)*(1-X(i));
    Xnext(i+1) =a*(X(i)+deltaX)*(1-X(i)-deltaX);
    dX=(Xnext(i+1)-X(i+1))/deltaX;
    lambda(j)=lambda(j)+log(abs(dX));
end
lambda(j)=lambda(j)/(n-1);
X2=X(n_over:n);
if j==1
    M=X(n_over:n);
else
M=[M;X2];
end

end
sz = size(A)
sz2= size(M)
subplot(2,1,1);
plot(A,M,'.r');
xlabel('a');
ylabel('x');
subplot(2,1,2);
plot(B,lambda,'.r');
xlabel('a');
ylabel('lambda[bit]');
end

if mode==4
y_noise=wgn(n,1,-150);
for j=1:200
    a=0.02*j;
X(1) = 0.3;
for i=1:n-1
    X(i+1) =a*X(i)*(1-X(i));
end

plot(t,X);
X(1) = 0.3+y_noise(1);
for i=1:n-1
    X(i+1) =a*X(i)*(1-X(i))+y_noise(i+1);
end
hold on
plot(t,X);
hold off
xlabel(['a=',num2str(a)]);
ylim([-0.1 1.1]);
 F=getframe;
end
movie(F)
end

if mode==5
y_noise=wgn(n,1,-150);
    a=4;
X(1) = 0.3;
for i=1:n-1
    X(i+1) =a*X(i)*(1-X(i));
end

plot(t,X);
X(1) = 0.3+y_noise(1);
for i=1:n-1
    X(i+1) =a*X(i)*(1-X(i))+y_noise(i+1);
end
%hold on
plot(t,X);
%hold off
xlabel(['a=',num2str(a)]);
%ylim([-0.1 1.1]);

end

if mode==6
    a=3;
X(1) = 0.3;
for i=1:n-1
    X(i+1) =a*X(i)*(1-X(i));
end
plot(t,X);
ylim([-0.1 1.1]);
xlabel('t');
ylabel('x');
ylim([-0.1 1.1]);

end
