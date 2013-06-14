function mech_kineticDampingActuator(block,whichCall,varargin)
% Support the Kinetic damping actuator block

% Copyright 2005 The MathWorks, Inc.

switch whichCall
    case 'setPrimitive'
        set_primitivesUnderMask(block);
        
    case 'showHideFrictionForces'
        showHideSForcesignal(block,varargin{1});
        
    otherwise
        % nothing
        
end
%-------------------------------------------------------------------------

function set_primitivesUnderMask(block)
% Sets the primitive on the IC actuator and the joint sensor depending on
% the user's pick from the pull down in the mask

currentBlk = block;
Prim = get_param(currentBlk,'primitive');

stictionBlkName = 'JointActuator';
jointSensorBlkName = 'JointSensor';
stictionActBlkH = get_param([currentBlk '/' stictionBlkName],'Handle');
jointSensorBlkH = get_param([currentBlk '/' jointSensorBlkName],'Handle');


%set the primitive on the Stiction Actuator
set_param(stictionActBlkH,'Primitive',Prim);

%set the primitive on the joint sensor
set_param(jointSensorBlkH,'Primitive',Prim);
%-------------------------------------------------------------------------

function showHideSForcesignal(block,checkboxstate)
% adds or deletes ports for Stiction force signals

block1name = 'Damping Force';
PortH = get_param(block,'portHandles');

kPos = get_param([block '/' block1name],'Position');
orient = get_param([block '/' block1name],'Orientation');

if (checkboxstate == logical(0)) && (~isempty(PortH.Outport))
    delete_block([block '/' block1name]);
    add_block('built-in/terminator',[block '/' block1name],'Position',kPos,...
        'Orientation',orient);
elseif (checkboxstate == logical(1)) && (isempty(PortH.Outport))
    delete_block([block '/' block1name]);
    add_block('built-in/outport',[block '/' block1name],'Position',kPos,...
        'Orientation',orient);
end
%-------------------------------------------------------------------------

