%% 读取数据
[all_num] = xlsread('fungus_data.xlsx');
moistrue_trade_off = all_num(:,1);
log_D = all_num(:,2);
extention_rate_10 = all_num(:,5);
extention_rate_16 = all_num(:,6);
extention_rate_22 = all_num(:,7);
decay_rate_10 = all_num(:,8);
decay_rate_16 = all_num(:,9);
decay_rate_22 = all_num(:,10);
decay_rate_mean = all_num(:,11);
%筛选数据
% decay_rate_22 = [decay_rate_22(1:11,:);decay_rate_22(13:18,:);decay_rate_22(21:22,:);decay_rate_22(24:28,:);decay_rate_22(31:end,:)];
% extention_rate_22 = [extention_rate_22(1:11,:);extention_rate_22(13:18,:);extention_rate_22(21:22,:);extention_rate_22(24:28,:);extention_rate_22(31:end,:)];


%% 皮尔逊系数

coff1 = corr(extention_rate_10,decay_rate_10);
coff2 = corr(extention_rate_16,decay_rate_16);
coff3 = corr(extention_rate_22,decay_rate_22)
coff4 = corr(moistrue_trade_off,log_D);

%% 画图并回归分析
subplot(2,2,1)
xlabel('Hyphal extension rate');
ylabel('Decomposition rate');
hold on
plot(extention_rate_10,decay_rate_10,'r.','MarkerSize',15)
[p1,s] = polyfit(extention_rate_10,decay_rate_10,1);
x1 = [0:0.1:4];
y1 = polyval(p1,x1);
[Y,dy]=polyconf(p1,x1,s)
hconf = plot(x1,Y+dy,'r--')
plot(x1,Y-dy,'r--')
plot(x1,y1,'r','LineWidth',2)
legend('10℃','Location','NorthWest')
hold off

subplot(2,2,2)
xlabel('Hyphal extension rate');
ylabel('Decomposition rate');
hold on
plot(extention_rate_16,decay_rate_16,'b.','MarkerSize',15)
[p2,s] = polyfit(extention_rate_16,decay_rate_16,1);
x2 = [0:0.1:8];
y2 = polyval(p2,x2);
[Y,dy]=polyconf(p2,x2,s)
hconf = plot(x2,Y+dy,'b--')
plot(x2,Y-dy,'b--')
plot(x2,y2,'b','LineWidth',2)
legend('16℃','Location','NorthWest')
hold off

subplot(2,2,3)
xlabel('Hyphal extension rate');
ylabel('Decomposition rate');
hold on
plot(extention_rate_22,decay_rate_22,'g.','MarkerSize',15)
[p3,s]= polyfit(extention_rate_22,decay_rate_22,1);
x3 = [0:0.1:11];
y3 = polyval(p3,x3);
[Y,dy]=polyconf(p3,x3,s)
hconf = plot(x3,Y+dy,'g--')
plot(x3,Y-dy,'g--')
plot(x3,y3,'g','LineWidth',2)
legend('22℃','Location','NorthWest')
hold off

subplot(2,2,4)
[p4,s] = polyfit(moistrue_trade_off,log_D,1);
x4 = [-1:0.1:1];
y4 = polyval(p4,x4);
hold on
plot(moistrue_trade_off,log_D,'k.','MarkerSize',15)
[Y,dy]=polyconf(p4,x4,s)
hconf = plot(x4,Y+dy,'k--')
plot(x4,Y-dy,'k--')
plot(x4,y4,'k','LineWidth',2)
xlabel('moisture trade-off')
ylabel('log(decomposition rate)')
hold off


%% 偏微分方程不可求解
tmp_coff = [2.7239,2.24708,2.4089];
mosi_coff = 0.9307;

c11 = mean(decay_rate_10-tmp_coff(1)*extention_rate_10)
c12 = mean(decay_rate_16-tmp_coff(1)*extention_rate_16)
c13 = mean(decay_rate_22-tmp_coff(1)*extention_rate_22)
c2 = mean(-exp(moistrue_trade_off)+exp(log_D))
[G,M]=meshgrid(1:0.01:11,-1:0.01:1); 
D1 = tmp_coff(1)*G-4,75+exp(mosi_coff*M)*5.2292
D2 = tmp_coff(2)*G-12.0841+exp(mosi_coff*M)*16.4940
D3 = tmp_coff(3)*G+9.8199+exp(mosi_coff*M)*-17.2108;
subplot(3,1,1)
test = surf(G,M,D1)
legend('10℃','Location','NorthWest')
xlabel('Hyphal extension rate')
ylabel('Moisture trade-off')
zlabel('Decomposition rate')
subplot(3,1,2)
surf(G,M,D2)
legend('16℃','Location','NorthWest')
xlabel('Hyphal extension rate')
ylabel('Moisture trade-off')
zlabel('Decomposition rate')
subplot(3,1,3)
surf(G,M,D3)
legend('22℃','Location','NorthWest')
xlabel('Hyphal extension rate')
ylabel('Moisture trade-off')
zlabel('Decomposition rate')











