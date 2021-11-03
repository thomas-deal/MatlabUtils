function [t, f, S, ENBW] = ComputeTwoSidedSpectrogram(Fs,s,varargin)
%% function [t, f, S, ENBW] = ComputeTwoSidedSpectrogram(Fs,s)
% function [t, f, S, ENBW] = ComputeTwoSidedSpectrogram(Fs,s,<name>,<value>)
%
% Calculates spectrogram from timeseries signal. Data is framed, windowed,
% transformed, and scaled to produce a two-sided complex spectrum. 
% Output is normalized and scaled for the requested frequency domain units.
%
% Optional parameters are input as <name>,<value> pairs. Valid output types
% are linear spectrum (LS), linear spectral density (LSD), power spectrum 
% (PS), and power spectral density (PSD). Default values for optional 
% parameters are listed in < > below.
%
% Inputs:
%       Fs          - Sampling frequency, Hz
%       s           - Signal timeseries
%
% Optional Parameters:
%       NFFT        - FFT size <Fs>
%       FrameSize   - Number of samples per frame <Fs>
%       Overlap     - Percent overlap of adjacent frames [0,1) <0.5>
%       Window      - User-defined window vector of length FrameSize or
%                     function handle to valid window function generator
%                     <@hann(FrameSize,'periodic')>
%       Type        - 'LS', 'LSD', 'PS', 'PSD' <'LS'>
%
% Outputs:
%       t           - Time, seconds
%       f           - Frequency, Hz
%       S           - Signal spectrogram
%       ENBW        - Effective Noise BandWidth is am amplitude conversion
%                     factor between spectra and spectral densities that 
%                     depends on the sample rate and window function:
%                       LS = sqrt(ENBW)*LSD
%                       PS = ENBW*PSD = ENBW*|LSD|^2
%

%% Check Inputs
% Create parser
par = inputParser;
% NFFT
defaultNFFT = Fs;
checkNFFT = @(x) isnumeric(x) && isscalar(x) && (x > 0);
% FrameSize
defaultFrameSize = Fs;
checkFrameSize = @(x) isnumeric(x) && isscalar(x) && (x > 0);
% Overlap
defaultOverlap = 0.5;
checkOverlap = @(x) isnumeric(x) && isscalar(x) && (x >= 0) && (x < 1);
% Window
defaultWindow = @hann;
checkWindow = @(x) isnumeric(x) || isa(x,'function_handle');
% Type
defaultType = 'LS';
validTypes = {'LS','LSD','PS','PSD'};
checkType = @(x) any(validatestring(x,validTypes));
% Add inputs to parser
addRequired(par,'Fs',@isnumeric);
addRequired(par,'s',@isnumeric);
addParameter(par,'NFFT',defaultNFFT,checkNFFT);
addParameter(par,'FrameSize',defaultFrameSize,checkFrameSize);
addParameter(par,'Overlap',defaultOverlap,checkOverlap);
addParameter(par,'Window',defaultWindow,checkWindow);
addParameter(par,'Type',defaultType,checkType);
% Parse inputs
parse(par,Fs,s,varargin{:});
NFFT = par.Results.NFFT;
FrameSize = par.Results.FrameSize;
Overlap = par.Results.Overlap;
Window = par.Results.Window;
Type = par.Results.Type;
%% Sampling 
dt = FrameSize/Fs;
N = length(s);
t = dt/2:dt*(1-Overlap):(N/Fs-dt/2);
Nfr = length(t);
df = Fs/NFFT;
f = (-NFFT/2:NFFT/2-1)'*df;
Noverlap = round(FrameSize*(1-Overlap));
%% Window Function
Nwin = min(NFFT,FrameSize);
win = zeros(FrameSize,1);
if isa(Window,'function_handle')
    tmp = window(Window,Nwin+1);
    win(1:Nwin) = tmp(1:Nwin);
else
    if isempty(Window)
        win(1:Nwin) = window(@hann,Nwin,'periodic');
    else
        win(1:Nwin) = Window(1:Nwin);
    end
end
S1 = sum(win);
S2 = sum(win.^2);
ENBW = Fs*S2/S1^2;
%% Reshape and Window Data
sfr = zeros(FrameSize,Nfr);
istart = 0;
for i=1:Nfr
    subset = istart+(1:FrameSize)';
    if subset(end)<=N
        sfr(1:FrameSize,i) = win.*s(subset);
        istart = istart + Noverlap;
    end
end
%% Calculate Fourier Transform
S = fft(sfr,NFFT,1);
%% Normalize for Requested Output Type
switch Type
    case 'LS'
        S = 1/S1*S;
    case 'LSD'
        S = 1/sqrt(Fs*S2)*S;
    case 'PS'
        S = 1/(2*S1^2)*S.*conj(S);
    case 'PSD'
        S = 1/(2*Fs*S2)*S.*conj(S);
end
