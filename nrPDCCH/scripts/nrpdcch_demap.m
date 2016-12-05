%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: NR-PDCCH RE Demapping
%% ==================================

function [info rs ]= nrpdcch_demap(par,gvar,in)

   % TODO: ��Ҫ��������PDCCHӳ�䷽��
    
    % =======================
    % ��ʼ��
    info_re = complex(zeros([par.env.dlsc,par.env.nosymslot,1]));
    
    % =======================
    % 1. ��ӳ�䵼Ƶ
    % TODO:
    rs=[];
    
    % =======================
    % 2. ӳ��data
    % �򵥵İ�PDCCHӳ�䵽���ϵ�RB
    indices = [1 0 1 1 0 1 1 0 1 1 0 1]'; % 0�ǵ�Ƶ��λ��
    all = repmat(indices, [1 par.env.dlrb_pdcch]); 
    all = all(:);
    info = in(find(all==1),1,1);
    
end