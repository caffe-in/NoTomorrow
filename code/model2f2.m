function dx=model2f2(t,x,r1,r2,r3,n1,n2,n3,s12,s13,s21,s23,s31,s32)
dx=[r1*x(1)*(1-x(1)/n1-s12*x(2)/n2-s13*x(3)/n3);r2*x(2)*(1-x(2)/n2-s21*x(1)/n1-s23*x(3)/n3);r3*x(3)*(1-x(3)/n3-s31*x(1)/n1-s32*x(2)/n2)];

