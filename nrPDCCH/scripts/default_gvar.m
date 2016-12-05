%% ----------------------------------
% | 【Description】 返回默认的动态变量
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
function [ gvar ] = default_gvar( par )
    gvar.sim.stored = [];
    gvar.sim.stored.step = 0;

    gvar.sim.last = []; 
    
    gvar.env.stored = [];
    gvar.env.stored.nT = 0;
    gvar.env.stored.nS = 0;
    
    gvar.env.last = []; 
end

