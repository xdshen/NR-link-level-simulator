%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: 控制信道的Polar解码
%% ==================================

function info_de = nrpdcch_de_polar(par,var,in)
    
    % 计算下编码后的比特数目 （含CRC）    
    n = par.env.dlrb_pdcch * par.env.noscrb * par.env.modu * 2/3; % 假设1/3的导频开销
    
    % TODO: 请用正确的Polar代码更新下面的simple padding的办法      
    info_de = [in(1:par.env.n_bit_dci);in(end-par.env.n_crc+1:end)];%在中间padding 0
    
end
