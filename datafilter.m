function [sig_filt,newfs,N] = datafilter(sig,fst1,fp1,fp2,fst2,ast1,ap,ast2,fs)
% Check
if fp1-fst1 ~= fst2-fp2
    warning('Upper and lower pass-stop transitions are not equal length - may give unexpected results'); end
% Downsample the signal if possible (dramatically speeds up filter design)
newfs = fs;
while fst2*8 < newfs; sig = downsample(sig,2); newfs = newfs/2;
end

% Create filter name
savnam = sprintf('filterspecs%s%s_%g_%g_%g_%g_%g_%g_%g_%g.mat',filesep(),mfilename(),fst1,fp1,fp2,fst2,ast1,ap,ast2,newfs);
if exist(savnam,'file')
    % Load filter if we have a saved version
    load(savnam);
    disp('  - Filter loaded from disk');
else
    % Get filter params and design it
    fd = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',fst1,fp1,fp2,fst2,ast1,ap,ast2,newfs);
    hd = design(fd);
    disp(['  - Filter design time ' num2str(toc) ' sec']);
    % fiter visualisation
    %fvtool(hd);
  
    % Save it for use next time
    save(savnam,'fd','hd');
end
% Filter the signal and adjust for sample offset effect
N = length(hd.Numerator);   % filter order
disp(['  - Filter order is ' num2str(N)]);
sig_filt = filter(hd.Numerator,1,sig);
sig_filt =detrend(sig_filt)

if size(sig_filt,1) == 1
   sig_filt = [sig_filt(round(N/2)+1:end), zeros(1,round(N/2))];
else
   sig_filt = [sig_filt(round(N/2)+1:end); zeros(round(N/2),1)];
end
