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

function mutual_information(X,Y) 

%�������ł�MAT�t�@�C���ɂ����X�͒�`����Ă���
    Nx = length(X);%�f�[�^��
    Ny = length(Y);%�f�[�^��
    if Nx ~= Ny
        return
    end
   xMax = max(X);%�ő�l
    yMax = max(Y);%�ő�l
    xyMax = max(xMax,yMax);%�ő�l
    xMin = min(X);%�ŏ��l
    yMin = min(Y);%�ŏ��l
    xyMin = min(xMin,yMin);%�ŏ��l
    P = 32;%����\�̂悤�Ȃ���  
    Ex = zeros(P);
    Ey = zeros(P);
    Exy = zeros(P,P);
tx = [1:Nx]';
ty = [1:Ny]';
subplot(2,1,1);
plot(tx,X);
hold on
plot(ty,Y);
hold off
subplot(2,1,2);
histogram(X);
hold on
histogram(Y);
hold off
%%% Normalization of time series data %%%
    xNormalized = (X-xyMin)/(xyMax-xyMin);%���̏�����������ƃL����
     yNormalized = (Y-xyMin)/(xyMax-xyMin);%���̏�����������ƃL����
%0�`1�͈̔͂ł̈ʒu�Â�
%%% Frequency distribution %%%
    xArray = ceil(xNormalized*P); %: Round toward positive infinity�傫�����̐���
    xArray(find(xArray==0)) = 1; % If Array=0, Array=1 ��O��X=0
     yArray = ceil(yNormalized*P); %: Round toward positive infinity�傫�����̐���
    yArray(find(yArray==0)) = 1; % If Array=0, Array=1 ��O��X=0
%maker histo
  for I=1:Nx
        %Tau�͒x�ꎞ�ԁA���̂킩��Ȃ����Ⴍ�Ȃ�܂ł̏���T���H
        %N�`Tau�܂ł̏��͂킩���Ă���
        
        %�x�ꂪ�Ȃ��ꍇ�̏��
        Ex(xArray(I)) = Ex(xArray(I)) + 1;
        Ey(yArray(I)) = Ey(yArray(I)) + 1;
        Exy(xArray(I),yArray(I)) = Exy(xArray(I),yArray(I)) + 1;
  end
 
  %  HX = MutualInformation(0,N,Array,P)
  %  HY = MutualInformation(1,N,Array,P)
  %  HXY=MutualInformation(2,N,Array,P)
   % IXY=MutualInformation(3,N,Array,P)
   %HXlY=MutualInformation(4,N,Array,P)
   %HYlX=MutualInformation(5,N,Array,P)
        

end
    

%%%%%%%%%1%%%%%%%%%2%%%%%%%%%3%%%%%%%%%4%%%%%%%%%5%%%%%%%%%6%%%%%%%%%7%%%%%%%%%8%%%%%%%%%9%%%%%%%%0
%   Outline : Calculation of entropy and Mutual Information
%   Description :
%   Type : 
%   Args : Hi,Hj,Hij : Number of each partition data
%          Pi,Pj : The marginal probability distribution functions of I and J respectively
%          Pij :  The joint probability distribution function of I and J
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MI = MutualInformation(mode,N,Array,P);%�v�Z�֐����
    %Tau�J��Ԃ��̉�
    %N�ő�̃f�[�^��
    %Array�̓f�[�^�𐮐�����������(1-P�̒���)
    %P�g���W��
    %%% Initialization %%%
    MI = 0;
    NumberOfData = N - Tau + 1;
  
    
    %%% Calculate the number of each partition data %%%
  
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

