%% ----------------------------------
% | 【Description】 控制信道的Polar编码
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
function info_en = nrpdcch_en_polar(par,var,info)
    
    % 计算下编码后的比特数目 （含CRC）    
    n = par.env.dlrb_pdcch * par.env.dlscrb * par.env.dlmodu * 2/3; % 假设1/3的导频开销
    
    % TODO: 请用正确的Polar代码更新下面的simple padding的办法
    info_en = [info(1:end - par.env.n_crc); ...
        logical(zeros(n - par.env.n_crc - par.env.n_bit_dci,1)); ...     %在中间padding 0
        info(end -  par.env.n_crc +1:end)];    
    
end
