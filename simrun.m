clear 
clc
close all

% Configure Gain
gainP=100;
gainI=10;
gainD=10;

%Configure Integrator
tstepMax=5e-3;
tfinal=100;



%Geometry
a_b=10;         %shoot for a/b = 10
R_0=2;          %Undeformed Length, km
b=R_0;
a=a_b*b;        %20 km
alt=500; %orbital altitude, km
T=orbPeriod(alt); %orbital period, seconds
rate_pre=2*pi/T;

%Initial Conditions
x0=0;           %Initial displacement from neutral spring, km
xdot0=0;        %km/s
theta0=0;       %rad
thetadot0=40;   %rad/s

%system properties
k=800; %N/m
m=100; %kg
k_m=k/m;
damping=0;


%
tic
results=sim('controltest.slx');
toc

theta=results.theta;
thetadot=results.thetadot;
thetaddot=results.thetaddot;

dx=results.dx;
r=dx+R_0;
rdot=results.xdot;
rddot=results.xddot;


t=results.tout;
desired=results.desired;
err=results.err;

%Estimate Error
ssCut=0.9; %Cutoff to consider steady state
err_ratio=err./desired;
matsize=length(t);
benchmark=floor(ssCut*matsize);
lateErr=err_ratio(benchmark:matsize);
plot(lateErr);

errmean=mean(abs(lateErr))

[p,nr] = seqperiod(lateErr,0.1)









% control=results.control;
% spr=k_m*dx;
% figure
% plot(t,control,t,spr)
% legend('control','spring')
% %look at power
% lateErr=err(benchmark:matsize);
% ssMax=max(lateErr)
% ssMin=min(lateErr)
% p2p=max(lateErr)-min(lateErr)
% errmean=mean(abs(lateErr))
% r=dx+R_0;
% 
% y=((a*b)./(sqrt(b^2.*sin(theta).^2 + a^2.*cos(theta).^2)));
% error=y-r;
% figure
% plot(t,error,t,err);
% legend('matlab','simulink');
% figure
% plot(lateErr);
%animate(r,theta,t,R_0);
 %tileplot(r,rdot,theta,thetadot,t);
%trajectoryplot(r,theta,t);
