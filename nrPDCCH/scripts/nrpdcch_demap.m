%% ----------------------------------
% | 【Description】 NR-PDCCH RE Demapping
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
function [info_re, gvar]= nrpdcch_demap(par,gvar,in)

   % TODO: 需要补充具体的PDCCH映射方法
    
    % =======================
    % 初始化

       
    % =======================
    % 1. 先映射导频
    % TODO:
    % 把导频存到gvar之中
    gvar.env.last.crs = complex(zeros([   par.env.dlnosc, ...
                                par.env.dlnosymslot, ...
                                par.env.nlayer ...
                                ]));
    gvar.env.last.crs = in(par.env.RSmapping(:,1,1),1,1);% RS

    
    % =======================
    % 2. 映射data
    info_re = in(par.env.REmapping(:,1,1),1,1); % NR-PDCCH

    
end