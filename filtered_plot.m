load('data.mat');Fs=1000

%theta oscillations
band=[4 10]
[theta,newfs,N] = datafilter(sig,band(1)-0.5,band(1),band(2),band(2)+0.5,80,1,80,Fs);
%beta oscillations
band=[10 30]
[beta,newfs,N] = datafilter(sig,band(1)-0.5,band(1),band(2),band(2)+0.5,80,1,80,Fs);
%slow gamma oscillations
band=[30 55]
[slowgamma,newfs,N] = datafilter(sig,band(1)-0.5,band(1),band(2),band(2)+0.5,80,1,80,Fs);
%fast gamma oscillations
band=[55 100]
[fastgamma,newfs,N] = datafilter(sig,band(1)-0.5,band(1),band(2),band(2)+0.5,80,1,80,Fs);