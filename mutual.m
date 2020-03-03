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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Gotoda laboratory, Ritsumeikan University %%%%%%%%%%%%%%%

function tauminima=mutual(X)

    N = length(X);
    xMax = max(X);
    xMin = min(X);
    P = 32;
    tauend=50;

%%% Normalization of time series data %%%
    xNormalized = (X-xMin)/(xMax-xMin);

%%% Frequency distribution %%%
    Array = ceil(xNormalized*P); %: Round toward positive infinity
    Array(find(Array==0)) = 1; % If Array=0, Array=1

%%% Data save and graph %%%
    ResultMI = zeros(N+1,1);
    for Tau=1:tauend %N+1
        ResultMI(Tau,1) = MutualInformation(Tau,N,Array,P);
    end
    DelayTime = [0:N]';
    plot(DelayTime(1:tauend), ResultMI(1:tauend),'-b','LineWidth',3);
    xlabel('DelayTime τ','FontSize',14)
    ylabel('Mutual Information I(τ)','FontSize',14)
    grid on
    box on
    ax = gca;
    axis square
    ax.BoxStyle = 'full';
    set(gca,'FontSize',14)
    set(gca,'FontName','Times','FontSize',20)
    M = [DelayTime ResultMI];
%     save mutual.txt M -ascii
    tauminima=firstminima(M);
end
    

%%%%%%%%%1%%%%%%%%%2%%%%%%%%%3%%%%%%%%%4%%%%%%%%%5%%%%%%%%%6%%%%%%%%%7%%%%%%%%%8%%%%%%%%%9%%%%%%%%0
%   Outline : Calculation of entropy and Mutual Information
%   Description :
%   Type : 
%   Args : Hi,Hj,Hij : Number of each partition data
%          Pi,Pj : The marginal probability distribution functions of I and J respectively
%          Pij :  The joint probability distribution function of I and J
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MI = MutualInformation(Tau,N,Array,P);
    
    %%% Initialization %%%
    MI = 0;
    NumberOfData = N - Tau + 1;
    Hi = zeros(P);
    Hj = zeros(P);
    Hij = zeros(P,P);
    
    %%% Calculate the number of each partition data %%%
    for I=Tau:N
        J=I-Tau+1;
        Hi(Array(I)) = Hi(Array(I)) + 1;
        Hj(Array(J)) = Hj(Array(J)) + 1;
        Hij(Array(I),Array(J)) = Hij(Array(I),Array(J)) + 1;
    end
    
    %%% Calculate the marginal probability distribution functions %%%
    Pi = Hi / NumberOfData;
    Pj = Hj / NumberOfData;
    
    %%% Calculate the joint probability distribution function %%%
    Pij = Hij / NumberOfData;
    
    %%% Caluculate the mutual information %%%
    for I=1:P; 
        for J=1:P
            if Pij(I,J)>0
                MI = MI + Pij(I,J) * log2(Pij(I,J)/(Pj(J)*Pi(I)));
            end
        end;
    end
end

function tauminima=firstminima(M)
%fisrtminima 最初に極小値を取るものを探す
%   遅れ時間τを決めるのに、平均相互情報量が最初に極小値を取るτを探すために作った
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