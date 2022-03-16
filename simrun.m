clear 
clc
close all
a_b=10; %shoot for a/b = 10
gainP=50;
gainI=10;
gainD=10;
tfinal=20;
tstepMax=5e-3;
x0=0;
xdot0=0;

theta0=0;
thetadot0=10;

R_0=1;
b=R_0;
a=a_b*b;
k_m=10;
damping=0;
results=sim('controltest.slx');

theta=results.theta;
tvals=results.tout;



%xsignal=ans.getElement('x');
% %openExample('controltest')
% open_system("controltest.slx")
% load_system("controltest.slx")
% 
% simOut = sim('vdp')

