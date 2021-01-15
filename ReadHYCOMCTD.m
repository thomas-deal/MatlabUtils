function [lat, lon, depth, salinity, temp] = ReadHYCOMCTD(varargin)
%% function [lat, lon, depth, salinity, temp] = ReadHYCOMCTD(varargin)
%
% Reads salinity, temperature, and depth data from a HYCOM NetCDF file.
%
% Optional Inputs:
%           FileName    - Name of file to read
%
% Outputs:
%           lat         - Latitude, deg
%           lon         - Longitude, deg
%           depth       - Depth, m
%           salinity    - Salinity, psu
%           temp        - Temperature, degrees Celsius
%

%% Check Inputs
% Create parser
par = inputParser;
% FileName
defaultFileName = 'latest.nc4';
checkFileName = @(x) ischar(x);
% Add inputs to parser
addParameter(par,'FileName',defaultFileName,checkFileName);
% Parse inputs
parse(par,varargin{:});
FileName = par.Results.FileName;
%% Read Data
lat = ncread(FileName,'lat');
lon = ncread(FileName,'lon');
depth = ncread(FileName,'depth');
salinity = ncread(FileName,'salinity');
temp = ncread(FileName,'water_temp');
