%% ----------------------------------
% | ��Description�� �����ŵ����ƵĽ�����
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------

function [out, gvar] = nrpdcch_demod(par,gvar,in)

    % �����ŵ����ƣ�
    % stored H_crs_est in the gvar.env.stored.H_crs_est;
	gvar.env.stored.H_crs_est = nrcrs_channelestimation(par,gvar,in);   
    
    % �ָ����ݣ�
    out = complex(zeros(size(in)));
    out(par.env.REmapping) = in(par.env.REmapping) ./ gvar.env.stored.H_crs_est(par.env.REmapping) ; 
    