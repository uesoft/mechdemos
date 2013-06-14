function mech_car_handling_fig_mgr(Command,appDataName,figInfo)
% Initialize and destroy open figures for the mech_car_handling model.
% Command can be 'init' or 'destroy'.

% Copyright 2005-2006 The MathWorks, Inc.

if nargin < 3
    figInfo.pos = [420   378   560   270];
    figInfo.title = 'Radius vs Speed for a Range of Roll Stiffnesses';
    figInfo.xlabel = 'Speed';
    figInfo.ylabel = 'Radius';
    figInfo.axis = [5 20 30 130];
end

appDaTa = getappdata(0,appDataName);
switch Command
    case 'init'        
        if isempty(appDaTa)
            fH = figure;
            aH=axes('Parent',fH);
            
            if isfield(figInfo,axis)
                axis(figInfo.axis);            
            end            
            set(fH,'DeleteFcn',['rmappdata(0,''' appDataName ''')']);
            set(fH,'Position',figInfo.pos);
            title(figInfo.title) ;
            xlabel(figInfo.xlabel) ;
            ylabel(figInfo.ylabel) ;
            hold on;
            grid on;
            mech_car_steering_fig_data.axesH = aH;
            mech_car_steering_fig_data.figureH = get(aH,'Parent');
            setappdata(0,appDataName,mech_car_steering_fig_data);
        end

    case 'destroy'
        if ~isempty(appDaTa)
            delete(appDaTa.figureH)
        end
end