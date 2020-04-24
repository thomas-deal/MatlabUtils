function [n,e,d] = lla2ned(lat,lon,varargin)
%% function [n,e,d] = lla2ned(lat,lon)
% function [n,e,d] = lla2ned(lat,lon,alt)
% function [n,e,d] = lla2ned(lat,lon,alt,refLat,refLon,refAlt)
%
% Converts lat/lon/alt points to n/e/d points in meters, using mapping
% toolbox if avaialable. If refLat and refLon are omitted, the first points
% in lat/lon are used as reference.
%
% Inputs:   lat     - Latitude, deg
%           lon     - Longitude, deg
%           alt     - Altitude, m
%           refLat  - Reference latitude, deg 
%           refLon  - Reference longitude, deg 
%           refAlt  - Reference altitude, deg 
%
% Outputs:  n       - North, m
%           e       - East, m
%           d       - Down, m
%

%% Check Inputs
alt = zeros(size(lat));
refLat = lat(1);
refLon = lon(1);
refAlt = 0;
switch nargin
    case 3
        alt = varargin{1};
    case 6
        alt = varargin{1};
        refLat = varargin{2};
        refLon = varargin{3};
        refAlt = varargin{4};
end
if alt==0
    alt = zeros(size(lat));
end
%% Convert Points
d = -alt;
if license('test','map_toolbox')
    [e,n,~] = geodetic2enu(lat,lon,alt,refLat,refLon,refAlt,wgs84Ellipsoid());
else
    [xr,yr,zr] = lla2ecef(refLat,refLon,refAlt);
    [x,y,z] = lla2ecef(lat,lon,alt);
    [e,n,~] = ecef2enu(xr,yr,zr,x,y,z);
end

return

function [x,y,z] = lla2ecef(lat,lon,alt)
a = 6378137.0;          % Earth semi-major axis
f = 1/298.257223563;    % Reciprocal flattening
e2 = 2*f - f^2;         % Eccentricity squared
chi = sqrt(1-e2*sind(lat).^2);
x = (a./chi+alt).*cosd(lat).*cosd(lon);
y = (a./chi+alt).*cosd(lat).*sind(lon);
z = (a.*(1-e2)./chi+alt).*sind(lat);
return

function [e,n,u] = ecef2enu(xr,yr,zr,x,y,z)
phip = atan2(zr,hypot(xr,yr));
lam = atan2(yr,xr);
enu = [-sin(lam) cos(lam) 0; ...
       -sin(phip)*cos(lam) -sin(phip)*sin(lam) cos(phip); ...
        cos(phip)*cos(lam)  cos(phip)*sin(lam) sin(phip)]*[(x-xr)';(y-yr)';(z-zr)'];
e = enu(1,:)';
n = enu(2,:)';
u = enu(3,:)';
return
