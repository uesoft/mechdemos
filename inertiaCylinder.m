function [mass, inertia] = inertiaCylinder(dens, length, rout, rin)
% Calculates the mass and inertia of a cylinder

%   Copyright 1998-2005 The MathWorks, Inc.


% Compute mass
mass = pi*(rout^2-rin^2)*length*dens;

% Compute principal inertias and inertia tensor
Ix = mass*(3*(rout^2 + rin^2) + length^2)/12;
Iy = Ix;
Iz = mass*(rout^2 + rin^2)/2;
inertia = [Ix 0 0; 0 Iy 0; 0 0 Iz];
