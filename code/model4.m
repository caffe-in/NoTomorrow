
%% 载入数据，构建ranking比较矩阵
[all_num,txt,raw] = xlsread('fungus_data_2.xlsx');
[fungus_data]=xlsread('fungus_data_3.csv');
[rank_list]=xlsread('rank_matrix')
ranking = all_num(:,11);
rank_size = size(ranking);
rank_martirx = [rank_size,rank_size];
for i = 1:rank_size
    for j = 1:rank_size
        rank_matrix(i,j) = (ranking(i)+0.001)/(ranking(j)+0.001);   %smoothing
    end
    for j=1:rank_size
        if rank_matrix(i,j)>10
            rank_matrix(i,j)=10
        end
    end    
end
name_list=txt(:,1)
inital_rate_list=fungus_data(:,4)


%% 竞争模型

opt=odeset('reltol',1e-6,'abstol',1e-9);%相对误差1e-6，绝对误差1e-9
%二元
step=0.1;
ts=[0:step:30]

figure
hold on
specie1_index=8;
specie2_index=9;
inital_num=[10,10];
limit_num=[240,240];
competition_rank_radio_list=[rank_list(specie1_index,specie2_index),rank_list(specie2_index,specie1_index)];
label1_name=name_list(specie1_index+1,1);
label2_name=name_list(specie2_index+1,1);
s12=competition_rank_radio_list(1);
s21=competition_rank_radio_list(2);
r1=inital_rate_list(specie1_index)+G_th*0.001;
r2=inital_rate_list(specie2_index)+G_th*0.001;
n1=limit_num(1)
n2=limit_num(2)
[time,length]=ode45(@model2f1,ts,inital_num,opt,r1,r2,n1,n2,s12,s21)
plot(time,length(:,1),'r',time,length(:,2),'b','LineWidth',2),grid;
xlabel('Time/day');
ylabel('Length/mm');
legend([label1_name,label2_name],'Location','NorthWest')
hold off
slope1=[1,299];
slope2=[1,299];

for i=1:299
    slope1(i)=(length(i+1,1)-length(i,1))/0.1;
    slope2(i)=(length(i+1,2)-length(i,2))/0.1;
end
% 
% temp = input('输入温度，0-50之间：\n');
% humi = input('输入湿度，0-5之间：\n')
% time = [0:0.1:29.8]
% G_th=extention_rate_misHM(temp*100,humi*100);
% G1_time=slope1();
% G2_time=slope2();
% G1=G_th+G1_time;
% G2=G_th+G2_time;
% hold on
% plot(time,G1,'r',time,G2,'b');
% xlabel('time\day')
% ylabel('growrate')
% predict_G1=polyval(polyfit(time,G1,2),time);
% predict_G2=polyval(polyfit(time,G2,2),time);
% plot(time,predict_G1,'r',time,predict_G2,'b');
% legend('speice1','specie2')



%三元

step=0.1;
ts=[0:step:30]

figure
hold on
specie1_index=3;
specie2_index=9;
specie3_index=8;
inital_num=[10,10,10];
limit_num=[240,240,240];
competition_rank_radio_list=[rank_list(specie1_index,specie2_index),rank_list(specie1_index,specie3_index),...
                             rank_list(specie2_index,specie1_index),rank_list(specie2_index,specie2_index),...
                             rank_list(specie3_index,specie1_index),rank_list(specie3_index,specie2_index)];
label1_name=name_list(specie1_index+1,1);
label2_name=name_list(specie2_index+1,1);
label3_name=name_list(specie1_index+1,1);
s12=competition_rank_radio_list(1);
s13=competition_rank_radio_list(2);
s21=competition_rank_radio_list(3);
s23=competition_rank_radio_list(4);
s31=competition_rank_radio_list(5);
s32=competition_rank_radio_list(6);
r1=inital_rate_list(specie1_index)+G_th*0.001;
r2=inital_rate_list(specie2_index)+G_th*0.001;
r3=inital_rate_list(specie3_index)+G_th*0.001;
n1=limit_num(1)
n2=limit_num(2)
n3=limit_num(3)
[time,length]=ode45(@model2f2,ts,inital_num,opt,r1,r2,r3,n1,n2,n3,s12,s13,s21,s23,s31,s32)
plot(time,length(:,1),'r',time,length(:,2),'b',time,length(:,3),'k','LineWidth',2),grid;
xlabel('Time/day');
ylabel('Length/mm');
legend([label1_name,label2_name,label3_name],'Location','NorthWest')
hold off

%四元

step=0.1;
ts=[0:step:30];
tmep=25;
humi=3;
G_th=extention_rate_misHM(temp*100,humi*100);
figure
hold on
specie1_index=3;
specie2_index=8;
specie3_index=9;
specie4_index=29;
inital_num=[10,10,10,10];
limit_num=[240,240,240,240];
competition_rank_radio_list=[rank_list(specie1_index,specie2_index),rank_list(specie1_index,specie3_index),rank_list(specie1_index,specie4_index)...
                             rank_list(specie2_index,specie1_index),rank_list(specie2_index,specie3_index),rank_list(specie2_index,specie4_index)...
                             rank_list(specie3_index,specie1_index),rank_list(specie3_index,specie2_index),rank_list(specie3_index,specie4_index)...
                             rank_list(specie4_index,specie1_index),rank_list(specie4_index,specie2_index),rank_list(specie4_index,specie3_index)];
label1_name=name_list(specie1_index+1,1);
label2_name=name_list(specie2_index+1,1);
label3_name=name_list(specie3_index+1,1);
label4_name=name_list(specie4_index+1,1);
s12=competition_rank_radio_list(1);
s13=competition_rank_radio_list(2);
s14=competition_rank_radio_list(3);
s21=competition_rank_radio_list(4);
s23=competition_rank_radio_list(5);
s24=competition_rank_radio_list(6);
s31=competition_rank_radio_list(7);
s32=competition_rank_radio_list(8);
s34=competition_rank_radio_list(9);
s41=competition_rank_radio_list(10);
s42=competition_rank_radio_list(11);
s43=competition_rank_radio_list(12);
r1=inital_rate_list(specie1_index)+G_th*0.001;
r2=inital_rate_list(specie2_index)+G_th*0.001;
r3=inital_rate_list(specie3_index)+G_th*0.001;
r4=inital_rate_list(specie4_index)+G_th*0.001;
n1=limit_num(1)
n2=limit_num(2)
n3=limit_num(3)
n4=limit_num(4)
[time,length]=ode45(@model2f4,ts,inital_num,opt,r1,r2,r3,r4,n1,n2,n3,n4,s12,s13,s14,s21,s23,s24,s31,s32,s34,s41,s42,s43)
plot(time,length(:,1),'r',time,length(:,2),'b',time,length(:,3),time,length(:,4),'k','LineWidth',2),grid;
xlabel('Time/day');
ylabel('Length/mm');
legend([label1_name,label2_name,label3_name,label4_name],'Location','NorthWest')
hold off












