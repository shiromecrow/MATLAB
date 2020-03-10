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
display('What is distribution?');
display('0=Lorenz,もらったやつ');
display('1=Lorenz,ローレンツ方程式');
display('2=Rossler，レスラー方程式');
display('3=Logistic，ロジスティック写像');
modein = 'mode is ';
mode = input(modein);
switch mode
    case {0}
        load('Lorenz.mat');
    case {1}
        X=Lorenz_equation(10000);
        X=X';
    case {2}
        X=Rossler_equation(10000);
        X=X';
    case {3}
        X=Logistic(1000);
        X=X';
    case{4}
       % x=sin(2*pi/10000*t);
end

save('attractor.mat','X');
%もうすでにMATファイルによってXは定義されている
    N = length(X);%データ数
    xMax = max(X);%最大値
    xMin = min(X);%最小値
    P = 32;%拡張係数
    tauend=N;%表示範囲??タウの終わり

%%% Normalization of time series data %%%
    xNormalized = (X-xMin)/(xMax-xMin);%この書き方ちょっとキモい
%0～1の範囲での位置づけ
%%% Frequency distribution %%%
    Array = ceil(xNormalized*P); %: Round toward positive infinity大きい方の整数
    Array(find(Array==0)) = 1; % If Array=0, Array=1 例外処X=0
%%% Data save and graph %%%
    ResultMI = zeros(N+1,1);
    for Tau=1:tauend %N+1
        ResultMI(Tau,1) = MutualInformation(Tau,N,Array,P);%y軸
    end
    DelayTime = [0:N]';%整数並びx軸 
%     subplot(2,1,2);
    plot(DelayTime(1:tauend), ResultMI(1:tauend),'-b','LineWidth',3);
    %%%%%%%%%%%%%%%%%%%%%%%%%どうでもいいラベル
    xlabel('DelayTime τ','FontSize',14)
    ylabel('Mutual Information I(τ)','FontSize',14)
    grid on
    box on
    ax = gca;
    axis square
    ax.BoxStyle = 'full';
    set(gca,'FontSize',14)
    set(gca,'FontName','Times','FontSize',20)
    %%%%%%%%%%%%%%%%%%%%%%%%どうでもいいラベル
    M = [DelayTime ResultMI]; 
%     save mutual.txt M -ascii
 %tauminima=firstminima(M)%ans出してる
 tauin = 'tau is ';
tauminima = input(tauin);
 make_attractor(tauminima,N,mode);
end
    

%%%%%%%%%1%%%%%%%%%2%%%%%%%%%3%%%%%%%%%4%%%%%%%%%5%%%%%%%%%6%%%%%%%%%7%%%%%%%%%8%%%%%%%%%9%%%%%%%%0
%   Outline : Calculation of entropy and Mutual Information
%   Description :
%   Type : 
%   Args : Hi,Hj,Hij : Number of each partition data
%          Pi,Pj : The marginal probability distribution functions of I and J respectively
%          Pij :  The joint probability distribution function of I and J
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MI = MutualInformation(Tau,N,Array,P);%計算関数やで
    %Tau繰り返しの回数
    %N最大のデータ数
    %Arrayはデータを整数化したもの(1-Pの中で)
    %P拡張係数
    %%% Initialization %%%
    MI = 0;
    NumberOfData = N - Tau + 1;
    Hi = zeros(P);
    Hj = zeros(P);
    Hij = zeros(P,P);
    
    %%% Calculate the number of each partition data %%%
    for I=Tau:N
        %Tauは遅れ時間、情報のわからなさが低くなるまでの情報を探す？
        %N～Tauまでの情報はわかっている
        J=I-Tau+1;
        %遅れがない場合の情報
        Hi(Array(I)) = Hi(Array(I)) + 1;%カウントしてる
        Hj(Array(J)) = Hj(Array(J)) + 1;%カウントしてる
        Hij(Array(I),Array(J)) = Hij(Array(I),Array(J)) + 1;
    end
     % looki= Hi
    %    lookj = Hj
    %   lookij= Hij
    
    %%% Calculate the marginal probability distribution functions %%%
    Pi = Hi / NumberOfData;%分数0～1にしてる
    Pj = Hj / NumberOfData;
    
    %%% Calculate the joint probability distribution function %%%
    Pij = Hij / NumberOfData;
    
    %%% Caluculate the mutual information %%%
    for I=1:P
        for J=1:P
            if Pij(I,J)>0
                MI = MI + Pij(I,J) * log2(Pij(I,J)/(Pj(J)*Pi(I)));%エントロピーや！！
            end
        end
    end
    
    
end

function tauminima=firstminima(M)
%fisrtminima 最初に極小値を取るものを探す
%   遅れ時間τを決めるのに、平均相互情報量が最初に極小値を取るτを探すために作った
%最小ではなく、極小である理由。
%   mutual.mと併用できるようにしてある

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

function make_attractor(tauminima,N,datamode)
%attractorを制作する関数
    display('What is mode?');
display('0=静止画');
display('1=動画');
modein = 'mode is ';
mode = input(modein);
load('attractor.mat');
       if mode ==0
           Xat=X(1:N-3*tauminima);
           Yat=X(tauminima+1:N-2*tauminima);
           Zat=X(tauminima*2+1:N-tauminima);
           Vat=X(tauminima*3+1:N);
   Xnum = numel(Xat);%配列数の確認
    Ynum = numel(Yat);%配列数の確認
    Znum = numel(Zat);%配列数の確認
   % subplot(2,1,1)
   if datamode == 3
      cob=linspace(0,0,100); 
      web=linspace(0,0,100);
      cob(1)=Xat(1);
      web(1)=0;
      cw=1;
       for tt=1:2:N
           cob(tt+1)=cob(tt);
           web(tt+1)=Yat(cw);
           cob(tt+2)=web(tt+1);
           web(tt+2)=web(tt+1);
           cw=find(Xat==web(tt+2));
       end
   plot(Xat,Yat,'.b');%
   hold on
   plot(cob,web);
   hold off
   else
       scatter3(Xat,Yat,Zat,2,Vat,'filled') ;
   % plot3(Xat,Yat,Zat);
   end
    xlabel( 'x','FontSize',14);
    ylabel( 'y','FontSize',14);
    zlabel( 'z','FontSize',14);
    cb = colorbar;
    cb.Label.String = 'v';
    legend(['tau=',num2str(tauminima)]);
       end
    if mode ==1
    for tauminima=1:1:500
           Xat=X(1:N-3*tauminima);
           Yat=X(tauminima+1:N-2*tauminima);
           Zat=X(tauminima*2+1:N-tauminima);
           Vat=X(tauminima*3+1:N);
    Xnum = numel(Xat);%配列数の確認
    Ynum = numel(Yat);%配列数の確認
    Znum = numel(Zat);%配列数の確認
   % subplot(2,1,1)
   if datamode == 3
   plot(Xat,Yat);%,'.r'
   else
   scatter3(Xat,Yat,Zat,2,Vat,'filled') 
   end
    xlabel( 'x','FontSize',14);
    ylabel( 'y','FontSize',14);
    zlabel( 'z','FontSize',14);
      cb = colorbar;
    cb.Label.String = 'v';
    legend(['tau=',num2str(tauminima)]);
     F=getframe;
    end
movie(F)
    end
end