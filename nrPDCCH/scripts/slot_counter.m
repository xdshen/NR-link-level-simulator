%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: Ö÷º¯Êý
%% ==================================

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