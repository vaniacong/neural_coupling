%load multiple channels data, e.g.: channel 1 is recording from the
%medial prefrontal cortex (mPFC) and stored in row 1, channel 2 is 
%recording from the hippocampus (HPC)and stored in row 2.

load('data_multiplechannels.mat');Fs=1000
sig1=sig(1,:) %load row1 which is the mPFC recording
sig2=sig(2,:) %load row2 which is the HPC recording

%Filter out the theta oscillations
band=[4 10]
[theta1,newfs,N] = datafilter(sig1,band(1)-0.5,band(1),band(2),band(2)+0.5,80,1,80,Fs);
[theta2,newfs,N] = datafilter(sig2,band(1)-0.5,band(1),band(2),band(2)+0.5,80,1,80,Fs);

[sumcorr,l] = xcorr(sig1,sig2,ceil(newfs/2),'coeff');  %calculate correlation  

%Plot the corss-correlation curve
plot(l,sumcorr,'c','Linewidth',2)

%Calculate the peak corss-correlation coefficient
[mValue,mIndex]=max(sumcorr)
lag=l(mIndex)/(newfs)*1000 % convert second into microsecond

fid=fopen(['HPC-mPFC xcorr.txt'],'wt')
fprintf(fid,'The xcorr-coeffienct PFC&HPC is %.2f. Lag is %.1f ms \n',mValue,lag);
fclose(fid)    
X=sprintf('The xcorr-coeffienct PFC&HPC is %.2f. Lag is %.1f ms \n',mValue,lag)
