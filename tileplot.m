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