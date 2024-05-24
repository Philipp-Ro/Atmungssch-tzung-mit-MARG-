function [frames,rates] = respFreq(data,fs,method,varargin)
% 
% This function extracts the respiratory rate from a signal.
%
%
% data - input vector
% fs - sampling rate
% method - method in use
%    'fft' - maximum of range, default is [6 36] bpm
%
%
% optional input:
%
% 'frames',len,over - extract rate in frames of length "len" and overlap "over"
%       len - length of frame in seconds
%       over - overlap of frames in percent
%
%
% outputs:
%
% frames - vector start sample of frame
% rates - vector of estimated frequencies in frames

%% input handling
% init len and over
len = -1;
over = -1;

range = [3 44];

if nargin > 3
    if any(strcmpi(varargin,'frames'))
        pos = find(strcmpi(varargin,'frames'));
        len = varargin{pos+1}*fs;
        over = round(len*varargin{pos+2}/100);
        
        if len > numel(data)
            len=-1;
            over=-1;
            warning('Frame length is longer than input. Using whole signal without framing.')
        end
        
    else
       error('Might be unrecognized arguments');
    end
        
    
end

%% param

lenMult = 200;


%% calc FFT based

if strcmpi(method,'fft')

    if len < 0 %no frame defined, use full signal
        [~,rates] = FFTmax(data,fs,range/60,1,lenMult);    
        frames(1) = 1;
        frames(2) = numel(data);
        
    else
        [s,f,t] = spectrogram(data,hanning(len),over,len*lenMult,fs);
        
        frames = t*fs-len/2+1;
        
        sAbs = abs(s);
        
        fStartIdx = find(f>=range(1)/60,1,'first');
        fStopIdx = find(f<=range(2)/60,1,'last');
        
        [~, maxIdx] = max(sAbs(fStartIdx:fStopIdx,:));
        
        rates = f(fStartIdx+maxIdx-1);

    end

end


end