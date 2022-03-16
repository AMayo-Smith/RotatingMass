syms b ecc theta(t) ecc


l=((b^2)/(1-ecc^2*cos(theta)^2))^2;
ldiff=diff(l,t)

(4*b^4*ecc^2*cos(theta))*sin(theta)*thetadot)/(ecc^2*cos(theta(t))^2 - 1)^3