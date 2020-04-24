function avgtheta = BearingAverage(theta,varargin)
% function avgtheta = BearingAverage(theta)
% function avgtheta = BearingAverage(theta,avgdim)
%
% Computes the average of a set of bearings in degrees. Result is in the
% range [0,360). For matrix inputs, the input avgdim selects the dimension
% to average over. Ignores NaN values in theta.
%
% Inputs:
%       theta       - Bearing, degrees
%       avgdim      - Marix dimension to average over
%
% Outputs:
%       avgtheta    - Average Bearing, degrees
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
