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
title('X  Y')

legend('mass A','mass B');



end
