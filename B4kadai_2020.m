%% 2020年新B4春季課題
% ホワイトガウスノイズのランクオーダーパターンの度数分布を調べる

%% 出力される図のプロパティ(特に意味はないです)
set(0,'defaultAxesFontSize',24)
set(0,'defaultTextFontSize',24)
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

%% ホワイトガウスノイズの生成
x = wgn(10000,1,0);

% 順列エントロピーの計算(ここ、やや複雑です)
D=5;                        % 埋め込み次元
Tau=1;                      % 遅れ時間τ
N = length(x);
NN = N-Tau*(D-1);
DProd = prod(1:D);
freq = zeros(1,DProd);
for nn=1:NN
    [~,xorder] = sort(x(nn:Tau:nn+Tau*(D-1)));
    xkinds = 1:D;
    np = 1;
    for d=1:D-1
        hitorder = find(xkinds==xorder(d));
        np = np + (hitorder-1)*prod(1:(D-d));
        xkinds(:,hitorder) = [];
    end
    freq(np) = freq(np) + 1;
end
p = freq./NN;
figure()
bar(p);
ylabel('$$\sl{p(\pi_i)}$$','interpreter','latex','FontSize',24); 
xlabel('$$\sl{\pi_i}$$','interpreter','latex','FontSize',24); 
p(find(p==0)) = 1;
H = -sum(p.*log2(p));
Hp = H./log2(DProd);
