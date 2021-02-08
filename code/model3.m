
%% 数据读取
[all_num,txt,raw] = xlsread('fungus_data_2.xlsx');
moistrue_trade_off = all_num(2:35,1);
extention_rate_10 = all_num(2:35,4);
extention_rate_16 = all_num(2:35,5);
extention_rate_22 = all_num(2:35,6);
decay_rate_10 = all_num(2:35,8);
decay_rate_16 = all_num(2:35,9);
decay_rate_22 = all_num(2:35,10);
name_list=txt(:,1)
%% 拟合抗湿度和生长速率
% 10摄氏度

subplot(1,3,1)
hold on
xlabel('moistrue trade off/ Mpa')
ylabel('extention rate/ mm\cdot day^{-1}')
plot(moistrue_trade_off,extention_rate_10,'r.','MarkerSize',15)
ln_ex_rate_10=log(extention_rate_10);
ME_coff_10=polyfit(moistrue_trade_off,extention_rate_10,2);
e_rate_p_10 = polyval(ME_coff_10,[-1:0.01:1]);
plot([-1:0.01:1],e_rate_p_10,'r','LineWidth',1)
legend('10℃','Location','NorthWest')
hold off

%16摄氏度
subplot(1,3,2)
hold on
xlabel('moistrue trade off/ Mpa')
ylabel('extention rate/ mm\cdot day^{-1}')
plot(moistrue_trade_off,extention_rate_16,'b.','MarkerSize',15)
ln_ex_rate_16=log(extention_rate_16);
ME_coff_16=polyfit(moistrue_trade_off,extention_rate_16,2);
e_rate_p_16 = polyval(ME_coff_16,[-1:0.01:1]);
plot([-1:0.01:1],e_rate_p_16,'b','LineWidth',1)
legend('16℃','Location','NorthWest')
hold off

%22摄氏度
subplot(1,3,3)
hold on
xlabel('moistrue trade off/ Mpa')
ylabel('extention rate/ mm\cdot day^{-1}')
plot(moistrue_trade_off,extention_rate_22,'g.','MarkerSize',15)
ln_ex_rate_22=log(extention_rate_22);
ME_coff_22=polyfit(moistrue_trade_off,extention_rate_22,2);
e_rate_p_22 = polyval(ME_coff_22,[-1:0.01:1]);
plot([-1:0.01:1],e_rate_p_22,'g','LineWidth',1)
legend('22℃','Location','NorthWest')
hold off

%% 计算在种群竞争请款下，decay_rate随时间的关系
%假设不考虑温度，湿度，抗湿度的影响
% T=16摄氏度

h=0.1
%二元种内竞争 slope1 slope2 slope11 slope12 slope13 slope14
ts=[0:h:30]
figure
decay_rate_16_under_competiton_s1=2.24708*slope1-5.8201
decay_rate_16_under_competiton_s2=2.24708*slope2-5.8201
decay_rate_16_under_nocompetition_s1=2.24708*slope11-5.8201
decay_rate_16_under_nocompetition_s2=2.24708*slope14-5.8201

for i=1:299
    if decay_rate_16_under_competiton_s1(i)<0
        decay_rate_16_under_competiton_s1(i)=0
    end
    if decay_rate_16_under_competiton_s2(i)<0
        decay_rate_16_under_competiton_s2(i)=0
    end
    if decay_rate_16_under_nocompetition_s1(i)<0
        decay_rate_16_under_nocompetition_s1(i)=0
    end
    if decay_rate_16_under_nocompetition_s2(i)<0
        decay_rate_16_under_nocompetition_s2(i)=0
    end
end
decay_rate_16_under_competition = decay_rate_16_under_competiton_s1+decay_rate_16_under_competiton_s2
hold on
plot(ts(1:299),decay_rate_16_under_competition,'r','LineWidth',2)
plot(ts(1:299),decay_rate_16_under_nocompetition_s1,'b','LineWidth',2)
plot(ts(1:299),decay_rate_16_under_nocompetition_s2,'g','LineWidth',2)
legend('mix','AGF C6D','AGE A6F','Location','best')
xlabel('Time/day');
ylabel('Decomposition rate/%');
hold off

%二元内不同种族竞争
ts=[0:h:10]
figure
decay_rate_16_under_competiton_s1=2.24708*slope3-5.8201
decay_rate_16_under_competiton_s2=2.24708*slope4-5.8201
decay_rate_16_under_nocompetition_s1=2.24708*slope15-5.8201
decay_rate_16_under_nocompetition_s2=2.24708*slope18-5.8201

for i=1:99
    if decay_rate_16_under_competiton_s1(i)<0
        decay_rate_16_under_competiton_s1(i)=0
    end
    if decay_rate_16_under_competiton_s2(i)<0
        decay_rate_16_under_competiton_s2(i)=0
    end
    if decay_rate_16_under_nocompetition_s1(i)<0
        decay_rate_16_under_nocompetition_s1(i)=0
    end
    if decay_rate_16_under_nocompetition_s2(i)<0
        decay_rate_16_under_nocompetition_s2(i)=0
    end
end
decay_rate_16_under_competition = decay_rate_16_under_competiton_s1+decay_rate_16_under_competiton_s2
hold on
plot(ts(1:99),decay_rate_16_under_competition,'r','LineWidth',2)
plot(ts(1:99),decay_rate_16_under_nocompetition_s1,'b','LineWidth',2)
plot(ts(1:99),decay_rate_16_under_nocompetition_s2,'g','LineWidth',2)
legend('mix','FFT A3E','HCH B2B','Location','best')
xlabel('Time/day');
ylabel('Decomposition rate/%');
hold off


%% 生长速率随着湿度变化的影响
%不考虑物种竞争，温度影响
%t=16摄氏度
[fungus_data]=xlsread('fungus_data_3.csv');
E_M=18.1693; %16摄氏度下的饱和水汽压
G_ks_coff = 7.8391 %16摄氏度下的水汽压修正系数
water_coff=[13.5748,6.2374,-4.8789;
            2.4194,4.8410,-1.2839;
            3.1491,8.4819,-2.3910]; %湿度影响系数
water_min_list=fungus_data(:,11);
water_max_list=fungus_data(:,12);
color_list=['r','b','g']
figure
hold on
k=3
xlabel('Humidity/Mpa')
ylabel('extention rate/ mm\cdot day^{-1}')
for i=1:k
    G_M_at_mosi_tf=polyval(ME_coff_16,moistrue_trade_off(i));
    water_max=water_max_list(i);
    water_min=water_min_list(i);
    name=name_list(i);
    step_1=[0:0.5:5]
    step_2=[0:0.01:5]
    for j=1:size(step_1,2)
        G_at_H(j) = G_ks_coff*G_ks(step_1(j),E_M,G_M_at_mosi_tf,water_min,water_max,water_coff(i,:));
    end
    G_at_H_matrix(i,:) = spline(step_1,G_at_H,step_2)
    plot([0:0.01:5],G_at_H_matrix(i,:),color_list(i),'LineWidth',2);
end
legend(name_list(2:k+1),'Location','best')
hold off

%% 生长速率随温度的变化
%不考虑湿度，物种竞争的影响
[fungus_data]=xlsread('fungus_data_3.csv');
GM_at_tp_list = fungus_data(:,9)*9.0391;
tp_at_max_GM_list = fungus_data(:,10);
G_T_coff=[0.08914,0.1291,0.3244] %16摄氏度下的温度修正系数
offset_matrix=[78.193,42.1891,44.1930]
temp_coff=[-0.08893,-1.12311;
           -0.06891,-0.84181;
            -0.05849,-0.99401]; %温度影响系数
temp_min_list=fungus_data(:,6);
temp_max_list=fungus_data(:,7);
color_list=['r','b','g'];
figure
hold on
k=3;
xlabel('Temperature/℃')
ylabel('Extention rate/ mm\cdot day^{-1}')
for i=1:k
    G_M_at_tp=GM_at_tp_list(i);
    tp_at_max_GM=tp_at_max_GM_list(i);
    temp_max=temp_max_list(i);
    temp_min=temp_min_list(i);
    name=name_list(i);
    step_1=[0:0.5:50]
    step_2=[0:0.01:50]
    for j=1:size(step_1,2)
        G_at_T(j)=G_T_coff(i)*G_tp(step_1(j),G_M_at_tp,tp_at_max_GM,temp_max,temp_min,temp_coff(i,:),offset_matrix(i));
        if G_at_T(j)<0
            G_at_T(j)=0
        end
    end
    G_at_T_matrix(i,:) = spline(step_1,G_at_T,step_2)
    plot([0:0.01:50],G_at_T_matrix(i,:),color_list(i),'LineWidth',2);
end
legend(name_list(2:k+1),'Location','best')
hold off

%% 生长率和温度湿度的同时影响
temp_coff_mix=1;
humi_coff_mix=1;
step_temp=[0:0.01:50]
step_humi=[0:0.01:5]
figure
hold on
[mesh_x,mesh_y]=meshgrid(step_temp,step_humi);
extention_rate_misHM=zeros(5001,501);
for k=1:3
    
    for i=1:size(step_temp,2)
        for j=1:size(step_humi,2)
            extention_rate_mix(i,j)=G_at_T_matrix(k,i)+G_at_H_matrix(k,j); 
        end
    end
    subplot(1,3,k)
    mesh(mesh_x,mesh_y,extention_rate_mix')
    xlabel('Temperature/℃')
    ylabel('Humidity/Mpa')
    zlabel('Extention rate/ mm\cdot day^{-1}')
    legend(name_list(k+1),'Location','best')
    extention_rate_misHM=extention_rate_misHM+extention_rate_mix;
end
hold off
extention_rate_misHM=extention_rate_misHM./3;
      









    
    
    
    





















