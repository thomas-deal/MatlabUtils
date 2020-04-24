function [m, b] = LineFitBLS(x,y)
%% function [m, b] = LineFitBLS(x,y)
%
% Batch least-squares fit of data (x,y) to a straight line y=mx+b.
%
% Inputs:
%       x1     - Vector of x data
%       y1     - Vector of y data
%
% Outputs:
%       m      - Best fit line slope
%       b      - Best fit line Y intercept
%

%% Check Inputs
x = x(:);
y = y(:);
if length(x)~=length(y)
    m = NaN;
    b = NaN;
    disp('Error - LineFitBLS: input dimensions must match.')
    return
end
if length(x)==1
    m = 0;
    b = y(1);
    disp('Warning - LineFitBLS: two or more data points required for a line.')
    return
end
%% Calculate
A = [length(x) sum(x);sum(x) sum(x.^2)];
d = [sum(y); sum(x.*y)];
sol = A\d;
b = sol(1);
m = sol(2);

