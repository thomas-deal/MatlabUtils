function phiq = Interp1Bearing(t,phi,tq)
%% function phiq = Interp1Bearing(t,phi,tq)
%
% Interpolates bearing data accounting for 360 degree wraparound. Output is
% in the range [-180, 180].
%
% Inputs:
%       t       - Independent variable for bearing data, usually time
%       phi     - Bearing data, deg
%       tq      - Points to evaluate bearing data, usually time
%
% Outputs:
%       phiq    - Interpolated bearing, deg
%

%% Convert to x/y
x = cosd(phi);
y = sind(phi);
%% Interpolate
xq = interp1(t,x,tq,'linear','extrap');
yq = interp1(t,y,tq,'linear','extrap');
%% Convert to bearing
phiq = atan2d(yq,xq);
