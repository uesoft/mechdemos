function mech_normalFrictionActuator(block,whichCall,varargin)
% Support the normal friction actuator block

% Copyright 2005 The MathWorks, Inc.

switch whichCall
    case 'setPrimitive'
        set_primitivesUnderMask(block);
        
    case 'showHideFrictionForces'
        showHideSForcesignal(block,varargin{1});
        
    case 'showHideActuatorSignal'
        showHideActuatorsignal(block,varargin{1});
        
    case 'setPrimitiveKineticDamping'
        set_primitivesUnderMask_KineticDamping(block);
        
    otherwise
        % nothing
        
end
%-------------------------------------------------------------------------

function set_primitivesUnderMask(block)
% Sets the primitive on the IC actuator and the joint sensor depending on
% the user's pick from the pull down in the mask

currentBlk = block;
Prim = get_param(currentBlk,'primitive');

stictionBlkName = 'JointStictionActuator';
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

block1name = 'Kinetic Friction';
block2name = 'Static Friction';
PortH = get_param(block,'portHandles');

kPos = get_param([block '/' block1name],'Position');
kOrient = get_param([block '/' block1name],'Orientation');

sPos = get_param([block '/' block2name],'Position');
sOrient = get_param([block '/' block2name],'Orientation');

if (checkboxstate == logical(0)) && (~isempty(PortH.Outport))
    delete_block([block '/' block1name]);
    delete_block([block '/' block2name]);
    add_block('built-in/terminator',[block '/' block1name],'Position',kPos,'Orientation',kOrient);
    add_block('built-in/terminator',[block '/' block2name],'Position',sPos,'Orientation',sOrient);
elseif (checkboxstate == logical(1)) && (isempty(PortH.Outport))
    delete_block([block '/' block1name]);
    delete_block([block '/' block2name]);
    add_block('built-in/outport',[block '/' block1name],'Position',kPos,'Orientation',kOrient);
    add_block('built-in/outport',[block '/' block2name],'Position',sPos,'Orientation',sOrient);
end
%-------------------------------------------------------------------------

function showHideActuatorsignal(block,checkboxstate)
% adds or deletes ports for Stiction force signals

block1name = 'External Actuation';
aPos = get_param([block '/' block1name],'Position');
aOrient = get_param([block '/' block1name],'Orientation');
PortH = get_param(block,'portHandles');

if (checkboxstate == logical(0)) && (~isempty(PortH.Inport))
    delete_block([block '/' block1name]);
    add_block('built-in/ground',[block '/' block1name],'Position',aPos,'Orientation',aOrient);
elseif (checkboxstate == logical(1)) && (isempty(PortH.Inport))
    delete_block([block '/' block1name]);
    add_block('built-in/inport',[block '/' block1name],'Position',aPos,'Orientation',aOrient);
end
%-------------------------------------------------------------------------

