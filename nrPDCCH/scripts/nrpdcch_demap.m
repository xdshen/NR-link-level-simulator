%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: NR-PDCCH RE Demapping
%% ==================================

function [info rs ]= nrpdcch_demap(par,gvar,in)

   % TODO: 需要补充具体的PDCCH映射方法
    
    % =======================
    % 初始化
    info_re = complex(zeros([par.env.dlsc,par.env.nosymslot,1]));
    
    % =======================
    % 1. 先映射导频
    % TODO:
    rs=[];
    
    % =======================
    % 2. 映射data
    % 简单的把PDCCH映射到边上的RB
    indices = [1 0 1 1 0 1 1 0 1 1 0 1]'; % 0是导频的位置
    all = repmat(indices, [1 par.env.dlrb_pdcch]); 
    all = all(:);
    info = in(find(all==1),1,1);
    
end