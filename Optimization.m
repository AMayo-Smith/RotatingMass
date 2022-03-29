clear 
clc
close all


%% User Inputs

% Configure Gain
% k=1500; %N/km
% gainP=0;
% gainI=0;
% gainD=0;

%% Given Inputs

%Configure Integrator
tstepMax=5e-3;
tfinal=90;



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
m=100; %kg
damping=0;



irun=5;
runs=irun^4;
dataMatrix=[];
kvals=linspace(1800,1900,irun);
PIDvals=linspace(50,1000,irun);
powermatrix=zeros(irun,irun);
errormatrix=zeros(irun,irun);

for ik=1:irun
    k=kvals(ik);
    k_m=k/m;
    for ic=1:irun
        disp(ic)
        gainP=PIDvals(ic);
        gainI=PIDvals(ic);
        gainD=PIDvals(ic);
        results=sim('controltest.slx');
       
        
        %theta=results.theta;
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
        avrgpower=1/max(t)*trapz(t,power);
        %plot(power)
        err_ratio=err./desired;
        [errmax, errmean]=error_ss(t, err_ratio);
        if errmean >= 0.05
            avrgpower=NaN;
        end
        powermatrix(ic,ik)=avrgpower;
        errormatrix(ic,ik)=errmean;
    end
end

heatmap(kvals,PIDvals,powermatrix);
xlabel('k Values');
ylabel('PID Values');

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
% trajectoryplot(r,theta,t);
