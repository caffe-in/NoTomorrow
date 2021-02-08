%% 载入数据，构建ranking比较矩阵
all_num = xlsread('fungus_data_2.xlsx');
ranking = all_num(:,11);
disp(ranking);
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
disp(rank_matrix);
  



%% 竞争模型

% 二元
figure
subplot(1,2,1)
h=0.1;%所取时间点间隔
ts=[0:h:30];%时间区间
x0=[10,10];%初始条件
opt=odeset('reltol',1e-6,'abstol',1e-9);%相对误差1e-6，绝对误差1e-9
r1=0.25;
r2=0.35;
n1=500;
n2=500;
s12=1.4142;
s21=0.7071;
label1_name = 'Armillaria gallica FP102531 C6D'
label2_name = 'Armillaria gallica EL8 A6F'
[t,x]=ode45(@model2f1,ts,x0,opt,r1,r2,n1,n2,s12,s21);%使用5级4阶龙格—库塔公式计算
plot(t,x(:,1),'r',t,x(:,2),'b','LineWidth',2),grid;
xlabel('Time/day');
ylabel('Length/mm');
legend(label1_name,label2_name,'Location','NorthWest')
subplot(1,2,2)
slope1=[1,299];
slope2=[1,299];

for i=1:299
    slope1(i)=(x(i+1,1)-x(i,1))/0.1;
    slope2(i)=(x(i+1,2)-x(i,2))/0.1;
end
plot(t(1:299),slope1,'r',t(1:299),slope2,'b','LineWidth',2),grid;
legend(label1_name,label2_name,'Location','NorthEast');
xlabel('Time/day');
ylabel('Extention Rate/mm\cdot day^{-1}');

x0=[10,0]
slope11=[1,299];
slope12=[1,299];
[t,x]=ode45(@model2f1,ts,x0,opt,r1,r2,n1,n2,s12,s21);%使用5级4阶龙格—库塔公式计算
for i=1:299
    slope11(i)=(x(i+1,1)-x(i,1))/0.1;
    slope12(i)=(x(i+1,2)-x(i,2))/0.1;
end

x0=[0,10]
slope13=[1,299];
slope14=[1,299];
[t,x]=ode45(@model2f1,ts,x0,opt,r1,r2,n1,n2,s12,s21);%使用5级4阶龙格—库塔公式计算
for i=1:299
    slope13(i)=(x(i+1,1)-x(i,1))/0.1;
    slope14(i)=(x(i+1,2)-x(i,2))/0.1;
end

% 种间竞争
ts=[0:h:10];%时间区间
figure
subplot(1,2,1)
x0=[10,10]
r1=4.71;
r2=1.96;
n1=30;
n2=30;
s12=0.5008;
s21=1.996;
label1_name = 'Fomes fomentarius TJV93 7 A3E'
label2_name = 'Hyphodontia crustosa HHB13392 B7B'
[t,x]=ode45(@model2f1,ts,x0,opt,r1,r2,n1,n2,s12,s21);%使用5级4阶龙格—库塔公式计算
plot(t,x(:,1),'r',t,x(:,2),'b','LineWidth',2),grid;
xlabel('Time/day');
ylabel('Length/mm');
legend(label1_name,label2_name,'Location','NorthWest')
subplot(1,2,2)
slope3=[1,99];
slope4=[1,99];
for i=1:99
    slope3(i)=(x(i+1,1)-x(i,1))/0.1;
    slope4(i)=(x(i+1,2)-x(i,2))/0.1;
end
plot(t(1:99),slope3,'r',t(1:99),slope4,'b','LineWidth',2),grid;
legend(label1_name,label2_name,'Location','NorthEast');
xlabel('Time/day');
ylabel('Extention Rate/mm\cdot day^{-1}');
x0=[10,0]
slope15=[1,99];
slope16=[1,99];
[t,x]=ode45(@model2f1,ts,x0,opt,r1,r2,n1,n2,s12,s21);%使用5级4阶龙格—库塔公式计算
for i=1:99
    slope15(i)=(x(i+1,1)-x(i,1))/0.1;
    slope16(i)=(x(i+1,2)-x(i,2))/0.1;
end

x0=[0,10]
slope17=[1,99];
slope18=[1,99];
[t,x]=ode45(@model2f1,ts,x0,opt,r1,r2,n1,n2,s12,s21);%使用5级4阶龙格—库塔公式计算
for i=1:99
    slope17(i)=(x(i+1,1)-x(i,1))/0.1;
    slope18(i)=(x(i+1,2)-x(i,2))/0.1;
end

% 三元
figure
subplot(1,2,1)
h=0.1;%所取时间点间隔
ts=[0:h:30];%时间区间
x0=[10,10,10];%初始条件
opt=odeset('reltol',1e-6,'abstol',1e-9);%相对误差1e-6，绝对误差1e-9
r1=0.25;
r2=0.35;
r3=0.21;
n1=500;
n2=500;
n3=500;
s12=1.411;
s13=1
s21=0.7083;
s23=0.7083;
s31=1;
s32=1.411;
label1_name = 'Armillaria gallica FP102531 C6D'
label2_name = 'Armillaria gallica EL8 A6F'
label3_name = 'Armillaria gallica FP102534 A5A'
[t,x]=ode45(@model2f2,ts,x0,opt,r1,r2,r3,n1,n2,n3,s12,s13,s21,s23,s31,s32);%使用5级4阶龙格—库塔公式计算
plot(t,x(:,1),'r',t,x(:,2),'b',t,x(:,3),'k','LineWidth',2),grid;
xlabel('Time/day');
ylabel('Length/mm');
legend(label1_name,label2_name,label3_name,'Location','NorthWest')
subplot(1,2,2)
slope5=[1,299];
slope6=[1,299];
slope7=[1,299];
for i=1:299
    slope5(i)=(x(i+1,1)-x(i,1))/0.1;
    slope6(i)=(x(i+1,2)-x(i,2))/0.1;
    slope7(i)=(x(i+1,3)-x(i,3))/0.1;
end
plot(t(1:299),slope5,'r',t(1:299),slope6,'b',t(1:299),slope7,'k','LineWidth',2),grid;
legend(label1_name,label2_name,label3_name,'Location','NorthEast');
xlabel('Time/day');
ylabel('Extention Rate/mm\cdot day^{-1}');

ts=[0:h:10];%时间区间
figure
subplot(1,2,1)
r1=4.71;
r2=1.96;
r3=1.07;
n1=500;
n2=500;
n3=500;
s12=0.5008;
s13=10;
s21=1.996;
s23=10;
s31=0.0017;
s32=0.0035
label1_name = 'Fomes fomentarius TJV93 7 A3E'
label2_name = 'Hyphodontia crustosa HHB13392 B7B'
label3_name = 'Armillaria tabescens TJV93 261 A1E'
[t,x]=ode45(@model2f2,ts,x0,opt,r1,r2,r3,n1,n2,n3,s12,s13,s21,s23,s31,s32);%使用5级4阶龙格—库塔公式计算
plot(t,x(:,1),'r',t,x(:,2),'b',t,x(:,3),'k','LineWidth',2),grid;
xlabel('Time/day');
ylabel('Length/mm');
legend(label1_name,label2_name,label3_name,'Location','NorthWest')
subplot(1,2,2)
slope8=[1,99];
slope9=[1,99];
slope10=[1,99];
for i=1:99
    slope8(i)=(x(i+1,1)-x(i,1))/0.1;
    slope9(i)=(x(i+1,2)-x(i,2))/0.1;
    slope10(i)=(x(i+1,3)-x(i,3))/0.1;
end
plot(t(1:99),slope8,'r',t(1:99),slope9,'b',t(1:99),slope10,'k','LineWidth',2),grid;
legend(label1_name,label2_name,label3_name,'Location','NorthEast');
xlabel('Time/day');
ylabel('Extention Rate/mm\cdot day^{-1}');

