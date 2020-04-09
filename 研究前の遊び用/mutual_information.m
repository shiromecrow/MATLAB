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



