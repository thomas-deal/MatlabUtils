function [ainv11,ainv12,ainv13,ainv14, ...
          ainv21,ainv22,ainv23,ainv24, ...
          ainv31,ainv32,ainv33,ainv34, ...
          ainv41,ainv42,ainv43,ainv44] = inv4x4(a11,a12,a13,a14, ...
                                                a21,a22,a23,a24, ...
                                                a31,a32,a33,a34, ...
                                                a41,a42,a43,a44)
%% function [ainv11,ainv12,ainv13,ainv14,ainv21,ainv22,ainv23,ainv24,ainv31,ainv32,ainv33,ainv34,ainv41,ainv42,ainv43,ainv44] = inv4x4(a11,a12,a13,a14,a21,a22,a23,a24,a31,a32,a33,a34,a41,a42,a43,a44)
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
detA = det4x4(a11,a12,a13,a14, ...
              a21,a22,a23,a24, ...
              a31,a32,a33,a34, ...
              a41,a42,a43,a44);
%% Invert Matrix
ainv11 = (-1)^(1+1)*det3x3(a22,a23,a24,a32,a33,a34,a42,a43,a44)./detA;
ainv12 = (-1)^(1+2)*det3x3(a12,a13,a14,a32,a33,a34,a42,a43,a44)./detA;
ainv13 = (-1)^(1+3)*det3x3(a12,a13,a14,a22,a23,a24,a42,a43,a44)./detA;
ainv14 = (-1)^(1+4)*det3x3(a12,a13,a14,a22,a23,a24,a32,a33,a34)./detA;
ainv21 = (-1)^(2+1)*det3x3(a21,a23,a24,a31,a33,a34,a41,a43,a44)./detA;
ainv22 = (-1)^(2+2)*det3x3(a11,a13,a14,a31,a33,a34,a41,a43,a44)./detA;
ainv23 = (-1)^(2+3)*det3x3(a11,a13,a14,a21,a23,a24,a41,a43,a44)./detA;
ainv24 = (-1)^(2+4)*det3x3(a11,a13,a14,a21,a23,a24,a31,a33,a34)./detA;
ainv31 = (-1)^(3+1)*det3x3(a21,a22,a24,a31,a32,a34,a41,a42,a44)./detA;
ainv32 = (-1)^(3+2)*det3x3(a11,a12,a14,a31,a32,a34,a41,a42,a44)./detA;
ainv33 = (-1)^(3+3)*det3x3(a11,a12,a14,a21,a22,a24,a41,a42,a44)./detA;
ainv34 = (-1)^(3+4)*det3x3(a11,a12,a14,a21,a22,a24,a31,a32,a34)./detA;
ainv41 = (-1)^(4+1)*det3x3(a21,a22,a23,a31,a32,a33,a41,a42,a43)./detA;
ainv42 = (-1)^(4+2)*det3x3(a11,a12,a13,a31,a32,a33,a41,a42,a43)./detA;
ainv43 = (-1)^(4+3)*det3x3(a11,a12,a13,a21,a22,a23,a41,a42,a43)./detA;
ainv44 = (-1)^(4+4)*det3x3(a11,a12,a13,a21,a22,a23,a31,a32,a33)./detA;
