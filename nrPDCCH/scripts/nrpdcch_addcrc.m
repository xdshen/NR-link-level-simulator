%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: ����CRC����
%% ==================================

function info_crc = nrpdcch_addcrc(par,gvar,info)    
    persistent hCRC;
    if isempty(hCRC)
        hCRC = comm.CRCGenerator(par.env.crc16,'FinalXOR',1);
    end     
    info_crc = step(hCRC, info);    
    
end
