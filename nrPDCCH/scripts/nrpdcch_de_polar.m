%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: �����ŵ���Polar����
%% ==================================

function info_de = nrpdcch_de_polar(par,var,in)
    
    % �����±����ı�����Ŀ ����CRC��    
    n = par.env.dlrb_pdcch * par.env.noscrb * par.env.modu * 2/3; % ����1/3�ĵ�Ƶ����
    
    % TODO: ������ȷ��Polar������������simple padding�İ취      
    info_de = [in(1:par.env.n_bit_dci);in(end-par.env.n_crc+1:end)];%���м�padding 0
    
end
