function [ainv11,ainv12,ainv13, ...
          ainv21,ainv22,ainv23, ...
          ainv31,ainv32,ainv33] = inv3x3(a11,a12,a13, ...
                                         a21,a22,a23, ...
                                         a31,a32,a33)
%% function [ainv11,ainv12,ainv13,ainv21,ainv22,ainv23,ainv31,ainv32,ainv33] = inv3x3(a11,a12,a13,a21,a22,a23,a31,a32,a33)
%
% Expands the calculation for the inverse of a 3x3 matrix to accommodate 
% matrix elements that are matrices themselves.
%
% Inputs:
%           aij     - Matrix A element (i,j)
%
% Outputs:
%           ainvij  - Matrix inv(A) element (i,j)
%

%% Calculate Determinant
detA = det3x3(a11,a12,a13,a21,a22,a23,a31,a32,a33);
%% Invert Matrix
ainv11 = 1./detA.*(a22.*a33-a23.*a32);
ainv12 = 1./detA.*(a13.*a32-a12.*a33);
ainv13 = 1./detA.*(a12.*a23-a13.*a22);
ainv21 = 1./detA.*(a23.*a31-a21.*a33);
ainv22 = 1./detA.*(a11.*a33-a13.*a31);
ainv23 = 1./detA.*(a13.*a21-a11.*a23);
ainv31 = 1./detA.*(a21.*a32-a22.*a31);
ainv32 = 1./detA.*(a12.*a31-a11.*a32);
ainv33 = 1./detA.*(a11.*a22-a12.*a21);
