function power_spectral(Xsp,deltaT)
fs=1/deltaT;
n=length(Xsp);% number of samples
z=fft(Xsp);          %‚‘¬ƒt[ƒŠƒG•ÏŠ·
f = (0:n-1)*(fs/n);     %ü”g”‚Ì—Ìˆæ
power = abs(z).^2/n;    % power of the DFT
plot(f,power);
xlabel('Frequency');
ylabel('Power');