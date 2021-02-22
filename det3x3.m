function detA = det3x3(a11,a12,a13, ...
                       a21,a22,a23, ...
                       a31,a32,a33)
%% function detA = det3x3(a11,a12,a13,a21,a22,a23,a31,a32,a33)
%
% Expands the calculation for the determinant of a 3x3 matrix to
% accommodate matrix elements that are matrices themselves.
%
% Inputs:
%           aij     - Matrix A element (i,j)
%
% Outputs:
%           detA    - Determinant of A
%

%% Calculate
detA = a11.*(a22.*a33-a23.*a32) - a12.*(a21.*a33-a23.*a31) + a13.*(a21.*a32-a22.*a31);
