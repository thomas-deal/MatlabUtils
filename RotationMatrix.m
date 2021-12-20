function R = RotationMatrix(varargin)
%% function R = RotationMatrix(gamma,theta,psi)
% function R = RotationMatrix(Ori)
%
% Creates a rotation matrix for converting Cartesian coordinates from one
% frame to another frame rotated gamma degrees about the x axis, theta
% degrees about the y axis, and psi degrees about the z axis in a
% right-handed coordinate frame. If gamma, theta, and psi are vectors of
% the same length N, R is of dimension 3x3xN. Instead of passing gamma,
% theta, and psi individually, they can bbe combined as rows in the 3xN
% mareix Ori.
%
% Inputs:
%           gamma   - Roll angle, deg
%           theta   - Pitch or elevation angle, deg
%           psi     - Yaw or azimuthal angle, deg
%           Ori     - [gamma;theta;psi] passed as column vector or matrix
%
% Outputs:
%           R       - Rotation matrix
%

%% Initialize
R = eye(3);
%% Check Input Dimensions
switch nargin
    case 1
        Ori = varargin{1};
        if size(Ori,1)~=3
            disp('RotationMatrix: input Ori has incorrect dimensions')
            return
        else
            gamma = Ori(1,:);
            theta = Ori(2,:);
            psi   = Ori(3,:);
        end
    case 3
        gamma = varargin{1};
        theta = varargin{2};
        psi   = varargin{3};
        [rg,cg] = size(gamma);
        [rt,ct] = size(theta);
        [rp,cp] = size(psi);
        if ~(rg==rt&&rt==rp&&cg==ct&&ct==cp)
            disp(['RotationMatrix: inputs gamma, theta, and psi ' ...
                  'have incompatible dimensions'])
            return
        end
        if min([rg cg])~=1
            disp(['RotationMatrix: inputs gamma, theta, and psi ' ...
                  'must be scalars or vectors, not matrices'])
            return
        end
    otherwise
        disp('RotationMatrix: incorrect number of input arguments')
        return
end
%% Calculate
N = length(gamma);
R = zeros(3,3,N);
for i=1:N
    Rx = [1 0 0; ...
          0 cosd(gamma(i)) -sind(gamma(i)); ...
          0 sind(gamma(i)) cosd(gamma(i))];
    Ry = [cosd(theta(i)) 0 sind(theta(i)); ...
          0 1 0; ...
          -sind(theta(i)) 0 cosd(theta(i))];
    Rz = [cosd(psi(i)) -sind(psi(i)) 0; ...
          sind(psi(i)) cosd(psi(i)) 0; ...
          0 0 1];
    R(:,:,i) = Rz*Ry*Rx;
end
