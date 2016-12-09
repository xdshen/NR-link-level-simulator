%% ----------------------------------
% | 【Description】 NR-PDCCH RE Mapping
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
function [info_re, gvar]= nrpdcch_remap(par,gvar,info)
    % 返回一个矩阵，第一维是子载波，第二维是符号，第三维是port（第三维待完成）    

    % TODO: 需要补充具体的PDCCH映射方法
    
    % =======================
    % 初始化
    info_re = complex(zeros([   par.env.dlnosc, ...
                                par.env.dlnosymslot, ...
                                par.env.nlayer ...
                                ]));
    
    % =======================
    % 1. 先映射data
    info_re(par.env.REmapping(:,1,1),1,1) = info;
    
    % =======================
    % 2. 再映射导频
    % TODO:
    gvar.env.stored.crs = nrcrs_gen(par,gvar); % 将CRS序列存储供解调的时候适用
    info_re(par.env.RSmapping(:,1,1),1,1) = gvar.env.stored.crs(par.env.RSmapping(:,1,1));  % 只映射到第一个符号      
    
end