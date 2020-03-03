function noise_maker(n,power) 
%powerについて パワーが約 1 ワット (0 dBW) 分散が1
%ホワイトガウスノイズの付加はawgn(in,snr)
h = 0.01; % step;
x=linspace(0,h*n,n);
y_noise=wgn(n,1,power);
y=linspace(0,0,n);
y_mean=mean(y_noise)
y_absmean=mean(abs(y_noise))
y_var=var(y_noise)

subplot(2,1,1);
plot(x,y);
hold on
plot(x,y_noise)
hold off
subplot(2,1,2);
histogram(y_noise)