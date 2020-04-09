%% 2020年新B4春季課題
% ホワイトガウスノイズのランクオーダーパターンの度数分布を調べる

%% 出力される図のプロパティ(特に意味はないです)
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
display('0=White gauss noise,ホワイトガウスノイズ');
display('1=Lorenz,ローレンツ方程式');
display('2=Rossler，レスラー方程式');
display('3=Logistic，ロジスティック写像');
display('4=sin_wave，sin波');
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
% 順列エントロピーの計算(ここ、やや複雑です)
D=5;                        % 埋め込み次元
Tau=1;                      % 遅れ時間τ
N = length(x);%データの長さ
NN = N-Tau*(D-1);%取れるデータの数
DProd = prod(1:D);%D!してるで
freq = zeros(1,DProd);%D!×D!の行列
for nn=1:NN
    [~,xorder] = sort(x(nn:Tau:nn+Tau*(D-1)));%x(nnからnn+Tau*(D-1)までのTau刻みのsort)
    %[B,I] = sort(A)でIに順番のインデックスを制作,Bには並び替え後の配列を~はないことを示している．
    xkinds = 1:D;%[1,2,3,4,5]を作る
    np = 1;%初期値
    for d=1:D-1
        hitorder = find(xkinds==xorder(d));%d番目の数字
        np = np + (hitorder-1)*prod(1:(D-d));%ここがランクオーダーパターンの決定
        xkinds(:,hitorder) = [];%データの削除C(2,:) = []で2行目のすべてを削除
    end
 
    freq(np) = freq(np) + 1;
end
p = freq./NN;%.の意味は？

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

