%% ----------------------------------
% | 【Description】 初始化环境变量
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
function [ par ] = init_par(par)

    % 仿真相关
    par.sim.randStream.channel_param = RandStream('mt19937ar','Seed',par.sim.seed.channel_param_seed);
    par.sim.randStream.noise = RandStream('mt19937ar','Seed',par.sim.seed.noise_seed);
    par.sim.randStream.data = RandStream('mt19937ar','Seed',par.sim.seed.data_seed);
    par.sim.randStream.scheduler = RandStream('mt19937ar','Seed',par.sim.seed.scheduler_seed);
    
    
    %% 信道相关
    % calculate channe Matrix
    switch par.env.chmod.fad
        case {'TDL-A','TDL-B','TDL-C','TDL-D','TDL-E'}
            % 如果是TDL模型，计算其时域的脉冲；
            par.env.chmod.taps = cal_channel_matrix_tdl(par.env.chmod.taps_t, par.env.dlTs, par.env.chmod.DSdisired, 'Normalized');    
        case 'awgn'
            par.env.chmod.taps = cal_channel_matrix_tdl(par.env.chmod.taps_t, par.env.dlTs, par.env.chmod.DSdisired, 'Normalized');    
    end
    
    %% 资源映射相关
    % initialize RE mapping
    % NR-PDCCH资源映射    (只映射到第一个符号)
    perRB = [1 0 1 1 0 1 1 0 1 1 0 1]';
    selectedRB_idx = randperm(par.sim.randStream.scheduler,par.env.dlrb,par.env.dlrb_pdcch); % 随机选择5个PRB ;
    selectedRB = false(par.env.dlrb,1);
    selectedRB(selectedRB_idx)=true;
    permute_selectedRB = logical(kron(selectedRB, perRB));
    par.env.REmapping = false(par.env.dlnosc, par.env.dlnosymslot, par.env.nlayer);
    par.env.REmapping(permute_selectedRB,1,1) = true; % TODO 此处要检查代码是否正确
    par.env.REmapping_rb = false(par.env.dlrb, par.env.dlnosymslot, par.env.nlayer); % 占用的RB的编号
    par.env.REmapping_rb(selectedRB,1,1) = true;    
    
    % RS映射
    perRBrs = not(perRB);
    % TODO：只支持单流，多流的情况未完成;    
    selectedRB = false(par.env.dlrb,1); 
    selectedRB(selectedRB_idx)=true;
    permute_selectedRBrs = logical(kron(selectedRB, perRBrs));    
    par.env.RSmapping = false(par.env.dlnosc, par.env.dlnosymslot, par.env.nlayer);
    par.env.RSmapping(permute_selectedRBrs,1,1) = true; % TODO 此处要检查代码是否正确
    par.env.RSmapping_rb = false(par.env.dlrb, par.env.dlnosymslot, par.env.nlayer);
    par.env.RSmapping_rb(selectedRB,1,1) = true; % RS 占用的RB的编号
        
    % RS 序列
    par.env.RSlen = sum(par.env.RSmapping,1)';% nLayer * 符号数目,表示每个符号的导频序列的长度; 这里取转置是为了保证得到的矩阵的第一维度是symbol，第二维度是layer；

    
end

