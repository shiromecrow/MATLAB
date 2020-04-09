%% 2020�N�VB4�t�G�ۑ�
% �z���C�g�K�E�X�m�C�Y�̃����N�I�[�_�[�p�^�[���̓x�����z�𒲂ׂ�

%% �o�͂����}�̃v���p�e�B(���ɈӖ��͂Ȃ��ł�)
set(0,'defaultAxesFontSize',15)
set(0,'defaultTextFontSize',15)
set(0,'defaultAxesFontName','Times New Roman')
set(0,'DefaultTextFontName','Times New Roman')
set(0,'DefaultAxesLineWidth', 1.5)
set(0,'DefaultAxesGridColorMode','manual');
set(0,'DefaultAxesGridColor',[0 0 0]);
set(0,'DefaultAxesMinorGridColorMode','manual');
set(0,'DefaultAxesMinorGridColor',[0 0 0]);
set(0,'DefaultAxesXColorMode','manual');
set(0,'DefaultAxesXColor',[0 0 0]);
set(0,'DefaultAxesYColorMode','manual');
set(0,'DefaultAxesYColor',[0 0 0]);

%% time series maker
display('What is distribution?');
display('0=White gauss noise,�z���C�g�K�E�X�m�C�Y');
display('1=Lorenz,���[�����c������');
display('2=Rossler�C���X���[������');
display('3=Logistic�C���W�X�e�B�b�N�ʑ�');
display('4=sin_wave�Csin�g');
modein = 'mode is ';
mode = input(modein);
n=10000;
t=[1:n];
switch mode
    case {0}
        x = wgn(n,1,0);
    case {1}
        x=Lorenz_equation(n);
    case {2}
        x=Rossler_equation(n);
    case {3}
        x=Logistic(n);
    case{4}
        x=sin(2*pi/10000*t);
end
%plot(t,x);
% ����G���g���s�[�̌v�Z(�����A��╡�G�ł�)
D=5;                        % ���ߍ��ݎ���
Tau=1;                      % �x�ꎞ�ԃ�
N = length(x);%�f�[�^�̒���
NN = N-Tau*(D-1);%����f�[�^�̐�
DProd = prod(1:D);%D!���Ă��
freq = zeros(1,DProd);%D!�~D!�̍s��
for nn=1:NN
    [~,xorder] = sort(x(nn:Tau:nn+Tau*(D-1)));%x(nn����nn+Tau*(D-1)�܂ł�Tau���݂�sort)
    %[B,I] = sort(A)��I�ɏ��Ԃ̃C���f�b�N�X�𐧍�,B�ɂ͕��ёւ���̔z���~�͂Ȃ����Ƃ������Ă���D
    xkinds = 1:D;%[1,2,3,4,5]�����
    np = 1;%�����l
    for d=1:D-1
        hitorder = find(xkinds==xorder(d));%d�Ԗڂ̐���
        np = np + (hitorder-1)*prod(1:(D-d));%�����������N�I�[�_�[�p�^�[���̌���
        xkinds(:,hitorder) = [];%�f�[�^�̍폜C(2,:) = []��2�s�ڂ̂��ׂĂ��폜
    end
 
    freq(np) = freq(np) + 1;
end
p = freq./NN;%.�̈Ӗ��́H

figure();
bar(p);
ylabel('$$\sl{p(\pi_i)}$$','interpreter','latex','FontSize',24); 
xlabel('$$\sl{\pi_i}$$','interpreter','latex','FontSize',24); 
p(find(p==0)) = 1;
H = -sum(p.*log2(p))
Hp = H./log2(DProd)
% subplot(2,1,2);
% histogram(p);
% xlabel('$$\sl{p(\pi_i)}$$','interpreter','latex','FontSize',24); 
% ylabel('count','interpreter','latex','FontSize',24);

