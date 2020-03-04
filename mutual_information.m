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
   HX = 0;
   HY =0;
   HXY=0;
   IXY=0;
   HXlY=0;
   HYlX=0;
    
    
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
  Px = Ex / Nx;
  Py = Ey / Nx;
  Pxy = Exy / Nx;
     for I=1:P 
            if Px(I)>0
                HX = HX + Px(I) * log2(1/Px(I));
            end
        end
  
        for J=1:P
            
            if Py(J)>0
                HY = HY + Py(J) * log2(1/Py(J));
            end
        end
   for I=1:P
        for J=1:P
            if Pxy(I,J)>0
                HXY = HXY + Pxy(I,J) * log2(1/Pxy(I,J));
                IXY = IXY + Pxy(I,J) * log2(Pxy(I,J)/(Py(J)*Px(I)));
            end
        end
   end
    
   
  HX
  HY
  HXY
  IXY
  HXlY=HX-IXY
  HYlX=HY-IXY

  

end



