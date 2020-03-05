function distribution(n) 
display('What is distribution?');
display('0=Gaussian,ガウス分布');
display('1=exponential,指数分布');
display('2=gamma，ガンマ分布');
display('3=pareto，パレード分布');
modein = 'mode is ';
mode = input(modein);
dt=0.01;

switch mode
case {0}
    Gaussian_distribution(n,dt);
case {1}
    exponential_distribution(n,dt);
 case {2}
    gamma_distribution(n,dt)
case {3}
pd = makedist('GeneralizedPareto','k',3,'sigma',2,'theta',0);
x=0:.1:15;
y=pdf(pd,x);
plot(x,y);
case {4}

case {5}

case {6}
end


end

function Gaussian_distribution(n,dt)
x=linspace(0,n,n/dt+1);
 y=linspace(0,0,n/dt+1);
 Y=linspace(0,0,n/dt+1);
 E1=linspace(0,0,n/dt+1);
 E2=linspace(0,0,n/dt+1);
 mu=n/2;
modein2 = '0=静止モード,1=分散変化モード';
mode2 = input(modein2);
if mode2==0
    tauin = 'tau?';
    tau = input(tauin);
    for i=1:n/dt+1
        y(i) = 1/(2*pi)^(1/2)/tau*exp(-(x(i)-mu)^2/2/tau^2);
        E1(i)=x(i)*y(i)*dt;
        E2(i)=(x(i)^2)*y(i)*dt;
        if i~=1
            Y(i) = Y(i-1) + y(i)*dt;
        end
    end
    y_sigma=sum(y)*dt
    E1_real=sum(E1)
    E1_ideal=mu
    E2_real=sum(E2)-E1_real^2
    E2_ideal=tau^2
    subplot(1,2,1);
    plot(x,y);
    subplot(1,2,2);
     plot(x,Y);
end
if mode2==1
    for j=1:200
        tau=j*0.01;
    for i=1:n/dt+1
       y(i) = 1/(2*pi)^(1/2)/tau*exp(-(x(i)-mu)^2/2/tau^2);
        E1(i)=x(i)*y(i)*dt;
        E2(i)=(x(i)^2)*y(i)*dt;
        if i~=1
            Y(i) = Y(i-1) + y(i)*dt;
        end
    end
    subplot(2,1,1);
    plot(x,y);
    ylim([0 2]);
    subplot(2,1,2);
     plot(x,Y);
     ylim([0 1]);
    F=getframe;
    end
    movie(F)
end


end


function exponential_distribution(n,dt)
x=linspace(0,n,n/dt+1);
 y=linspace(0,0,n/dt+1);
 Y=linspace(0,0,n/dt+1);
 E1=linspace(0,0,n/dt+1);
 E2=linspace(0,0,n/dt+1);
modein2 = '0=静止モード,1=変数変化モード';
mode2 = input(modein2);
if mode2==0
    lammdain = 'lammda?';
    lammda = input(lammdain);
    for i=1:n/dt+1
        y(i) = lammda*exp(-lammda*x(i));
        E1(i)=x(i)*y(i)*dt;
        E2(i)=(x(i)^2)*y(i)*dt;
        if i~=1
            Y(i) = Y(i-1) + y(i)*dt;
        end
    end
    y_sigma=sum(y)*dt
    E1_real=sum(E1)
    E1_ideal=1/lammda
    E2_real=sum(E2)-E1_real^2
    E2_ideal=1/lammda^2
    subplot(1,2,1);
    plot(x,y);
    subplot(1,2,2);
     plot(x,Y);
end
if mode2==1
    for j=1:200
        lammda=j*0.01;
    for i=1:n/dt+1
        y(i) = lammda*exp(-lammda*x(i));
        E1(i)=x(i)*y(i)*dt;
        E2(i)=(x(i)^2)*y(i)*dt;
        if i~=1
            Y(i) = Y(i-1) + y(i)*dt;
        end
    end
    subplot(2,1,1);
    plot(x,y);
    ylim([0 2]);
    subplot(2,1,2);
     plot(x,Y);
     ylim([0 1]);
    F=getframe;
    end
    movie(F)
end


end

function gamma_distribution(n,dt)
x=linspace(0,n,n/dt+1);
 y=linspace(0,0,n/dt+1);
 Y=linspace(0,0,n/dt+1);
 E1=linspace(0,0,n/dt+1);
 E2=linspace(0,0,n/dt+1);
modein2 = '0=静止モード,1=変数変化モード';
mode2 = input(modein2);
if mode2==0
    lammdain = 'lammda?';
    lammda = input(lammdain);
    for i=1:n/dt+1
        y(i) = lammda*exp(-lammda*x(i));
        E1(i)=x(i)*y(i)*dt;
        E2(i)=(x(i)^2)*y(i)*dt;
        if i~=1
            Y(i) = Y(i-1) + y(i)*dt;
        end
    end
    y_sigma=sum(y)*dt
    E1_real=sum(E1)
    E1_ideal=1/lammda
    E2_real=sum(E2)-E1_real^2
    E2_ideal=1/lammda^2
    subplot(1,2,1);
    plot(x,y);
    subplot(1,2,2);
     plot(x,Y);
end
if mode2==1
    for j=1:200
        lammda=j*0.01;
    for i=1:n/dt+1
        y(i) = lammda*exp(-lammda*x(i));
        E1(i)=x(i)*y(i)*dt;
        E2(i)=(x(i)^2)*y(i)*dt;
        if i~=1
            Y(i) = Y(i-1) + y(i)*dt;
        end
    end
    subplot(2,1,1);
    plot(x,y);
    ylim([0 2]);
    subplot(2,1,2);
     plot(x,Y);
     ylim([0 1]);
    F=getframe;
    end
    movie(F)
end


end

