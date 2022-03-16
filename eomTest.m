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