%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: ����Ĭ�ϵĶ�̬����
%% ==================================
function [ gvar ] = default_gvar( par )
    gvar.sim.stored = [];
    gvar.sim.stored.step = 0;

    gvar.sim.last = []; 
    
    gvar.env.stored = [];
    gvar.env.stored.nT = 0;
    gvar.env.stored.nS = 0;
    
    gvar.env.last = []; 
end
