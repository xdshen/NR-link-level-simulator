%% ----------------------------------
% | ��Description�� ����Ĭ�ϵĻ�������
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------
function [ par ] = default_par( )    

    par.sim = [];        
    par.sim.steps =1000;
    par.sim.seed.channel_param_seed = 12345;
    par.sim.seed.noise_seed = 4324;
    par.sim.seed.data_seed = 123465;
    par.sim.seed.scheduler_seed = 873;
        
    par.env = [];   
    
    %% L1���������صĲ���
    par.env.n_bit_dci = 30;
    par.env.crc16 =  [ 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 1];
    par.env.n_crc = length(par.env.crc16) - 1;
    
    par.env.Ncellid = 0;
    
    
    %% MIMO���
    par.env.nlayer = 1; % ����Ĳ��������ڿ����ŵ�����Ϊ1
    

    %% RS���
        
    
    %% numberlogy��صĲ���
    par.env.dlrb = 100; % �����ܵ�RB��Ŀ
    par.env.dlrb_pdcch = 5; % PDCCHռ�õĵ�ЧRB��Ŀ
    par.env.dlscrb = 12;    % ÿRB�����ز���Ŀ
    par.env.dlnosc = par.env.dlrb * par.env.dlscrb;   % ���������ز���Ŀ
    par.env.dlmodu = 2;   % ���Ʊ��뷽ʽ
    par.env.dlnosymslot =14; %ÿ��slot�����ķ�����Ŀ��
    par.env.dlscs = 15e3; %���ز������           
    % dlFFTsize: FFT size��������
    % dlTs: ������ĳ���ʱ�䣨������
    % dlcp: OFDM Cyclic Prefix�ĳ��ȣ�������    
    [par.env.dlFFTsize,par.env.dlTs,par.env.dlcp] = cal_ofdm_numerology(par.env.dlscs,par.env.dlrb,par.env.dlnosymslot);   
    % NR-PDCCH��Դӳ��    
    par.env.REmapping = zeros(par.env.dlnosc,par.env.nlayer ) ;
    
    
    %% RF ��صĲ���
    par.env.cnr = -12;  % ����� [dB]
    par.env.freq = 2e9; % RF ����Ƶ��
    par.env.txEPRE = 1; % power boosting (����ֵ��
    
    par.env.nTx = 1; % ����������Ŀ
    par.env.nRx = 1; % ����������Ŀ
    
    
    %% �ŵ�ģ����صĲ���
    par.env.c = 299792458; % ����
    par.env.user_speed = 3/3.6; % 3km/h   
    par.env.carrierfreq = 2e9;  % 2GHz�ŵ�ģ�� [Hz]
    par.env.max_doppler = par.env.user_speed * par.env.carrierfreq / par.env.c; % ��������
    par.env.carrierlambda = par.env.c / par.env.carrierfreq;
    par.env.doppler_theta = 0; % ������Ƶ�����˶���������෽��ļнǶ�
    
    % ˥���ŵ�ģ�Ͷ���Ĳ���
    
    % add Winner Model code path
    
    
    par.env.chmod.fad = 'TDL-C'; % ˥���ŵ�ģ��  TDL-A, TDL-B, TDL-C, 'awgn'
    par.env.chmod.fad2 = 3; % ˥���ŵ�ģ��index��������
    % load par.env.chmod.taps (����)
    switch par.env.chmod.fad
        case {'TDL-A','TDL-B','TDL-C','TDL-D','TDL-E'}
            % ����taps =[delay(us), power(dB)]������
            tmp =load(['.\channelmodel\' par.env.chmod.fad]);    
            par.env.chmod.taps_t = tmp.taps;
            par.env.chmod.DSdisired = 10; % very short delay [ns]
        case 'awgn'
            par.env.chmod.taps_t = [0,0];
            par.env.chmod.DSdisired = 10; % very short delay [ns]
    end
    
    par.env.chmod.filtering = 'BlockFading'; % 'BlockFading','FastFading';
    par.env.chmod.filtering2 = 1;% 1,2��������
    
    par.env.chmod.type = 'awgn'; % 'awgn','flat Rayleigh'
    par.env.chmod.type2 = 1;%��������
        

            
    
    
    %% �㷨���
    % TODO MMSE��LMMSE�㷨���ڻ���֧�֣�ֻ֧��ZF
    par.env.ce = 'ZF'; % MMSE, ZF, ML
    
end

