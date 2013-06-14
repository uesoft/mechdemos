function [flexBeamElementData] = mech_flexible_beamelement(flexBeamElement)
% Computes the parameters for the flexible beam element.

% Copyright 2005 The MathWorks, Inc.

flexBeamElementData = calculateParameters(flexBeamElement);

%-------------------------------------------------------------------------

function [flexBeamElement] = calculateParameters(flexBeamElement)

rhsTriad = local_giveRHSTriad(flexBeamElement.beamDir);
flexBeamElement.cs1 = [0 0 0]; %w.r.t adjoining
flexBeamElement.cs2 = flexBeamElement.length * rhsTriad(:,1);%w.r.t CS1
flexBeamElement.cg = flexBeamElement.cgLeng*rhsTriad(:,1); %w.r.t CS1
flexBeamElement.mass = flexBeamElement.crossArea * flexBeamElement.length * flexBeamElement.density;

flexBeamElement.J = flexBeamElement.Ixx + flexBeamElement.Iyy;

% Spring Constants
flexBeamElement.kTwist =  flexBeamElement.shearM * flexBeamElement.J/ flexBeamElement.length;
flexBeamElement.kBendingXX = flexBeamElement.youngsM * flexBeamElement.Ixx / flexBeamElement.length;
flexBeamElement.kBendingYY = flexBeamElement.youngsM * flexBeamElement.Iyy / flexBeamElement.length;
flexBeamElement.kElong = flexBeamElement.youngsM * flexBeamElement.crossArea/flexBeamElement.length;


flexBeamElement.xDir= rhsTriad(:,1)'; %Along beam length
flexBeamElement.yDir= rhsTriad(:,2)'; %Along beam deflection
flexBeamElement.zDir= rhsTriad(:,3)'; %Normal to the deflection and beam length

%-------------------------------------------------------------------------

function [rhsTriad] = local_giveRHSTriad(inputVector)
% Returns a 3x3 matrix containing a Right Handed Triad in column wise order

inputVectorNorm = norm(inputVector);
if (inputVectorNorm < eps)
    rhsTriad = eye(3);
    warning('The input vector was of zero length! Returning eye(3,3)!');
    return
elseif (inputVectorNorm < (1-eps)) || (inputVectorNorm > (1+eps))
    inputVector = inputVector/inputVectorNorm;
end
    
normalVector = getNormalVector(inputVector);
normalVector2 = cross(inputVector,normalVector);

rhsTriad = [inputVector;normalVector;normalVector2]';

%--------------------------------------------------------------------

function [normalVector] = getNormalVector(inputVector)
% Rotate an arbitary vector in space by 90 degrees

angTol = eps;
angle = pi/2;
C = cos(angle);
S = sin(angle);

xAxis = [1 0 0];
yAxis = [0 1 0];
zAxis = [0 0 1];
normalVector = [0 0 0];

% Check and see if the direction inputVector is along any primary axis

% Zaxis
magCrossZ = norm(cross(inputVector,zAxis));

% Yaxis
magCrossY = norm(cross(inputVector,yAxis));

% Xaxis
magCrossX = norm(cross(inputVector,xAxis));

if (magCrossZ * magCrossY * magCrossX > angTol),
    % This means that the inputVector is skewed.
    % You are given a skewed vector and you need to get another
    % vector that is rotated by 90 deg w.r.t. the given vector.
    %
    % We solve the equation:
    %
    % axis[0]*X + axis[1]*Y + axis[2]*Z = 0;
    % We pick any two (X Y, Y Z, or X Z) arbitatily and find the third one.
    % Here we use an arbitary point P1 [1 1]. So we have
    % axis[0]*P1 + axis[1]*P1 + axis[2]*Z = 0; and find Z.
    %
    % In the following code we use the max(axis) to choose whether
    % it will be X, Y or Z.
    arbitaryPoint = 1;
    maxInputVector = max(abs(inputVector));
    if (abs(inputVector(3)) == maxInputVector)
        % the Z coordinate is largest
        normalVector(1) = arbitaryPoint;
        normalVector(2) = arbitaryPoint;
        normalVector(3) = -(inputVector(1)*arbitaryPoint + inputVector(2)*arbitaryPoint)/inputVector(3);

    elseif (abs(inputVector(2)) == maxInputVector)
        % the Y coordinate is largest
        normalVector(1) = arbitaryPoint;
        normalVector(3) = arbitaryPoint;
        normalVector(2) = -(inputVector(1)*arbitaryPoint + inputVector(3)*arbitaryPoint)/axis(2);

    elseif (abs(inputVector(1)) == maxInputVector)
        % the X coordinate is largest
        normalVector(2) = arbitaryPoint;
        normalVector(3) = arbitaryPoint;
        normalVector(1) = -(inputVector(2)*arbitaryPoint + inputVector(3)*arbitaryPoint)/inputVector(1); 
    end

    % Now normalize the vector
    normalVectorNorm = norm(normalVector);
    if (normalVectorNorm > 0)
        normalVector = normalVector/normalVectorNorm;
    end

elseif (magCrossZ > angTol)
    %Rotation matrix about Z

    R = [C S  0;
        -S  C  0;
         0  0  1];

    normalVector = inputVector * R;

elseif (magCrossY > angTol)
    % Rotation matrix about Y
    R = [C  0 -S;
         0  1  0;
         S  0  C];
    normalVector = inputVector * R;

else
    % Rotation matrix about X
    R = [1  0  0;
         0  C  S;
         0 -S  C];
    normalVector = inputVector * R;
end

%--------------------------------------------------------------------

% %-----------------------------------------
% % Defined in the block mask now. I have left it here because it can be 
% % used as a starting point of describing a material data file format
% %-----------------------------------------
% flexBeamElement.material = 'Mild Steel';
% 
% % Beam element density (Kg/m^3)
% flexBeamElement.density = 7600;
% 
% % Beam element Youngs Modulus (N/m^2)
% flexBeamElement.youngsM = 200E9;
% 
% % Beam element Shear Modulus (N/m^2)
% flexBeamElement.shearM = 26E9;
% 
% flexBeamElement.LengX = 1E-2;
% flexBeamElement.LengY = 1E-2;
% 
% % Beam element area of cross-section (m^2)
% flexBeamElement.crossArea = flexBeamElement.LengX * flexBeamElement.LengY;
% 
% % Beam element Area Moment of Inertia along the direction of bending (m^4)
% flexBeamElement.Ixx = flexBeamElement.LengX * flexBeamElement.LengY^3/12;
% 
% % Beam element Area Moment of Inertia normal to the direction of
% % bending (m^4)
% flexBeamElement.Iyy = flexBeamElement.LengY * flexBeamElement.LengX^3/12;
% 
% % Beam element length (m)
% flexBeamElement.length = 0.15;
% 
% % Length of CG vector along length of beam (m)
% flexBeamElement.cgLeng = 0.075;
% 
% % Beam element direction (along X direction it is [1 0 0])
% flexBeamElement.beamDir = [1 0 0];
% 
% % Beam element Mass Moment of Inertia (Kg/m^2)
% flexBeamElement.Inertia = [120 0 0;0 6400.0 0;0 0 6400.0]*1E-7;
% %flexBeamElement.Inertia = eye(3);
% 
% flexBeamElement.matDamping = 0.35;
% %-----------------------------------------