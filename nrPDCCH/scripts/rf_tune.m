%% ----------------------------------
% | ��Description�� ������
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------
%
% ���ݷ��͵���RF���ؽ��գ�

function rxMask = rf_tune(par,gvar,txMask)
% NOTE�����Ͷ���һ�����߷��ͣ���ô���ն˵��������߶�Ҫ�򿪽���
    rxMask = repmat(logical(sum(txMask,2)),[1 par.env.nRx]);
end