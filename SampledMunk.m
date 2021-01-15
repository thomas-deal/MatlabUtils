function [z, c, cdot, cdot2] = SampledMunk(zmax,varargin)
%% function [z, c, cdot, cdot2] = SampledMunk(zmax,varargin)
%
% Calculates the sound speed and its derivative for the canonical Munk
% profile evaluated at depth z. Optional arguments allow the user to
% specify sound channel axis depth and sound speed.
%
% Inputs:
%           zmax    - Maximum depth, m
%
% Optional Inputs:
%           dz0     - Initial depth spacing, m
%           zaxis   - Sound channel axis depth, m
%           c0      - Sound speed at sound channel axis, m/s
%
% Outputs:
%           z       - Depth, m
%           c       - Sound speed, m/s
%           cdot    - Sound speed derivative, (m/s)/m
%           cdot2   - Sound speed second derivative, (m/s)/m^2
%

%% Check Inputs
% Create parser
par = inputParser;
% dz0
defaultdz0 = 20;
checkdz0 = @(x) isnumeric(x) && isscalar(x) && (x > 0);
% zaxis
defaultzaxis = 1000;
checkzaxis = @(x) isnumeric(x) && isscalar(x) && (x > 0);
% c0
defaultc0 = 1490;
checkc0 = @(x) isnumeric(x) && isscalar(x) && (x > 0);
% Add inputs to parser
addRequired(par,'zmax',@isnumeric);
addParameter(par,'dz0',defaultdz0,checkdz0);
addParameter(par,'zaxis',defaultzaxis,checkzaxis);
addParameter(par,'c0',defaultc0,checkc0);
% Parse inputs
parse(par,zmax,varargin{:});
dz0 = par.Results.dz0;
zaxis = par.Results.zaxis;
c0 = par.Results.c0;
%% Initialize
z = 0;
[c,cdot,cdot2] = Munk(0,'zaxis',zaxis,'c0',c0);
dzfact = dz0*cdot2;
zi = dzfact/cdot2;
%% Sample
while zi<zmax
    [ci,cdoti,cdot2i] = Munk(zi,'zaxis',zaxis,'c0',c0);
    z = [z; zi]; %#ok<*AGROW>
    c = [c; ci];
    cdot = [cdot; cdoti];
    cdot2 = [cdot2; cdot2i];
    zi = zi + dzfact/cdot2i;
end
[ci,cdoti,cdot2i] = Munk(zmax,'zaxis',zaxis,'c0',c0);
z = [z; zmax];
c = [c; ci];
cdot = [cdot; cdoti];
cdot2 = [cdot2; cdot2i];
