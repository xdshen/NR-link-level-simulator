%% ----------------------------------
% | ��Description�� NR-PDCCH RE Mapping
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------
function [info_re, gvar]= nrpdcch_remap(par,gvar,info)
    % ����һ�����󣬵�һά�����ز����ڶ�ά�Ƿ��ţ�����ά��port������ά����ɣ�    

    % TODO: ��Ҫ��������PDCCHӳ�䷽��
    
    % =======================
    % ��ʼ��
    info_re = complex(zeros([   par.env.dlnosc, ...
                                par.env.dlnosymslot, ...
                                par.env.nlayer ...
                                ]));
    
    % =======================
    % 1. ��ӳ��data
    info_re(par.env.REmapping(:,1,1),1,1) = info;
    
    % =======================
    % 2. ��ӳ�䵼Ƶ
    % TODO:
    gvar.env.stored.crs = nrcrs_gen(par,gvar); % ��CRS���д洢�������ʱ������
    info_re(par.env.RSmapping(:,1,1),1,1) = gvar.env.stored.crs(par.env.RSmapping(:,1,1));  % ֻӳ�䵽��һ������      
    
end