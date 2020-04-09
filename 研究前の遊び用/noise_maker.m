function noise_maker(n,power) 
%power�ɂ��� �p���[���� 1 ���b�g (0 dBW) ���U��1
%�z���C�g�K�E�X�m�C�Y�̕t����awgn(in,snr)
h = 0.01; % step;
x=linspace(0,h*n,n);%A.'�]�u
y_noise=wgn(n,1,power);
y_noise2=wgn(n,1,power);
y_noise2=y_noise2+10
y=linspace(0,0,n);
y_mean=mean(y_noise)
y_absmean=mean(abs(y_noise))
y_var=var(y_noise)

subplot(2,2,1);
plot(x,y);
hold on
plot(x,y_noise)
hold off
subplot(2,2,2);
histogram(y_noise)

subplot(2,2,[3,4]);
Logistic(n,y_noise);
save('noise_test.mat','y_noise');
save('noise_test2.mat','y_noise2');