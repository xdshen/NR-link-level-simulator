%% ----------------------------------
% | 【Description】 根据信道估计的结果解调
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------

function [out, gvar] = nrpdcch_demod(par,gvar,in)

    % 先做信道估计；
    % stored H_crs_est in the gvar.env.stored.H_crs_est;
	gvar.env.stored.H_crs_est = nrcrs_channelestimation(par,gvar,in);   
    
    % 恢复数据；
    out = complex(zeros(size(in)));
    out(par.env.REmapping) = in(par.env.REmapping) ./ gvar.env.stored.H_crs_est(par.env.REmapping) ; 
    