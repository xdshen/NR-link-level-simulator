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

    persistent totalnumSlot_slot_count;         
    if isempty(totalnumSlot_slot_count)
        totalnumSlot_slot_count = 0;
    else
        totalnumSlot_slot_count = totalnumSlot_slot_count+1;    % Update total slot number
    end
    gvar.env.stored.nT = totalnumSlot_slot_count;
    gvar.env.stored.nS = mod(totalnumSlot_slot_count,20);
    

end