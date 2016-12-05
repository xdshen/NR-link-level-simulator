%% ----------------------------------
% | 【Description】 校验CRC比特
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
function [info,crc, err_flag] = nrpdcch_removecrc(par,gvar,in)     
    persistent hCRC;
    if isempty(hCRC)
        hCRC = comm.CRCGenerator(par.env.crc16,'FinalXOR',1);
    end    
    info = in(1:end-par.env.n_crc);
    checkinfocrc = step(hCRC,info);    
    check_crc =  checkinfocrc(end-par.env.n_crc+1:end);
    crc = in(end-par.env.n_crc+1:end);
    err_flag = (sum(xor(crc, check_crc))>0);    
        
end