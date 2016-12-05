%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: 返回默认的环境变量
%% ==================================

function [ par ] = default_par( )    
    par.sim = [];        
    par.sim.steps =100;
    par.sim.seed = 12345;
    
    
    par.env = [];    
    par.env.n_bit_dci = 60;
    par.env.crc16 =  [ 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 1];
    par.env.n_crc = length(par.env.crc16) - 1;
    
    
    par.env.dlrb = 100; % 下行总的RB数目
    par.env.dlrb_pdcch = 5; % PDCCH占用的等效RB数目
    par.env.noscrb = 12;    % 每RB的子载波数目
    par.env.dlsc = par.env.dlrb * par.env.noscrb;   % 下行总子载波数目
    par.env.modu = 2;   % 调制编码方式

    par.env.nosymslot =7; %每个slot包含的符号数目；
    
    par.env.fad = 1; % 衰落信道模型
    
    par.env.cnr = -10;  % 信噪比 [dB]
    
    
    
    

end

