%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: NR-PDCCH RE Mapping
%% ==================================

function info_re = nrpdcch_remap(par,gvar,info,rs)
    % ����һ�����󣬵�һά�����ز����ڶ�ά�Ƿ��ţ�����ά�����ߣ�����ά����ɣ�    

    % TODO: ��Ҫ��������PDCCHӳ�䷽��
    
    % =======================
    % ��ʼ��
    info_re = complex(zeros([par.env.dlsc,par.env.nosymslot,1]));
    
    % =======================
    % 1. ��ӳ��data
    % �򵥵İ�PDCCHӳ�䵽���ϵ�RB
    indices = [1 0 1 1 0 1 1 0 1 1 0 1]'; % 0�ǵ�Ƶ��λ��
    all = repmat(indices, [1 par.env.dlrb_pdcch]); 
    all = all(:);
    info_re(find(all==1),1,1) = info;
    
    
    % =======================
    % 2. ��ӳ�䵼Ƶ
    % TODO:
    
end