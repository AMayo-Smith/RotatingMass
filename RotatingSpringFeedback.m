close all
clear


a=4.06;
b=1;
%R0=3/4*1; %Cable Length
ecc=sqrt(1-(b^2/a^2));
%dy0=b-r0;
k=10;
m=1;
damp=0;
gain=5;
x0=0;
xdot0=0;
theta0=0;
thetadot0=10;
r0=b;
tspan=[0,50];
        z0=[theta0;thetadot0;x0;xdot0];
        [t,z]=integrate(z0,tspan,k,r0,m,damp,gain,ecc);
        theta_a=z(:,1);
        thetadot_a=z(:,2);
        x=z(:,3);
        r_a=x+r0;
        %r_a=z(:,3);
        rdot_a=z(:,4);

%animate(r_a,theta_a,t,r0);
%tileplot(r_a,rdot_a,theta_a,thetadot_a,t)
trajectoryplot(r_a,theta_a,t);
figure
hold on
xq = 0:pi:4*pi;
vq=interp1(theta_a,r_a,xq);
plot(theta_a,r_a);
plot(xq,vq,'o');
xlabel('theta')
ylabel('r_a');


l=sqrt(b^2./(1-ecc^2.*sin(theta_a).^2));
plot(theta_a,l);

title('Changes in Radius with respect to theta');
legend('r values','r values @ theta=pi*n','ellipse');

hold off
figure
err=(l-r_a);
plot(theta_a,err)


rcalc=sqrt(b^2./(1-ecc^2.*cos(theta_a).^2));
ratio=abs((r_a./rcalc).^(-1));
   
function [t,z]=integrate(z0,tspan,k,R0,m,damp,gain,ecc)

[t,z] = ode113(@eomTest,tspan,z0,...
    odeset('AbsTol',1e-12,'RelTol',1e-9));


function dz=eomTest(~,z)

theta=z(1);
thetadot=z(2);

x=z(3);
xdot=z(4);
b=R0;
l=sqrt(b^2./(1-ecc^2.*sin(theta).^2));
%ldot=
err=l-x;

xddot=thetadot^2*(R0+x)-k/m*x - damp*xdot+gain*err;
thetaddot=-2*thetadot*xdot/(R0+x);

dz=[thetadot;thetaddot;xdot;xddot];
end

end




