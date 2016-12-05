%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: NR-PDCCH RE Mapping
%% ==================================

function info_re = nrpdcch_remap(par,gvar,info,rs)
    % 返回一个矩阵，第一维是子载波，第二维是符号，第三维是天线（第三维待完成）    

    % TODO: 需要补充具体的PDCCH映射方法
    
    % =======================
    % 初始化
    info_re = complex(zeros([par.env.dlsc,par.env.nosymslot,1]));
    
    % =======================
    % 1. 先映射data
    % 简单的把PDCCH映射到边上的RB
    indices = [1 0 1 1 0 1 1 0 1 1 0 1]'; % 0是导频的位置
    all = repmat(indices, [1 par.env.dlrb_pdcch]); 
    all = all(:);
    info_re(find(all==1),1,1) = info;
    
    
    % =======================
    % 2. 再映射导频
    % TODO:
    
end