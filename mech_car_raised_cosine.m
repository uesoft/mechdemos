function y = mech_car_raised_cosine(top_length, slope, T, t) 
% Helper function to create a raised cosine pulse at time 'T'
% with a slope of 'slope' where this is a measure of 
% the frequency of the cosine wave.
% 
% The flat section at the top has length
% 'top length'. Runs for simulation time 't'. 

% Copyright 2005-2006 The MathWorks, Inc.

if t <= (T - pi / slope)
    y = 0; 
elseif t >= (T +top_length+ pi / slope)
    y = 0; 
elseif (t>= (T-pi/slope))&& (t <= T)
    a1 = t - T; 
    a2 = cos(slope*(a1)); 
    a3 = 1 + a2; 
    y = a3; 
elseif (t>T)&&(t<(T+top_length))
    y = 2; 
else
    a1 = t - T - top_length; 
    a2 = cos(slope*(a1)); 
    a3 = 1 + a2; 
    y = a3;
end