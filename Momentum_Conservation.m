clear
close all

%Mission Params

alt=500e3;
mu=3.986004418e14;%mu_earth, m^3/s
r_orbit=alt+6.378e6;
T=2*pi*sqrt(r_orbit^3/mu);
thetadot=2*pi/T; %Orbit Angular Speed, rad/s

%Pitch Shape
a=150;
b=a/5;
ecc=sqrt(1-(b^2/a^2));

%Initial Conditions


phidot0=30*thetadot;
phi0=3.6175;
r0=sqrt(b^2./(1-ecc^2.*cos(phi0-pi/4).^2));




m=100;
n=5000;

% Initialize vectors
t_vector=linspace(0,T,n);
dt=t_vector(2)-t_vector(1);
I0=2*m*r0^2;
H0=I0*phidot0;
phidot=phidot0;

phi=phi0;
phidotlist=zeros(n,1);
philist=zeros(n,1);
rlist=zeros(n,1);
rdotlist=zeros(n,1);
rddotlist=zeros(n,1);

Hlist=zeros(n,1);
phidotlist(1)=phidot;
philist(1)=phi;
rlist(1)=r0;
rdotlist(1)=0;
theta=linspace(0,2*pi*t_vector(end)/T,n);

for i=2:n
    t=t_vector(i);
    phi=phidot*dt+phi;
    r=sqrt(b^2./(1-ecc^2.*cos(phi-pi/4).^2));
    I=2*m*r^2;
    phidot=H0/I;
    rdot=(r-rlist(i-1))/(2*dt);
   

   phidotlist(i)=phidot;
   philist(i)=phi;
   rlist(i)=r;
   rdotlist(i)=rdot;
   Hlist(i)=I*phidot;

   phiNext=phidot*dt+phi;
   rNext=sqrt(b^2./(1-ecc^2.*cos(phiNext-pi/4).^2));
   rddotlist(i)=(rNext-2*r+rlist(i-1))/((dt)^2);
end

% torquelist=[];
% thrustlist=[];


[torquelist, thrustlist]=calculate_gg(rlist,alt,m,philist);


figure
tension1=m.*(rddotlist+phidotlist.^2.*rlist);
plot(t_vector,tension1)
ylabel('Tension, N');
xlabel('Time, s')

 trajectoryplot(rlist,philist,t)
 %tileplot(rlist,rdotlist,philist,phidotlist,t_vector)

 rotations=philist(end)/(2*pi)
 minTension=min(tension1)
% 
% figure
% tiledlayout(3,1);
% nexttile
% plot(t_vector, torquelist(:,3))
% ylabel('gg Torque, Nm');
% nexttile
% plot(t_vector,thrustlist(:,2));
% ylabel('gg Thrust, v direction,N')
% nexttile
% tension=-4*m.*phidotlist.^2.*rlist;
% plot(t_vector,tension)
% ylabel('Tension, N')
% xlabel('time,seconds')

figure
tiledlayout(2,1);
nexttile
plot(philist, torquelist(:,3))
ylabel('gg Torque, Nm');
nexttile
plot(philist,thrustlist(:,2));
ylabel('gg Thrust, v direction,N')
% nexttile
%tension=-4*m.*phidotlist.^2.*rlist;
% plot(philist,tension)
% ylabel('Tension, N')
xlabel('phi, radians')
figure
plot(abs(torquelist(:,3)),thrustlist(:,2))
title('Torque and Thrust')
xlabel('Torque, Nm')
ylabel('Thrust, N')

% % figure
% % plot(t_vector,Hlist);
% % title('angular Momentum Check');
%orb_animate(rlist,philist,t_vector,theta,a*4)
% [I_tetra,I_sph,power_massTh,power_massSp,P_th,P_sp,P_ideal] =  MagneticFieldCalcs(philist',alt,mean(torquelist),theta);