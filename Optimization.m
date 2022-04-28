clear 
clc
close all


%% User Inputs

%Geometry
a_b=10;         %shoot for a/b = 10
R_0=2e3;          %Undeformed Length, m
b=R_0;
b=90; %Energy Check Value
a=a_b*b;        %20e3 m
a=300; %Energy Check Value
alt=500; %orbital altitude, km
T=orbPeriod(alt); %orbital period, seconds
rate_pre=2*pi/T;
rate_pre=0; %Energy Check Value

%Configure Integrator
tfinal=T/4; %seconds

tStepMin=tfinal*10^(-6);
tstepMax=tfinal*10^(-2);



%Initial Conditions
x0=0;           %Initial displacement from neutral spring, km
xdot0=0;        %m/s
theta0=0;       %rad
thetadot0=200*rate_pre;   %rad/s
thetadot0=0.012301296218008;
%system properties
m=100; %kg
damping=0;


%% Loop Setup
krun=1;
crun=1;
dataMatrix=[];
kvals=linspace(1,10,krun);
PIDvals=linspace(0.5,2,crun);
powermatrix=zeros(crun,krun);
errormatrix=zeros(crun,krun);

%% Loop
tic
% for ik=1:krun
%     k=kvals(ik);
%     k_m=k/m;
k=0;
k_m=k/m;

    for ic=1:crun
        disp(ic)
%         gainP=PIDvals(ic);
%         gainI=PIDvals(ic);
%         gainD=PIDvals(ic);
        gainP=10;
        gainI=10;
        gainD=10;
        results=sim('controltest.slx');
       
        
        theta=results.theta;
        thetadot=results.thetadot;
        %thetaddot=results.thetaddot;
        
        dx=results.dx;
        r=dx+R_0;
        rdot=results.xdot;
        %rddot=results.xddot;
        
        a_control=results.control;
        t=results.tout;
        desired=results.desired;
        err=results.err;
    
    
        power=abs(a_control.*rdot);
       % avrgpower=1/max(t)*trapz(t,power);
        avrgpower=mean(power);
        %plot(power)
        err_ratio=err./desired;
        [errmax, errmean]=error_ss(t, err_ratio);
        if errmean >= 0.05
            avrgpower=NaN;
        end
%         powermatrix(ic,ik)=avrgpower;
%         errormatrix(ic,ik)=errmean;
    end
% end
toc
%% Results
% heatmap(kvals,PIDvals,powermatrix);
% xlabel('k Values');
% ylabel('PID Values');

% heatmap(kvals,PIDvals,errormatrix);
% xlabel('k Values');
% ylabel('PID Values');


% for ik=1:irun
%     k=1300+ik*400/irun;
%     k_m=k/m;
%     disp(ik)
%     for iP=1:irun
%         gainP= 50*iP;
%         
%         for iI=1:irun
%             gainI= 50*iI;
%             for iD= 1:irun
%                 gainD=50*iD;
%             
%                 results=sim('controltest.slx');
%                
%                 
%                 %theta=results.theta;
%                 thetadot=results.thetadot;
%                 %thetaddot=results.thetaddot;
%                 
%                 dx=results.dx;
%                 r=dx+R_0;
%                 rdot=results.xdot;
%                 %rddot=results.xddot;
%                 
%                 a_control=results.control;
%                 t=results.tout;
%                 desired=results.desired;
%                 err=results.err;
% 
% 
%                 power=abs(a_control.*rdot);
%                 avrgpower=1/max(t)*trapz(t,power);
%                 %plot(power)
%                 err_ratio=err./desired;
%                 [errmax, errmean]=error_ss(t, err_ratio);
%                 if errmax <= 0.05
%                     tempmatrix=[k,gainP,gainI,gainD,errmax,avrgpower];
%                     dataMatrix=[dataMatrix;tempmatrix];
%                 end
%                
%             end
%         end
%     end
% end







% plot(t,error,t,err);
% legend('matlab','simulink');
% figure
% plot(lateErr);
%animate(r,theta,t,R_0);
 %tileplot(r,rdot,theta,thetadot,t);
 trajectoryplot(r,theta,t);

 %% Peck Spreadsheet Confirmation
angmomentum=m.*r.*thetadot;
tension=m.*thetadot.^2.*r;
power=rdot.*tension;
figure
plot(theta,angmomentum)
title('angular momentum')
figure
plot(theta,power)
title('power')

