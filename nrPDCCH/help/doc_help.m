%% 帮助文档
%% 各个目录的含义

% libs：存放系统的文件，一般情况下不需要更改；
% scripts：存放用户写的各个模块的文件；（用户）
% results: 仿真结果的文件；
% help: 帮助文档；
% bin：动态生成的脚本的目录（系统）


%% 主要的参数

% environment_parameters        -> par 是环境变量
% par说明如下：
% env                           -> par.env.xxx 主要存一些在仿真过程中不发生变换的固定参数（用户）
% sim                           -> par.sim.xxx 主要存一些和仿真配置有关的参数；（系统）


% dynamic_global_var            -> gvar 动态的全局变量
% gvar说明如下：
% stored                        -> gvar.sim.stored.xxx 存储的过程变量（系统）
% last                          -> gvar.sim.last.xxx   存储的上一个step过程的变量（系统）
% stored                        -> gvar.env.stored.xxx 存储的过程变量(用户)
% last                          -> gvar.env.last.xxx   存储的上一个step过程的变量（用户）













