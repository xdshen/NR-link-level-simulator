%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: ������
%% ==================================

%
% IMPORTANT������֮ǰ���Ķ������ĵ�������
%


function result = main(par,gvar)
    if nargin<=0
        % ��ʼ��par
        par= default_par();
        par = init_par(par);
    end
    if nargin<=1
        % ��ʼ��gvar
        gvar = default_gvar(par);
        gvar = init_gvar(par,gvar);
    end
    % ��ʼ��
    hBER = comm.ErrorRate;
    hBLER = comm.ErrorRate;
    result = [];
    result.par =par;
    
    
    for ii = 1: par.sim.steps    
        gvar.sim.store.step = ii;       % ���µ�ǰ��step��Ŀ
        
        % TODO: ����gvar.sim.stored ��gvar.env.stored        
        
        [gvar] = slot_counter(par,gvar);    % ����slot������
        
        % ======================================
        % 1. ����Ϊ��������
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
        % 2. �����ŵ�
        % ======================================        
        rxMask = txMask; % �ڷ��͵�λ�ý��н��գ���û�п���ʱ�ӣ�
        [out] = nr_channel(par,gvar,info,rxMask);  
        %N0 = estimateNoiseVar(info,out);
        
        % ======================================        
        % 3. ����Ϊ��������
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