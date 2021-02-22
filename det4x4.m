function detA = det4x4(a11,a12,a13,a14, ...
                       a21,a22,a23,a24, ...
                       a31,a32,a33,a34, ...
                       a41,a42,a43,a44)
%% function detA = det4x4(a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44)
%
% Expands the calculation for the determinant of a 4x4 matrix to
% accommodate matrix elements that are matrices themselves.
%
% Inputs:
%           aij     - Matrix A element (i,j)
%
% Outputs:
%           detA    - Determinant of A
%

%% Calculate
detA = a11.*det3x3(a22,a23,a24,a32,a33,a34,a42,a43,a44) - ...
       a21.*det3x3(a12,a13,a14,a32,a33,a34,a42,a43,a44) + ...
       a31.*det3x3(a12,a13,a14,a22,a23,a24,a42,a43,a44) - ...
       a41.*det3x3(a12,a13,a14,a22,a23,a24,a32,a33,a34);
