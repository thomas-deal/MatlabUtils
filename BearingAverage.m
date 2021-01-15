function [avgtheta, stdtheta] = BearingAverage(theta,varargin)
% function [avgtheta, stdtheta] = BearingAverage(theta)
% function [avgtheta, stdtheta] = BearingAverage(theta,avgdim)
%
% Computes the average and standard deviation of a set of bearings in 
% degrees. Result is in the range [0,360). For matrix inputs, the input 
% avgdim selects the dimension to average over. Ignores NaN values.
%
% Inputs:
%       theta       - Bearing, degrees
%       avgdim      - Marix dimension to average over
%
% Outputs:
%       avgtheta    - Bearing mean, degrees
%       stdtheta    - Bearing standard deviation, degrees
%

%% Check Input Arguments
switch nargin
    case 2
        avgdim = varargin{1};
    otherwise
        if size(theta,1)==1
            avgdim = 2;
        else
            avgdim = 1;
        end
end
%% Compute Average
x = cosd(theta);
y = sind(theta);
x = mean(x,avgdim,'omitnan');
y = mean(y,avgdim,'omitnan');
avgtheta = mod(atan2d(y,x),360);
%% Compute Standard Deviation
stdtheta = std(wrap180(theta-avgtheta),0,avgdim,'omitnan');
