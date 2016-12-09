%% ----------------------------------
% | 【Description】 ClockCount
% | 【Create】2016-12-09
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-09
% ----------------------------------
% Clock的单位是[s];

function [gvar] = clock_counter(par,gvar)
    persistent totalnumSlot_clock_counter;         
    if isempty(totalnumSlot_clock_counter)
        totalnumSlot_clock_counter = 0;
    else
        totalnumSlot_clock_counter = totalnumSlot_clock_counter+1;    % Update total slot number
    end
    
    nSample = sum(par.env.dlFFTsize + par.env.dlcp);
    gvar.sim.stored.t = gvar.sim.stored.t + par.env.dlTs * nSample;    

end