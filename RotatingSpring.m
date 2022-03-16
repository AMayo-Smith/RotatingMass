close all
clear


a=5;
b=3;


%r0=1/2*(a+b); %neutral spring Length
R0=3/4*1; %Cable Length



ecc=sqrt(1-(b^2/a^2));

%dy0=b-r0;


k=10;
m=1;
x0=0
xdot0=0
theta0=0
thetadot0=10
r0=1
tspan=[0,10];

% 
% numerator=(-k/m*(a-r0));
% denominator=-((b*ecc^2)/((1-ecc^2)^(3/2)))-a;
% thetadot0=sqrt(k*dx0/(m*a));

        z0=[theta0;thetadot0;x0;xdot0];
        [t,z]=integrate(z0,tspan,k,r0,m);
        theta_a=z(:,1);
        thetadot_a=z(:,2);
        x=z(:,3);
        r_a=x+r0;
        %r_a=z(:,3);
        rdot_a=z(:,4);

animate(r_a,theta_a,t,R0);
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
title('Changes in Radius with respect to time');
legend('r values','r values @ theta=pi*n');
hold off

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
%   title('Energy Over Time');
%  figure
%  angmomentum=m.*thetadot_a.*r_a.^2;
%   
%  plot(t,angmomentum);
% xlabel('time');
%   ylabel('Angular Momentum');
%   title('Angular Momentum over Time');
% %plot(t,x);



rcalc=sqrt(b^2./(1-ecc^2.*cos(theta_a).^2));
ratio=abs((r_a./rcalc).^(-1));
   
function [t,z]=integrate(z0,tspan,k,R0,m)

[t,z] = ode113(@eomTest,tspan,z0,...
    odeset('AbsTol',1e-12,'RelTol',1e-9));


function dz=eomTest(~,z)

theta=z(1);
thetadot=z(2);

x=z(3);
xdot=z(4);


xddot=thetadot^2*(R0+x)-k/m*x;
thetaddot=-2*thetadot*xdot/(R0+x);

dz=[thetadot;thetaddot;xdot;xddot];
end

end

function animate(r_a,theta_a,t,R0)
    theta_b=theta_a+pi;
    x_a = r_a.*cos(theta_a);
    y_a = r_a.*sin(theta_a);
    
    X0_A=R0*cos(theta_a);
    Y0_A=R0*sin(theta_a);
    
    
    
    x_b=r_a.*cos(theta_b);
    y_b=r_a.*sin(theta_b);
    
    X0_B=R0*cos(theta_b);
    Y0_B=R0*sin(theta_b);

    hold on
    plot(0,0,'o');
    h = animatedline("LineStyle","-.");
    f = animatedline("LineStyle",":");

    axis([-5,5,-5,5])
    axis equal




    a=plot(x_a(1),y_a(1), 'b.', 'MarkerSize', 30);    
    b=plot(x_b(1),y_b(1), 'r.', 'MarkerSize', 30);
    
    cablea=plot([0,X0_A(1)],[0,Y0_A(1)],'k-');
    cableb=plot([0,X0_B(1)],[0,Y0_B(1)],'k-');
    
    springa=plot([X0_A(1),x_a(1)],[Y0_A(1),y_a(1)],'b');
    springb=plot([X0_B(1),x_b(1)],[Y0_B(1),y_b(1)],'r');
    for k = 1:length(t)


        set (a, 'XData',x_a(k), 'YData', y_a(k))
        set (b, 'XData',x_b(k), 'YData', y_b(k))
        
        set(springa,'XData',[X0_A(k),x_a(k)], 'YData', [Y0_A(k),y_a(k)])
        set(springb,'XData',[X0_B(k),x_b(k)], 'YData', [Y0_B(k),y_b(k)])

        
        set (cablea, 'XData',[0,X0_A(k)], 'YData', [0,Y0_A(k)])
        set (cableb, 'XData',[0,X0_B(k)], 'YData', [0,Y0_B(k)])
        
        
        drawnow;
         addpoints(h,x_a(k),y_a(k));
         addpoints(f,x_b(k),y_b(k));

        hold off
        drawnow
    end
    hold off


end

function tileplot(r,rdot,theta,thetadot,t)
figure
tiledlayout(4,1)


nexttile
plot(t,r)
xlabel('time')
ylabel('r')
title('r, rdot, theta & thetadot wrt time')

nexttile
plot(t,rdot)
xlabel('time')
ylabel('rdot')

nexttile
plot(t,mod(theta,2*pi))
xlabel('time')
ylabel('theta')

nexttile
plot(t,thetadot)
xlabel('time')
ylabel('thetadot')

figure
tiledlayout(3,1)
nexttile
plot(r,rdot)
xlabel('r')
ylabel('rdot')
title('rdot, theta & thetadot wrt r')

nexttile
plot(r,theta)
xlabel('r')
ylabel('theta')

nexttile
plot(r,thetadot)
xlabel('r')
ylabel('thetadot')

figure
tiledlayout(3,1)

nexttile
plot(theta,r)
xlabel('theta')
ylabel('r')

nexttile
plot(theta,rdot)
xlabel('theta')
ylabel('rdot')
title('r, rdot & thetadot wrt theta')

nexttile
plot(r,thetadot)
xlabel('r')
ylabel('thetadot')


end

function trajectoryplot(r_a,theta_a,t)
theta_b=theta_a+pi;
x_a = r_a.*cos(theta_a);
y_a = r_a.*sin(theta_a);

xave_a=mean(x_a);
yave_a=mean(y_a);

x_b=r_a.*cos(theta_b);
y_b=r_a.*sin(theta_b);

xave_b=mean(x_b);
yave_b=mean(y_b);

figure
axis equal
hold on 
plot(x_a,y_a,'-.');
plot(x_b,y_b,':');
% plot(xave_a,yave_a,'o');
% plot(xave_b,yave_b,'o');

hold off
xlabel('X coordinate');
ylabel('Y Coordinate');
% titletext=['K=', k,  'r0=', r0];
% title(titletext);
title('Trajectory Plot')

legend('mass A','mass B');



end



