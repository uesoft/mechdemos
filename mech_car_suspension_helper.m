function [retVal] = mech_car_suspension_helper(funcName,idx)
% Helper function for the mech_car_suspension model

% Copyright 2005-2006 The MathWorks, Inc.

revVal=[];
switch funcName
    case 'DEFAULT_PARAMS'
        DEFAULT_PARAMS();
        
    case 'ANTI_SQUAT_PARAMS'
        ANTI_SQUAT_PARAMS();
                
    case 'ANTI_DIVE_PARAMS'
        ANTI_DIVE_PARAMS();
        
    case 'TRIM_MODEL'
        retVal = TRIM_MODEL(idx);
        
    case 'ANTI_SQUAT_ANALYSIS'
        AntiSquatAnalysis();
        
    case 'ANTI_DIVE_ANALYSIS'
        AntiDiveAnalysis();
        
    otherwise
        disp('Command invalid')
end
           
%----------------------------------------------------------------

function DEFAULT_PARAMS()

mdlWS = get_param(gcs,'ModelWorkspace');

%-----------------------------------------------------------
% DEMO_DEFAULT_PARAMETERS
%-----------------------------------------------------------

% Initialize structures
road_params = struct();
chassis_params = struct();
rear_susp_params = struct();
front_susp_params = struct();

% Defualt road parameters (FLAT ROAD) 
road_params.top_length = 0; 
road_params.slope = 10; 
road_params.T = 10000;  

% Default chassis parameters
chassis_params.ms = 600;
chassis_params.mu = 45;
chassis_params.a = 1.5;
chassis_params.b = 1;
chassis_params.w = 1.2;
chassis_params.h = 0.5;
%-----------------------------------------------------------

mech_car_suspension_helper('ANTI_SQUAT_PARAMS'); 
mdlWS.assignin('road_params',road_params);
mdlWS.assignin('chassis_params',chassis_params);

% Default suspension parameters
mdlWS.assignin('HCInitialAngle1',8.622620604374659e-002);
mdlWS.assignin('HCInitialAngle2',1.480006582286039e-001);     
mdlWS.assignin('HCInitialRotation',2.894249637178501e-002);     
mdlWS.assignin('HCInitialHeight',1.265272746929901e+000);     

disp('Loaded default model parameters.........');

i = 0;
top_length = road_params.top_length;
slope = road_params.slope;
T = road_params.T;
                                                   
% Define the road surface                          
for t = -10:0.1:1000                               
     i = i+1;
    y(i) = mech_car_raised_cosine(top_length, slope, T, t);
end                                                
Zlookup = 0.1 * y;
mdlWS.assignin('Zlookup',Zlookup);
disp('Road surface established.........');
disp('');                                                         

cs = get_param(gcs,'ConfigurationSets');                                                                        
set_param([gcs '/WORLD/Machine Environment'], 'AnalysisType', 'Forward Dynamics')

disp('Model initialization complete');


function ANTI_SQUAT_PARAMS()

mdlWS = get_param(gcs,'ModelWorkspace');

front_susp_params.Ls = 1.45;
front_susp_params.ks = 16000;
front_susp_params.bs = 1100;

front_susp_params.Chas_Up_Front = [0 0 0];
front_susp_params.Chas_Up_Back = [-0.4 0 0];
front_susp_params.Chas_Low_Front = [0 0 -0.5];
front_susp_params.Chas_Low_Back = [-0.4 0 -0.4];        
front_susp_params.Chas_Steer = [0.05 0 -0.3];
front_susp_params.Chas_Susp = [0 0 0.6];
front_susp_params.Hub_Up = [-0.2 0.55 0];
front_susp_params.Hub_Low = [-0.2 0.55 -0.45];          
front_susp_params.Hub_Steer = [0 0.52 -0.3];
front_susp_params.Hub_Susp = [-0.2 0.55 -0.45];

rear_susp_params.Ls = 1.6;
rear_susp_params.ks = 16000;
rear_susp_params.bs = 1100;
    
rear_susp_params.Chas_Up_Front = [0 0 0];
rear_susp_params.Chas_Up_Back = [-0.4 0 -0.1];
rear_susp_params.Chas_Low_Front = [0 0 -0.5];
rear_susp_params.Chas_Low_Back = [-0.4 0 -0.5];            
rear_susp_params.Chas_Steer = [0.05 0 -0.3];
rear_susp_params.Chas_Susp = [0 0 0.6];
rear_susp_params.Hub_Up = [-0.2 0.55 -0.05];
rear_susp_params.Hub_Low = [-0.2 0.55 -0.5];          
rear_susp_params.Hub_Steer = [0 0.52 -0.3];
rear_susp_params.Hub_Susp = [-0.2 0.55 -0.5];

mdlWS.assignin('front_susp_params',front_susp_params);
mdlWS.assignin('rear_susp_params',rear_susp_params);
%----------------------------------------------------------------

function ANTI_DIVE_PARAMS()

mdlWS = get_param(gcs,'ModelWorkspace');

front_susp_params.Ls = 1.45;
front_susp_params.ks = 16000;
front_susp_params.bs = 1100;

front_susp_params.Chas_Up_Front = [0 0 -0.08];
front_susp_params.Chas_Up_Back = [-0.4 0 0];
front_susp_params.Chas_Low_Front = [0 0 -0.42];
front_susp_params.Chas_Low_Back = [-0.4 0 -0.5];       
front_susp_params.Chas_Steer = [0.05 0 -0.3];
front_susp_params.Chas_Susp = [0 0 0.6];
front_susp_params.Hub_Up = [-0.2 0.55 -0.04];
front_susp_params.Hub_Low = [-0.2 0.55 -0.46];         
front_susp_params.Hub_Steer = [0 0.52 -0.3];
front_susp_params.Hub_Susp = [-0.2 0.55 -0.46];

rear_susp_params.Ls = 1.6;
rear_susp_params.ks = 16000;
rear_susp_params.bs = 1100;

rear_susp_params.Chas_Up_Front = [0 0 0];
rear_susp_params.Chas_Up_Back = [-0.4 0 -0.1];
rear_susp_params.Chas_Low_Front = [0 0 -0.5];
rear_susp_params.Chas_Low_Back = [-0.4 0 -0.5];        
rear_susp_params.Chas_Steer = [0.05 0 -0.3];
rear_susp_params.Chas_Susp = [0 0 0.6];
rear_susp_params.Hub_Up = [-0.2 0.55 -0.05];
rear_susp_params.Hub_Low = [-0.2 0.55 -0.5];          
rear_susp_params.Hub_Steer = [0 0.52 -0.3];
rear_susp_params.Hub_Susp = [-0.2 0.55 -0.5];

mdlWS.assignin('front_susp_params',front_susp_params);
mdlWS.assignin('rear_susp_params',rear_susp_params);
%----------------------------------------------------------------

function [retVal] = TRIM_MODEL(idx)
% function to trim the model 4-suspension system 

% Display system states 
StateManager = mech_stateVectorMgr([gcs '/FRONT DOUBLE   WISHBONE/Weld']);
StateManager.StateNames;

% Define the constraints and conditions
x0 = zeros(66,1);    % intial state values

ix = []; 
u0 = []; iu = [];    % initial and index inputs    
y0 = zeros(52,1);    % intial constraints 
iy = [1:1:52]';     % index of constraints to remain true
dx0 = zeros(66,1);   % initial state derivatives 

% Trim the model 
[x,u,y,dx] = trim(gcs,x0,u0,y0,ix,iu,iy,dx0,idx); 

retVal.x = x;
retVal.dx = dx;
%----------------------------------------------------------------

function AntiSquatAnalysis()
% Subsystm callback

mdlWS = get_param(gcs,'ModelWorkspace');
ANTI_SQUAT_PARAMS();  

disp('Trimming started.........');                                                                               
cs = get_param(gcs,'ConfigurationSets');                                                                        
i = find(strcmp(get(cs.components,'Name'),'SimMechanics'));  
set(cs.components(i),'VisDuringSimulation','off');

set_param([gcs '/WORLD/Machine Environment'], 'AnalysisType', 'Trimming')                                        
idx = [9; 15; 24; 30; 32; 33; 42; 63; 65; 66];  
retVal = TRIM_MODEL(idx);          
x = retVal.x;                                                                                                    
dx = retVal.dx;                                                                                                  

mdlWS.assignin('HCInitialAngle1',x(30));
mdlWS.assignin('HCInitialAngle2',x(15));     
mdlWS.assignin('HCInitialRotation',x(33));     
mdlWS.assignin('HCInitialHeight',x(32));     

set_param([gcs '/WORLD/Machine Environment'], 'AnalysisType', 'Forward Dynamics')                                
                                                                                                                 
cs = get_param(gcs,'ConfigurationSets');                                                                        
i = find(strcmp(get(cs.components,'Name'),'SimMechanics'));  set(cs.components(i),'VisDuringSimulation','on'); 
                                                                                                                 
disp('Model trimmed');                                                                                           
disp(''); 
%----------------------------------------------------------------

function AntiDiveAnalysis()
% Subsystem callback

mdlWS = get_param(gcs,'ModelWorkspace');
ANTI_DIVE_PARAMS();                                                                                                               
disp('Trimming started.........');                                                                               
                                                                                                                 
cs = get_param(gcs,'ConfigurationSets');                                                                        
i = find(strcmp(get(cs.components,'Name'),'SimMechanics'));  set(cs.components(i),'VisDuringSimulation','off');
                                                                                                                 
set_param([gcs '/WORLD/Machine Environment'], 'AnalysisType', 'Trimming')                         
idx = [9; 15; 24; 30; 32; 33; 42; 63; 65; 66];                                                                  
retVal = TRIM_MODEL(idx);
x = retVal.x;                                                                                                    
dx = retVal.dx;

mdlWS.assignin('HCInitialAngle1',x(30));
mdlWS.assignin('HCInitialAngle2',x(15));     
mdlWS.assignin('HCInitialRotation',x(33));     
mdlWS.assignin('HCInitialHeight',x(32));                                                                                      
set_param([gcs '/WORLD/Machine Environment'], 'AnalysisType', 'Forward Dynamics')                 
                                                                                                                 
cs = get_param(gcs,'ConfigurationSets');                                                                        
i = find(strcmp(get(cs.components,'Name'),'SimMechanics'));  set(cs.components(i),'VisDuringSimulation','on'); 
                                                                                                                 
disp('Model trimmed');                                                                                           
disp('');                                                                                                       
%----------------------------------------------------------------