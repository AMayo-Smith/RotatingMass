function dz=simEom(z)
a=4.06;
b=1;
R0=3/4*1; %Cable Length
ecc=sqrt(1-(b^2/a^2));
%dy0=b-r0;
k=10;
m=1;
damp=0;
gain=40;
x0=0;
xdot0=0;
theta0=0;
thetadot0=10;
r0=b;
theta=z(1);
thetadot=z(2);

x=z(3);
xdot=z(4);
%ldot=

xddot=thetadot^2*(R0+x)-k/m*x - damp*xdot;
thetaddot=-2*thetadot*xdot/(R0+x);

dz=[thetadot;thetaddot;xdot;xddot];

end
