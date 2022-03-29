function T=orbPeriod(alt)
%Calculates the orbital period around earth, given orbital radius in km
a=alt+6378;
mue=3.986004418e5;%mu_earth, km^3/s
T=2*pi*sqrt(a^3/mue);
