%% ----------------------------------
% | ��Description�� ��ʼ����������
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------
function [ par ] = init_par(par)

    % �������
    par.sim.randStream.channel_param = RandStream('mt19937ar','Seed',par.sim.seed.channel_param_seed);
    par.sim.randStream.noise = RandStream('mt19937ar','Seed',par.sim.seed.noise_seed);
    par.sim.randStream.data = RandStream('mt19937ar','Seed',par.sim.seed.data_seed);
    par.sim.randStream.scheduler = RandStream('mt19937ar','Seed',par.sim.seed.scheduler_seed);
    
    
    %% �ŵ����
    % calculate channe Matrix
    switch par.env.chmod.fad
        case {'TDL-A','TDL-B','TDL-C','TDL-D','TDL-E'}
            % �����TDLģ�ͣ�������ʱ������壻
            par.env.chmod.taps = cal_channel_matrix_tdl(par.env.chmod.taps_t, par.env.dlTs, par.env.chmod.DSdisired, 'Normalized');    
        case 'awgn'
            par.env.chmod.taps = cal_channel_matrix_tdl(par.env.chmod.taps_t, par.env.dlTs, par.env.chmod.DSdisired, 'Normalized');    
    end
    
    %% ��Դӳ�����
    % initialize RE mapping
    % NR-PDCCH��Դӳ��    (ֻӳ�䵽��һ������)
    perRB = [1 0 1 1 0 1 1 0 1 1 0 1]';
    selectedRB_idx = randperm(par.sim.randStream.scheduler,par.env.dlrb,par.env.dlrb_pdcch); % ���ѡ��5��PRB ;
    selectedRB = false(par.env.dlrb,1);
    selectedRB(selectedRB_idx)=true;
    permute_selectedRB = logical(kron(selectedRB, perRB));
    par.env.REmapping = false(par.env.dlnosc, par.env.dlnosymslot, par.env.nlayer);
    par.env.REmapping(permute_selectedRB,1,1) = true; % TODO �˴�Ҫ�������Ƿ���ȷ
    par.env.REmapping_rb = false(par.env.dlrb, par.env.dlnosymslot, par.env.nlayer); % ռ�õ�RB�ı��
    par.env.REmapping_rb(selectedRB,1,1) = true;    
    
    % RSӳ��
    perRBrs = not(perRB);
    % TODO��ֻ֧�ֵ��������������δ���;    
    selectedRB = false(par.env.dlrb,1); 
    selectedRB(selectedRB_idx)=true;
    permute_selectedRBrs = logical(kron(selectedRB, perRBrs));    
    par.env.RSmapping = false(par.env.dlnosc, par.env.dlnosymslot, par.env.nlayer);
    par.env.RSmapping(permute_selectedRBrs,1,1) = true; % TODO �˴�Ҫ�������Ƿ���ȷ
    par.env.RSmapping_rb = false(par.env.dlrb, par.env.dlnosymslot, par.env.nlayer);
    par.env.RSmapping_rb(selectedRB,1,1) = true; % RS ռ�õ�RB�ı��
        
    % RS ����
    par.env.RSlen = sum(par.env.RSmapping,1)';% nLayer * ������Ŀ,��ʾÿ�����ŵĵ�Ƶ���еĳ���; ����ȡת����Ϊ�˱�֤�õ��ľ���ĵ�һά����symbol���ڶ�ά����layer��

    
end

