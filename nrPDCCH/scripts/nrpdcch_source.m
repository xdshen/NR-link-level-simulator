%% ----------------------------------
% | ��Description�� ����NR-PDCCH����Ϣ����
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------
function info  = nrpdcch_source(par,gvar)

    info = logical(randi(par.sim.randStream.data, [0 1], [par.env.n_bit_dci 1]));

end