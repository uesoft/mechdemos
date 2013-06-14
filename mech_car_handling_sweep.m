%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RUN PARAMETER SWEEP for the mech_car_handling model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Copyright 2005-2006 The MathWorks, Inc.

chassis.a = 1.3; 
chassis.hs = 0.3;
chassis.b = 2.49 - chassis.a;
Fzf = 0.5*(chassis.ms+chassis.mu) * 9.81 * chassis.b / (chassis.a + chassis.b);    % initial front wheel reaction
Fzr = 0.5*(chassis.ms+chassis.mu) * 9.81 * chassis. a / (chassis.a + chassis.b);   % initial rear wheel reaction

modelFigure = [];
i = 0;     % initialize counter
for kb = 5500:500:10000
    kf = 14500 - kb;
    i = i + 1;
    [t,x,y] = sim(gcs);
    modelFigure = getappdata(0,'mech_car_steering_fig_data');
    p = size(y);
    p = p(1);
    R = y([30:p],2)./y([30:p],1);
    plot(y([30:p],2),R,'Parent',modelFigure.axesH);
end

chassis.hs = 0;
chassis.hu = 0;
[t,x,y] = sim(gcs);
p = size(y);
p = p(1);
R = y([30:p],2)./y([30:p],1);
plot(y([30:p],2),R,'r','Parent',modelFigure.axesH)

chassis.hs = 0.3;
chassis.hu = 0.1; 
disp('mech_car_handling: Sweep of roll stiffness is complete.');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%