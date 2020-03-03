%%%%%%%%%1%%%%%%%%%2%%%%%%%%%3%%%%%%%%%4%%%%%%%%%5%%%%%%%%%6%%%%%%%%%7%%%%%%%%%8%%%%%%%%%9%%%%%%%%0
%   Outline : Mutual Information
%   Description : Using vector calculation
%   Type : save.txt, plot
%   Args : x : Time series data
%          N : Number of data points in time series data
%          P : Number of partition to make frequency distribution of the histgram
%          xNormalized : Normalization of time series data
%          Tau : Delay time of phase space
%   Note : 
%   Update : 2011 July, Hiroshi Gotoda and Takuya Ikawa
%            2012 May, Yuta Okuno
%            2020 May, fukuda shingo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Gotoda laboratory, Ritsumeikan University %%%%%%%%%%%%%%%

function tauminima=mutual(X)
load('Lorenz.mat');
%�������ł�MAT�t�@�C���ɂ����X�͒�`����Ă���
    N = length(X);%�f�[�^��
    xMax = max(X);%�ő�l
    xMin = min(X);%�ŏ��l
    P = 32;%�g���W��
    tauend=50;%�\���͈�??�^�E�̏I���

%%% Normalization of time series data %%%
    xNormalized = (X-xMin)/(xMax-xMin);%���̏�����������ƃL����
%0�`1�͈̔͂ł̈ʒu�Â�
%%% Frequency distribution %%%
    Array = ceil(xNormalized*P); %: Round toward positive infinity�傫�����̐���
    Array(find(Array==0)) = 1; % If Array=0, Array=1 ��O��X=0
%%% Data save and graph %%%
    ResultMI = zeros(N+1,1);
    for Tau=1:tauend %N+1
        ResultMI(Tau,1) = MutualInformation(Tau,N,Array,P);%y��
    end
    DelayTime = [0:N]';%��������x�� 
    plot(DelayTime(1:tauend), ResultMI(1:tauend),'-b','LineWidth',3);
    %%%%%%%%%%%%%%%%%%%%%%%%%�ǂ��ł��������x��
    xlabel('DelayTime ��','FontSize',14)
    ylabel('Mutual Information I(��)','FontSize',14)
    grid on
    box on
    ax = gca;
    axis square
    ax.BoxStyle = 'full';
    set(gca,'FontSize',14)
    set(gca,'FontName','Times','FontSize',20)
    %%%%%%%%%%%%%%%%%%%%%%%%�ǂ��ł��������x��
    M = [DelayTime ResultMI];
%     save mutual.txt M -ascii
    tauminima=firstminima(M);%ans�o���Ă�
end
    

%%%%%%%%%1%%%%%%%%%2%%%%%%%%%3%%%%%%%%%4%%%%%%%%%5%%%%%%%%%6%%%%%%%%%7%%%%%%%%%8%%%%%%%%%9%%%%%%%%0
%   Outline : Calculation of entropy and Mutual Information
%   Description :
%   Type : 
%   Args : Hi,Hj,Hij : Number of each partition data
%          Pi,Pj : The marginal probability distribution functions of I and J respectively
%          Pij :  The joint probability distribution function of I and J
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MI = MutualInformation(Tau,N,Array,P);%�v�Z�֐����
    %Tau�J��Ԃ��̉�
    %N�ő�̃f�[�^��
    %Array�̓f�[�^�𐮐�����������(1-P�̒���)
    %P�g���W��
    %%% Initialization %%%
    MI = 0;
    NumberOfData = N - Tau + 1;
    Hi = zeros(P);
    Hj = zeros(P);
    Hij = zeros(P,P);
    
    %%% Calculate the number of each partition data %%%
    for I=Tau:N
        %Tau�͒x�ꎞ�ԁA���̂킩��Ȃ����Ⴍ�Ȃ�܂ł̏���T���H
        %N�`Tau�܂ł̏��͂킩���Ă���
        J=I-Tau+1;
        %�x�ꂪ�Ȃ��ꍇ�̏��
        Hi(Array(I)) = Hi(Array(I)) + 1;%�J�E���g���Ă�
        Hj(Array(J)) = Hj(Array(J)) + 1;%�J�E���g���Ă�
        Hij(Array(I),Array(J)) = Hij(Array(I),Array(J)) + 1;
    end
     % looki= Hi
    %    lookj = Hj
    %   lookij= Hij
    
    %%% Calculate the marginal probability distribution functions %%%
    Pi = Hi / NumberOfData;%����0�`1�ɂ��Ă�
    Pj = Hj / NumberOfData;
    
    %%% Calculate the joint probability distribution function %%%
    Pij = Hij / NumberOfData;
    
    %%% Caluculate the mutual information %%%
    for I=1:P; 
        for J=1:P
            if Pij(I,J)>0
                MI = MI + Pij(I,J) * log2(Pij(I,J)/(Pj(J)*Pi(I)));%�G���g���s�[��I�I
            end
        end;
    end
end

function tauminima=firstminima(M)
%fisrtminima �ŏ��ɋɏ��l�������̂�T��
%   �x�ꎞ�ԃт����߂�̂ɁA���ϑ��ݏ��ʂ��ŏ��ɋɏ��l�����т�T�����߂ɍ����
%�ŏ��ł͂Ȃ��A�ɏ��ł��闝�R�B
%   mutual.m�ƕ��p�ł���悤�ɂ��Ă���

N=length(M);
count=0;
I=1;
while(count<1)
    I=I+1;
        if (M(I-1,2)>M(I,2))&& (M(I,2)<M(I+1,2))
           tauminima=M(I,1);
       break
    end
end
end