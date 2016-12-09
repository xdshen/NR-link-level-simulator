%% ----------------------------------
% | 【Description】 返回默认的环境变量
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
function [ par ] = default_par( )    

    par.sim = [];        
    par.sim.steps =1000;
    par.sim.seed.channel_param_seed = 12345;
    par.sim.seed.noise_seed = 4324;
    par.sim.seed.data_seed = 123465;
    par.sim.seed.scheduler_seed = 873;
        
    par.env = [];   
    
    %% L1信令设计相关的参数
    par.env.n_bit_dci = 30;
    par.env.crc16 =  [ 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 1];
    par.env.n_crc = length(par.env.crc16) - 1;
    
    par.env.Ncellid = 0;
    
    
    %% MIMO相关
    par.env.nlayer = 1; % 传输的层数，对于控制信道设置为1
    

    %% RS相关
        
    
    %% numberlogy相关的参数
    par.env.dlrb = 100; % 下行总的RB数目
    par.env.dlrb_pdcch = 5; % PDCCH占用的等效RB数目
    par.env.dlscrb = 12;    % 每RB的子载波数目
    par.env.dlnosc = par.env.dlrb * par.env.dlscrb;   % 下行总子载波数目
    par.env.dlmodu = 2;   % 调制编码方式
    par.env.dlnosymslot =14; %每个slot包含的符号数目；
    par.env.dlscs = 15e3; %子载波间隔；           
    % dlFFTsize: FFT size（依赖）
    % dlTs: 采样点的持续时间（依赖）
    % dlcp: OFDM Cyclic Prefix的长度（依赖）    
    [par.env.dlFFTsize,par.env.dlTs,par.env.dlcp] = cal_ofdm_numerology(par.env.dlscs,par.env.dlrb,par.env.dlnosymslot);   
    % NR-PDCCH资源映射    
    par.env.REmapping = zeros(par.env.dlnosc,par.env.nlayer ) ;
    
    
    %% RF 相关的参数
    par.env.cnr = -12;  % 信噪比 [dB]
    par.env.freq = 2e9; % RF 中心频点
    par.env.txEPRE = 1; % power boosting (线性值）
    
    par.env.nTx = 1; % 发送天线数目
    par.env.nRx = 1; % 接收天线数目
    
    
    %% 信道模型相关的参数
    par.env.c = 299792458; % 光速
    par.env.user_speed = 3/3.6; % 3km/h   
    par.env.carrierfreq = 2e9;  % 2GHz信道模型 [Hz]
    par.env.max_doppler = par.env.user_speed * par.env.carrierfreq / par.env.c; % 最大多普勒
    par.env.carrierlambda = par.env.c / par.env.carrierfreq;
    par.env.doppler_theta = 0; % 多普勒频移中运动方向和来多方向的夹角度
    
    % 衰落信道模型定义的参数
    
    % add Winner Model code path
    
    
    par.env.chmod.fad = 'TDL-C'; % 衰落信道模型  TDL-A, TDL-B, TDL-C, 'awgn'
    par.env.chmod.fad2 = 3; % 衰落信道模型index（依赖）
    % load par.env.chmod.taps (依赖)
    switch par.env.chmod.fad
        case {'TDL-A','TDL-B','TDL-C','TDL-D','TDL-E'}
            % 采用taps =[delay(us), power(dB)]的数组
            tmp =load(['.\channelmodel\' par.env.chmod.fad]);    
            par.env.chmod.taps_t = tmp.taps;
            par.env.chmod.DSdisired = 10; % very short delay [ns]
        case 'awgn'
            par.env.chmod.taps_t = [0,0];
            par.env.chmod.DSdisired = 10; % very short delay [ns]
    end
    
    par.env.chmod.filtering = 'BlockFading'; % 'BlockFading','FastFading';
    par.env.chmod.filtering2 = 1;% 1,2（依赖）
    
    par.env.chmod.type = 'awgn'; % 'awgn','flat Rayleigh'
    par.env.chmod.type2 = 1;%（依赖）
        

            
    
    
    %% 算法相关
    % TODO MMSE和LMMSE算法现在还不支持，只支持ZF
    par.env.ce = 'ZF'; % MMSE, ZF, ML
    
end

