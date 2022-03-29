function [errmax, errmean]=error_ss(t, err_ratio)
ssCut=0.9; %Cutoff to consider steady state

matsize=length(t);
benchmark=floor(ssCut*matsize);
lateErr=err_ratio(benchmark:matsize);
lateT=t(benchmark:matsize);
%plot(lateT,lateErr);
errmean=mean(abs(lateErr));
%errmean2=1/(t(matsize)-t(benchmark))*trapz(lateT,abs(lateErr))
errmax=max(abs(lateErr));
[p,nr] = seqperiod(lateErr,0.1);



end
