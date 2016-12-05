%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: 生成NR-PDCCH的信息比特
%% ==================================

function info  = nrpdcch_source(par,gvar)

    persistent init;
    if isempty(init)
        init = 1;
        rng(par.sim.seed);
    end

    info = logical(randi([0 1], [par.env.n_bit_dci 1]));

end