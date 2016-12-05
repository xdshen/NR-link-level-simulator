%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: NR Channel 
%% ==================================

function [y] = nr_channel(par,gvar,in, RxMask)
    
    % TODO
    % nVar干扰功率(线性值);
    
    % noisepwr 是接收子载波包含的干扰的功率   
    y = zeros(size(in));
    y(RxMask) = awgn(in(RxMask),par.env.cnr - lin2db(par.env.dlrb/par.env.dlrb_pdcch),'measured');
          
end