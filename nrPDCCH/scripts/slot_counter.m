%% ----------------------------------
% | 【Description】 slotCount生成slot编号
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
% 示例用法：
% nT便是总共的slot数目；
% nS按照每隔20个slot循环一次计数；

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