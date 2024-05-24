function [Ymax, fMax] = FFTmax(data,fs,range,rMean,lenMult)
%%[Ymax, fMax] = FFTmax(data,fs,range,rMean,lenMult)
% function that returns value and frequency of spectrum maximum in a given
% range.
%
% data - input data vector
% fs  - sampling rate
% range - 2 element vector, frequency range in Hz
% lenMult - multiplier for FFT length
%
% v0.1 - Initial Commit

%% input handling

%% remove mean if needed

if rMean
    data = data-mean(data);
end

%% prepare FFT needed data

L = numel(data)*lenMult;
wind = 1;
NFFT = 2^(nextpow2(L));%L;
Frequ = fs/2*linspace(0,1,NFFT/2+1);

Y = fft(data.*wind,NFFT)/L;

Y = 2*Y(1:NFFT/2+1);

Phi = angle(Y);
%Yabs = 20*log10(abs(Y));
Yabs = (abs(Y));

%% find maximum

idxf1 = find(Frequ>=range(1),1,'first');
idxf2 = find(Frequ<=range(2),1,'last');

[Ymax,fMax_idxRaw] = max(Yabs(idxf1:idxf2));

fMax = Frequ(idxf1+fMax_idxRaw-1);


end