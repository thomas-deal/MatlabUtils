function [c,cdot,cdot2] = Munk(z,varargin)
%% function [c,cdot,cdot2] = Munk(z)
%
% Calculates the sound speed and its derivative for the canonical Munk
% profile evaluated at depth z. Optional arguments allow the user to
% specify sound channel axis depth and sound speed.
%
% Inputs:
%           z       - Depth, m
%
% Optional Inputs:
%           zaxis   - Sound channel axis depth, m
%           c0      - Sound speed at sound channel axis, m/s
%
% Outputs:
%           c       - Sound speed, m/s
%           cdot    - Sound speed derivative, (m/s)/m
%           cdot2   - Sound speed second derivative, (m/s)/m^2
%

%% Check Inputs
% Create parser
par = inputParser;
% zaxis
defaultzaxis = 1000;
checkzaxis = @(x) isnumeric(x) && isscalar(x) && (x > 0);
% c0
defaultc0 = 1490;
checkc0 = @(x) isnumeric(x) && isscalar(x) && (x > 0);
% Add inputs to parser
addRequired(par,'z',@isnumeric);
addParameter(par,'zaxis',defaultzaxis,checkzaxis);
addParameter(par,'c0',defaultc0,checkc0);
% Parse inputs
parse(par,z,varargin{:});
zaxis = par.Results.zaxis;
c0 = par.Results.c0;
%% Default parameters
B = 1000;
eps = 0.0057;
%% Calculate sound speed and derivative
eta = 2*(z-zaxis)/B;
c = c0*(1+eps*(exp(-eta)+eta-1));
cdot = 2*eps*c0/B*(1-exp(-eta));
cdot2 = 4*eps*c0/B^2*exp(-eta);
