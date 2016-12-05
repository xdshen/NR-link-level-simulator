%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: 主函数
%% ==================================

%
% IMPORTANT：运行之前请阅读帮助文档！！！
%


function result = main(par,gvar)
    if nargin<=0
        % 初始化par
        par= default_par();
        par = init_par(par);
    end
    if nargin<=1
        % 初始化gvar
        gvar = default_gvar(par);
        gvar = init_gvar(par,gvar);
    end
    % 初始化
    hBER = comm.ErrorRate;
    hBLER = comm.ErrorRate;
    result = [];
    result.par =par;
    
    
    for ii = 1: par.sim.steps    
        gvar.sim.store.step = ii;       % 更新当前的step数目
        
        % TODO: 清理gvar.sim.stored 和gvar.env.stored        
        
        [gvar] = slot_counter(par,gvar);    % 更新slot计数器
        
        % ======================================
        % 1. 以下为发送流程
        % ======================================
        dataIn = nrpdcch_source(par,gvar);   % 
        
        info = nrpdcch_addcrc(par,gvar,dataIn);
        
        info = nrpdcch_en_polar(par,gvar,info);
        
        info = nrpdcch_interleave(par,gvar,info); % TODO
        
        info = nrpdcch_scrambling(par,gvar,info);   % TODO
        
        info = rectqam(par,gvar,info);
        
        info = nrpdcch_remap(par,gvar,info,[]);
        
        [info txMask]= nr_ofdmTx(par,gvar,info); 
        
        % ======================================        
        % 2. 经过信道
        % ======================================        
        rxMask = txMask; % 在发送的位置进行接收；（没有考虑时延）
        [out] = nr_channel(par,gvar,info,rxMask);  
        %N0 = estimateNoiseVar(info,out);
        
        % ======================================        
        % 3. 以下为接收流程
        % ======================================
        
        info = nr_ofdmRx(par,gvar,out,rxMask);
        
        info = nrpdcch_demap(par,gvar,info);
        
        info = rectdeqam(par,gvar,info,db2lin(-par.env.cnr));
        
        info = nrpdcch_descrambling(par,gvar,info);   % TODO       

        info = nrpdcch_deinterleave(par,gvar,info); % TODO        
        
        info = nrpdcch_de_polar(par,gvar,info);        
        
        [dataOut crc err_flag] = nrpdcch_removecrc(par,gvar,info);     
                
        result.errorStatsBER = step(hBER,dataIn,dataOut);
        result.errorStatsBLER = step(hBLER,logical(0),err_flag);

        
    end
%         fprintf('\nBER = %f\nNumber of errors = %d\nNumber of bits = %d\n', ...
%             result.errorStatsBER)
%         fprintf('\nBLER = %f\nNumber of errors = %d\nNumber of blocks = %d\n', ...
%             result.errorStatsBLER)
end