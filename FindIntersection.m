function [x,y] = FindIntersection(x1,y1,theta1,x2,y2,theta2)
%% function [x,y] = FindIntersection(x1,y1,theta1,x2,y2,theta2)
%
% Finds the intersection (x,y) of bearing lines theta1 and theta2 from 
% points (x1,y1) and (x2,y2), respectively.
%
% Inputs:
%       x1     - X coordinate of first observation point
%       y1     - Y coordinate of first observation point
%       theta1 - Bearing from first observation point, deg
%       x2     - X coordinate of second observation point
%       y2     - Y coordinate of second observation point
%       theta2 - Bearing from second observation point, deg
%
% Outputs:
%       x      - X coordinate of intersection point
%       Y      - Y coordinate of intersection point
%

%% Check Inputs
if wrap180(theta1-theta2)==0
    disp('Error - FindIntersection: bearing lines are parallel')
    if (x1==x2)&&(y1==y2)
        x = x1;
        y = y1;
    else
        x = NaN;
        y = NaN;
    end
    return
end
%% Convert to Slope-Intercept
m1 = tand(theta1);
b1 = y1-m1.*x1;
m2 = tand(theta2);
b2 = y2-m2.*x2;
%% Calculate Intercept Point
x = (b2-b1)./(m1-m2);
y = (m1.*b2-m2.*b1)./(m1-m2);
