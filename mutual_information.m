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

%もうすでにMATファイルによってXは定義されている
    Nx = length(X);%データ数
    Ny = length(Y);%データ数
    if Nx ~= Ny
        return
    end
   xMax = max(X);%最大値
    yMax = max(Y);%最大値
    xyMax = max(xMax,yMax);%最大値
    xMin = min(X);%最小値
    yMin = min(Y);%最小値
    xyMin = min(xMin,yMin);%最小値
    P = 32;%分解能のようなもの  
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
    xNormalized = (X-xyMin)/(xyMax-xyMin);%この書き方ちょっとキモい
     yNormalized = (Y-xyMin)/(xyMax-xyMin);%この書き方ちょっとキモい
%0～1の範囲での位置づけ
%%% Frequency distribution %%%
    xArray = ceil(xNormalized*P); %: Round toward positive infinity大きい方の整数
    xArray(find(xArray==0)) = 1; % If Array=0, Array=1 例外処X=0
     yArray = ceil(yNormalized*P); %: Round toward positive infinity大きい方の整数
    yArray(find(yArray==0)) = 1; % If Array=0, Array=1 例外処X=0
%maker histo
  for I=1:Nx
        %Tauは遅れ時間、情報のわからなさが低くなるまでの情報を探す？
        %N～Tauまでの情報はわかっている
        
        %遅れがない場合の情報
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

function MI = MutualInformation(mode,N,Array,P);%計算関数やで
    %Tau繰り返しの回数
    %N最大のデータ数
    %Arrayはデータを整数化したもの(1-Pの中で)
    %P拡張係数
    %%% Initialization %%%
    MI = 0;
    NumberOfData = N - Tau + 1;
  
    
    %%% Calculate the number of each partition data %%%
  
     % looki= Hi
    %    lookj = Hj
    %   lookij= Hij
    
    %%% Calculate the marginal probability distribution functions %%%
    Pi = Hi / NumberOfData;%分数0～1にしてる
    Pj = Hj / NumberOfData;
    
    %%% Calculate the joint probability distribution function %%%
    Pij = Hij / NumberOfData;
    
    %%% Caluculate the mutual information %%%
    
    for I=1:P; 
        for J=1:P
            if Pij(I,J)>0
                MI = MI + Pij(I,J) * log2(Pij(I,J)/(Pj(J)*Pi(I)));%エントロピーや！！
            end
        end;
    end
    
end

