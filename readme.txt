诚聘Matlab/simulink开发人员研究下述项目：

内燃机是可再生能源冷热电机组的核心装置，下面是一些内燃机仿真例子。
(请淘宝卖家或各位开发人员报告下面第2题-单缸内燃机系统Simulink仿真的开发价格)

1，Matlab自带的四缸内燃机系统Simulink仿真

文件夹位置：E:\Program Files\MATLAB\R2008a\toolbox\physmod\mech\mechdemos

文件名：mech_fceng.mdl

Matlab命令名：mech_fceng

四缸内燃机系统Simulink仿真模型概述：

四缸内燃机系统simulink仿真模型包含以下5大系统8大模块共125个基本块：
1)四个气缸模块：Cylinder1、Cylinder2、Cylinder3、Cylinder4。每个汽缸模块Cylinder又包含热力学模块Thermodynamic model和其他17个基本块。热力学模块Thermodynamic model包含吸气Suction、压缩Compression、做功Power、排气Exhaust模块和其他16个基本块。做功Power包含燃烧Combustion、理想膨胀IdealExpansion和其他8个基本块。燃烧Combustion模块包含13个基本块。理想膨胀IdealExpansion模块包含10个基本块。吸气Suction、排气Exhaust模块都包含4个基本块，压缩Compression模块包含5个基本块。每个汽缸模块含有69个基本块。
2)曲轴引擎模块：Engine Block。它包含引擎正时模块Engine Timer、摩擦Friction模块、其他11个基本块。引擎正时模块Engine Timer包含点火控制模块Ignition Control和其他6个基本块。摩擦Friction模块包含9个基本块。点火控制模块Ignition Control是1个状态流图，包含4个状态和1个状态转换函数、1个初始入口。曲轴引擎模块含有26个基本块。
3)转速表模块：Tachometer。它包含8个基本块。
4)控制模块：Control。它包含9个基本块。
5)熄火模块：Stall。它包含10个基本块。


2，单缸内燃机系统Simulink仿真

请修改上面例题1四缸机的仿真模型，改为单缸机仿真模型。(开发要求：按下面列出的单缸内燃机系统Simulink仿真模型概述要求开发，单缸机仿真文件必须存放在四缸机仿真文件所在的文件夹，如例题1所示，且不能干扰四缸机仿真命令mech_fceng运行。模型动画部分应单独报价，本次开发不需要动画)

文件名：mech_sceng.mdl

Matlab命令名：mech_sceng

单缸内燃机系统Simulink仿真模型概述：

单缸内燃机系统simulink仿真模型包含以下5大系统5大模块共122个基本块：
1)气缸模块：Cylinder1(去掉四缸机的汽缸2~4模块，剩下汽缸1模块Cylinder1)。每个汽缸模块Cylinder又包含热力学模块Thermodynamic model和其他17个基本块。热力学模块Thermodynamic model包含吸气Suction、压缩Compression、做功Power、排气Exhaust模块和其他16个基本块。做功Power包含燃烧Combustion、理想膨胀IdealExpansion和其他8个基本块。燃烧Combustion模块包含13个基本块。理想膨胀IdealExpansion模块包含10个基本块。吸气Suction、排气Exhaust模块都包含4个基本块，压缩Compression模块包含5个基本块。每个汽缸模块含有69个基本块。
2)曲轴引擎模块：Engine Block。它包含引擎正时模块Engine Timer、摩擦Friction模块、其他11个基本块。引擎正时模块Engine Timer包含点火控制模块Ignition Control和其他6个基本块。摩擦Friction模块包含9个基本块。点火控制模块Ignition Control是1个状态流图，包含4个状态和1个状态转换函数、1个初始入口。曲轴引擎模块含有26个基本块。
3)转速表模块：Tachometer。它包含8个基本块。
4)控制模块：Control。它包含9个基本块。
5)熄火模块：Stall。它包含10个基本块。

下面的链接包含单缸内燃机系统simulink仿真模型的所有122个模块，但运行仿真时Engine RPM转速不正确。请调试、修改Simulink模型，获得类似fceng.jpg的转速结果(四缸机稳定后为800rpm左右，单缸机转速应该低于此数值)。
