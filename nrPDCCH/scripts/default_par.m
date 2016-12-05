%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: ����Ĭ�ϵĻ�������
%% ==================================

function [ par ] = default_par( )    
    par.sim = [];        
    par.sim.steps =100;
    par.sim.seed = 12345;
    
    
    par.env = [];    
    par.env.n_bit_dci = 60;
    par.env.crc16 =  [ 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 1];
    par.env.n_crc = length(par.env.crc16) - 1;
    
    
    par.env.dlrb = 100; % �����ܵ�RB��Ŀ
    par.env.dlrb_pdcch = 5; % PDCCHռ�õĵ�ЧRB��Ŀ
    par.env.noscrb = 12;    % ÿRB�����ز���Ŀ
    par.env.dlsc = par.env.dlrb * par.env.noscrb;   % ���������ز���Ŀ
    par.env.modu = 2;   % ���Ʊ��뷽ʽ

    par.env.nosymslot =7; %ÿ��slot�����ķ�����Ŀ��
    
    par.env.fad = 1; % ˥���ŵ�ģ��
    
    par.env.cnr = -10;  % ����� [dB]
    
    
    
    

end

