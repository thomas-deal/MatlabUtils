function out = wrap180(in)
%% function out = wrap180(in)
%
% Limits the range of angular values to +/-180 degrees.
% Inputs:
%           in  - Input angle(s), deg
%
% Outputs:
%           out - Output angle(s), deg
%

%% Calculate
out = mod(in,360);
out(out>180) = out(out>180) - 360;
