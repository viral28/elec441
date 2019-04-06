
delay_ss1 = 0.7;
upper_lim = 2.5;
lower_lim = -2.5;

ss12_num = [0.9];
ss12_den = [2.05 1];

g2=  tf(ss12_num,ss12_den);

ss1_num  = 0.1;
ss1_den = [1.8 4.5 1];
g1 = tf(ss1_num,ss1_den);

a = 0.05;
%F = tf(15/2.05, [150 4*sqrt(1/2.05)/3 1/2.05]);
s = tf( [1 0], 1 );
%F = 1/(a*s+1)^2;
F = (1/5)/(3.24*s^2 + 3.6*s + 1);
Q = F *1/g1;
C = Q/(1-Q*g1);

T = g1*C/(1+g1*C);

Suo = C/(1+C*g1);
%bode(Q)