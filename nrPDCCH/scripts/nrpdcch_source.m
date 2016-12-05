%% ----------------------------------
% | ��Description�� ����NR-PDCCH����Ϣ����
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------
function info  = nrpdcch_source(par,gvar)

    persistent init;
    if isempty(init)
        init = 1;
        rng(par.sim.seed);
    end

    info = logical(randi([0 1], [par.env.n_bit_dci 1]));

end