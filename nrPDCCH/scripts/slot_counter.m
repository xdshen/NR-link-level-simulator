%% ----------------------------------
% | ��Description�� slotCount����slot���
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------
% ʾ���÷���
% nT�����ܹ���slot��Ŀ��
% nS����ÿ��20��slotѭ��һ�μ�����

function [gvar] = slot_counter(par,gvar)

    persistent totalnumSlot;         
    if isempty(totalnumSlot)
        totalnumSlot = 0;
    else
        totalnumSlot = totalnumSlot+1;    % Update total slot number
    end
    gvar.env.stored.nT = totalnumSlot;
    gvar.env.stored.nS = mod(totalnumSlot,20);
    

end