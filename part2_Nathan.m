%% current


clear;

ss1_num  = 1;
ss1_den = [1.8 4.5 1];
ss12_num = [0.9];
ss12_den = [2.05 1];

g2=  tf(ss12_num,ss12_den);


c11_num = [90 225 50];
c11_den = [1 19 0];

%c11_num = [1346.9444 5680.556 9000];
%c11_den = [1 21.5 0];

delay_ss1 = 0.7;
upper_lim = 2.5;
lower_lim = -2.5;

c1 = tf(c11_num,c11_den);
g1 = tf(ss1_num,ss1_den);

c1g1 = c1*g1;

s = tf('s');
temp =1-exp(s*-0.7);

%% temp

s = tf('s');
temp =1-exp(s*-0.7);
c_smith = c1/(1+c1*g1*(1-exp(s*-0.7)));
c_smithtf = ss2tf(c_smith.A,c_smith.B,c_smith.C,c_smith.D);

%% PID
kp = 41.5716;
tr = 1.55;
td = 0.3867;
        
pid = kp*(1+1/(s*td) + s*td/(td*s+1));
pidnum = [ 6.216 16.08 41.57];
pidden = [0.3867 0];
%% Q design

wn_sq = 0.5; 
k=0.1; %gain on filter to increase controller gain
%a = 0.2;
Z = 0.65;
p=1;
ss1_num  = 0.1;
ss1_den = [1.8 4.5 1];
g1 = tf(ss1_num,ss1_den);
%F = tf(wn_sq,[1 2*Z*sqrt(wn_sq)+p  2*Z*sqrt(wn_sq)*p + wn_sq p*wn_sq])
F = tf(k*wn_sq,[1 2*Z*sqrt(wn_sq) wn_sq])
%F = tf(k*wn^2,[1 1.4*wn wn^2]); %zeta = 0.7 for fast rise and settling
%Q = tf(wn^2*[1.8 4.5 1], [1 0.14*wn wn^2])
Q = F*1/g1

C = Q/(1-Q*g1)

T = g1*C/(1+g1*C)

os = exp((-Z*pi)/(sqrt(1-Z^2)))

% Suo = Q;
% Sio = (1-Q*g1)*g1;
% So = 1-Q*g1;
% To = Q*g1;
bode(Q)
%roots([0.01152 0.0288 0.0064]);
%roots([0.18 0.6516 0.7192 0.4 0.064]);




%bode(Q);

%bode(C)

% bode(Q);
% 
% roots([1.8 4.5 1]);






