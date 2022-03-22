clear 
clc
close all

gainP=10;
gainI=10;
gainD=10;
tfinal=50;
rate_pre=0.1;

a_b=10; %shoot for a/b = 10
R_0=1;
b=R_0;
a=a_b*b;

tstepMax=5e-3;
x0=0;
xdot0=0;

theta0=0;
thetadot0=40;

k_m=8;
damping=0;
results=sim('controltest.slx');

theta=results.theta;
thetadot=results.thetadot;
thetaddot=results.thetaddot;

dx=results.dx;
rdot=results.xdot;
rddot=results.xddot;


desired=results.desired;
t=results.tout;
matsize=length(t);
benchmark=floor(0.9*matsize);


err=results.err;
control=results.control;
spr=k_m*dx;
figure
plot(t,control,t,spr)
legend('control','spring')
%look at power
lateErr=err(benchmark:matsize);
ssMax=max(lateErr)
ssMin=min(lateErr)
p2p=max(lateErr)-min(lateErr)
errmean=mean(abs(lateErr))
r=dx+R_0;

y=((a*b)./(sqrt(b^2.*sin(theta).^2 + a^2.*cos(theta).^2)));
error=y-r;
% figure
% plot(t,error,t,err);
% legend('matlab','simulink');
% figure
% plot(lateErr);
% animate(r,theta,t,R_0);
% tileplot(r,rdot,theta,thetadot,t);
trajectoryplot(r,theta,t);
