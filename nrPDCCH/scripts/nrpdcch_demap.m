%% ----------------------------------
% | ��Description�� NR-PDCCH RE Demapping
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------
function [info_re, gvar]= nrpdcch_demap(par,gvar,in)

   % TODO: ��Ҫ��������PDCCHӳ�䷽��
    
    % =======================
    % ��ʼ��

       
    % =======================
    % 1. ��ӳ�䵼Ƶ
    % TODO:
    % �ѵ�Ƶ�浽gvar֮��
    gvar.env.last.crs = complex(zeros([   par.env.dlnosc, ...
                                par.env.dlnosymslot, ...
                                par.env.nlayer ...
                                ]));
    gvar.env.last.crs = in(par.env.RSmapping(:,1,1),1,1);% RS

    
    % =======================
    % 2. ӳ��data
    info_re = in(par.env.REmapping(:,1,1),1,1); % NR-PDCCH

    
end