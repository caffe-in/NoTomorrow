function dx=model2f1(t,x,r1,r2,n1,n2,s12,s21)
dx=[r1*x(1)*(1-x(1)/n1-s12*x(2)/n2);r2*x(2)*(1-x(2)/n2-s21*x(1)/n1)];

