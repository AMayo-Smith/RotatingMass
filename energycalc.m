function energy=energycalc(m,k,dx,rdot,thetadot)
PE_Spring=.5*k.*dx.^2;
KE_r=1/2*m.*rdot.^2;
KE_theta=1/2*m.*thetadot.^2;

energy=PE_Spring+KE_r+KE_theta;

end
