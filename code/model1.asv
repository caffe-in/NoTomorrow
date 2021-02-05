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
decay_rate_22;

%% 皮尔逊系数

coff1 = corr(extention_rate_10,decay_rate_10);
coff2 = corr(extention_rate_16,decay_rate_16);
coff3 = corr(extention_rate_22,log(decay_rate_22));
coff4 = corr(moistrue_trade_off,log_D);
%% 画图并回归分析
figure;
xlabel('Hyphal extesion rate');
ylabel('Decomposition rate');
plot(extention_rate_10,decay_rate_10,'r.',extention_rate_16,decay_rate_16,'b.',extention_rate_22,decay_rate_22,'g.','MarkerSize',15);
hold on
p1 = polyfit(extention_rate_10,decay_rate_10,1);
x1 = [1:0.1:11];
y1 = polyval(p1,x1);
plot(x1,y1,'r','LineWidth',2)

p2 = polyfit(extention_rate_16,decay_rate_16,1);
x2 = [1:0.1:11];
y2 = polyval(p2,x2);
plot(x2,y2,'b','LineWidth',2)

p3 = polyfit(extention_rate_22,decay_rate_22,1);
x3 = [1:0.1:11];
y3 = polyval(p3,x3);
plot(x3,y3,'g','LineWidth',2)
legend('10','16','22','Location','NorthWest')
gtext('T(℃)','FontSize',10)
hold off
figure;
p4 = polyfit(moistrue_trade_off,log_D,1);
x4 = [-1:0.1:1];
y4 = polyval(p4,x4);
hold on
plot(moistrue_trade_off,log_D,'k.','MarkerSize',15)
plot(x4,y4,'k','LineWidth',2)
xlabel('moisture trade-off')
ylabel('log(decompostion rate)')
hold off


%% 偏微分方程求解
% coff = [3.0908,2.24708,2.4089]
% x1 = sym('x1',[1,3])
% x2 = sym('x2',[1,3])
% x3 = sym('x3',[1,3])
% eqns1 = [...
%     3.0908*0.3*x1(2)+x1(1)*(exp(0.9367-0.7396)+x1(3))==4.07,...
%     3.0908*0.18*x1(2)+x1(1)*(exp(0.9367-0.7159)+x1(3))==3.2,...
%     3.0908*0.26*x1(2)+x1(1)*(exp(0.9367-0.7219)+x1(3))==2.94]
% eqns2 = [...
%     2.24708*0.36*x2(2)+x2(1)*(exp(0.9367-0.7396)+x2(3))==10.21,...
%     2.24708*0.26*x2(2)+x2(1)*(exp(0.9367-0.7159)+x2(3))==1.89,...
%     2.24708*0.24*x2(2)+x2(1)*(exp(0.9367-0.7219)+x2(3))==6.09]
% eqns3 = [...
%     2.4089*0.34*x3(2)+x3(1)*(exp(0.9367-0.7396)+x3(3))==17.12,...
%     2.4089*0.38*x3(2)+x3(1)*(exp(0.9367-0.7159)+x3(3))==15.42,...
%     2.4089*0.32*x3(2)+x3(1)*(exp(0.9367-0.7219)+x3(3))==11]
% 
% solve1 = solve(eqns1,[x1(1),x1(2),x1(3)])
% solve2 = solve(eqns2,[x2(1),x2(2),x2(3)])
% solve3 = solve(eqns3,[x3(1),x3(2),x3(3)])
% 
% solve1.x11 = vpa(solve1.x11)
% solve1.x12 = vpa(solve1.x12)
% solve1.x13 = vpa(solve1.x13)
% solve2.x21 = vpa(solve2.x21)
% solve2.x22 = vpa(solve2.x22)
% solve2.x23 = vpa(solve2.x23)
% solve3.x31 = vpa(solve3.x31)
% solve3.x32 = vpa(solve3.x32)
% solve3.x33 = vpa(solve3.x33)



% for i =1:3
%     if i==1
%         for j=1:3
%             eqns(i,j)=coff(1)*extention_rate_10(j)*x1(2)+x1(1)*(exp(0.9367-moistrue_trade_off(j)+x1(3)))==decay_rate_10(j);
%         end
%     elseif i==2
%         for j=1:3
%             eqns(i,j)=coff(2)*extention_rate_16(j)*x2(2)+x2(1)*(exp(0.9367-moistrue_trade_off(j)+x2(3)))==decay_rate_16(j);
%         end
%     else
%         for j=1:3
%             eqns(i,j)=coff(3)*extention_rate_22(j)*x3(2)+x3(1)*(exp(0.9367-moistrue_trade_off(j)+x3(3)))==decay_rate_22(j);
%         end
%     end
% end










