%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: �����ŵ���Polar����
%% ==================================

function info_en = nrpdcch_en_polar(par,var,info)
    
    % �����±����ı�����Ŀ ����CRC��    
    n = par.env.dlrb_pdcch * par.env.noscrb * par.env.modu * 2/3; % ����1/3�ĵ�Ƶ����
    
    % TODO: ������ȷ��Polar������������simple padding�İ취
    info_en = [info(1:end - par.env.n_crc); ...
        logical(zeros(n - par.env.n_crc - par.env.n_bit_dci,1)); ...     %���м�padding 0
        info(end -  par.env.n_crc +1:end)];    
    
end
