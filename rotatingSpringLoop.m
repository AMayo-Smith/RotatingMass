close all
clear


a=5;
b=3;


r0=1/2*(a+b); %neutral spring Length
R0=3/4*r0; %Cable Length

ecc=sqrt(1-(b^2/a^2));

dx0=a-r0; %Starting postion relative to the neutral position
dy0=b-r0;


theta0=0;
% k=04;
m=1;
rdot0=0;
tspan=[0,10];

n=10;
periodmatrix=zeros(n,n);
stdvmatrix=zeros(n,n);

kvals=linspace(1,10,n);
thetadot0vals=linspace(1,10,n);
for i=1:n
    for j=1:n
        thetadot0=thetadot0vals(i);
        k=kvals(j);


        z0=[theta0;thetadot0;0;rdot0];
        [t,z]=integrate(z0,tspan,k,r0,m);
        theta_a=z(:,1);
        thetadot_a=z(:,2);
        x=z(:,3);
        r_a=x+r0;
        %r_a=z(:,3);
        rdot_a=z(:,4);



        [pks,locs] = findpeaks(x);
        thetalocs=theta_a(locs)/pi;
        periods=diff(thetalocs);
        periods=periods(1:length(periods)-1);
        avrgperiod=mean(periods);
        stdv=std(periods);
        periodmatrix(i,j)=avrgperiod;
        stdvmatrix(i,j)=stdv;
        
    end
    disp(i);
end 
figure
heatmap(kvals,thetadot0vals,stdvmatrix);
xlabel('K Values');
ylabel('Thetadot0 Values');
title('Period Standard Deviation');
figure
heatmap(kvals,thetadot0vals,periodmatrix);
xlabel('K Values');
ylabel('Thetadot0 Values');
title('(Mean r Period) / pi ');


%animate(r_a,theta_a,t,R0);
%tileplot(r_a,rdot_a,theta_a,thetadot_a,t)
trajectoryplot(r_a,theta_a,t);

figure
hold on
plot(theta_a,r_a);
xq = 0:pi:length(locs)*pi;
vq=interp1(theta_a,r_a,xq);
plot(xq,vq,'o');
xlabel('theta')
ylabel('r')
legend('r values','r values @ theta=pi*n');




%   figure
%   hold on
%   Energy=m/2.*(rdot_a.^2+thetadot_a.^2.*(r_a).^2)+k.*z(:,3).^2/2;
%    plot(t,Energy);
%      plot(t,m/2.*(rdot_a.^2+thetadot_a.^2.*(r_a).^2));
%      plot(t,k.*z(:,3).^2/2)
% 
%   xlabel('time');
%   ylabel('Energy');
%   legend('Total Energy', 'Kinetic Energy', 'Potential Energy');
%  figure
%  angmomentum=m.*thetadot_a.*r_a.^2;
%   
%  plot(t,angmomentum);
% xlabel('time');
%   ylabel('Angular Momentum');
% %plot(t,x);



rcalc=sqrt(b^2./(1-ecc^2.*cos(theta_a).^2));
ratio=abs((r_a./rcalc).^(-1));
   
function [t,z]=integrate(z0,tspan,k,x0,m)

[t,z] = ode113(@eomTest,tspan,z0,...
    odeset('AbsTol',1e-12,'RelTol',1e-9));


function dz=eomTest(~,z)

theta=z(1);
thetadot=z(2);

x=z(3);
xdot=z(4);


xddot=thetadot^2*(x0+x)-k/m*x;
thetaddot=-2*thetadot*xdot/(x0+x);

dz=[thetadot;thetaddot;xdot;xddot];
end

end

