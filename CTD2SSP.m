function c = CTD2SSP(depth,salinity,temp)

%% Calculate
% Medwin 1975
c = 1449.2 + 4.6*temp - 5.5e-2*temp.^2 + 2.9e-4*temp.^3 + ...
    (1.34 - 1e-2*temp).*(salinity - 35) + ...
    1.6e-2*depth;