function mass = mech_flyball_rod_masss(length, radius, density)
%MECH_FLYBALL_ROD_MASS - return the mass of a rod given it's
%  length radius and density
  
% Copyright 2002 The MathWorks, Inc.
  
  mass = pi * radius ^ 2 * length * density;
  
% [EOF] mech_flyball_rod_mass.m
