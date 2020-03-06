function X=Logistic(n,y_noise) 
h = 0.01; % step
t=linspace(0,h*n,n);
X=linspace(0,0,n); 
Y=linspace(0,0,n); 

modein = 'What is mode? 0=amine,1=graph,2=èâä˙ílâsïqê´ÇÃämîF,3=ï™äÚê},4=ÉmÉCÉYÇ†ÇË';
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
    A=linspace(2.5,4.0,150);
    M=linspace(0,0,150);
    m=linspace(0,0,150);
for j=1:150
    a=2.5+0.01*(j-1);
    
X(1) = 0.7;
for i=1:n-1
    X(i+1) =a*X(i)*(1-X(i));
end
M(j)=max(X);
m(j)=min(X);

end
plot(A,M);
hold on
plot(A,m)
xlabel('a');
ylabel('xmaxmin');
hold off

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