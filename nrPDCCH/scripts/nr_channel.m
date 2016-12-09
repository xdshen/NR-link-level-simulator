%% ----------------------------------
% | 【Description】 NR Channel 
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
% TDL信道就是 瑞利衰落 + 多径效应 + 多普勒效应
% 瑞丽衰落部分：
%   在每一次仿真的开始生成，并且在一次仿真中保持不变了。本仿真中为了减少仿真量，在仿真的一开始设定了每个径的幅度为功率值的开放，相位为0
% 多径效应部分：
%   将输入采样点与信道冲激响应作卷积得到；
% 多普勒效应部分：
%   按照公式计算相位的旋转因子exp(2 * pi * 1i * v * t / lamda * cos(theta)),
%   加到信道的复包络上，子帧的起始时刻为t0，当前时刻为t1，那么t = [t0: sample_time:t1]，不同采样点上的信道差异，由这里的t变化产生。 


function [y] = nr_channel(par,gvar,in, RxMask)
    
    % TODO:输出噪声的方差
    
    % 输出向量的大小如下：
    [nS, nTxAnt] = size(in);

    
    % TODO: 此处需要考察SNR到底是怎么加上去的    
    % -----  delete it!!!! wrong y(RxMask) = awgn(in(RxMask),par.env.cnr - lin2db(par.env.dlrb/par.env.dlrb_pdcch),'measured');
    % -----  delete it!!!! wrong y(RxMask) = awgn(in(RxMask),par.env.cnr,'measured');

    
    %% 多径效应部分
    
    switch par.env.chmod.filtering
        case 'BlockFading'
            y_filter = complex(zeros(nS + length(par.env.chmod.taps) -1 ,par.env.nRx));  
            for iRx = 1: par.env.nRx
                for iTx =1: par.env.nTx
                    % 先做信道卷积
                    switch par.env.chmod.fad
                        case {'TDL-A','TDL-B','TDL-C','TDL-D','TDL-E','awgn'}
                            % 解决收发多天线的问题
                            y_filter(:, iRx) = y_filter(:, iRx) + (conv(in(:,iTx),sqrt(par.env.chmod.taps)));
                        otherwise
                    end
                end
                % 加入噪声：
                switch par.env.chmod.type
                    case 'awgn' 
                        y_filter(:, iRx) = y_filter(:, iRx) + ...
                            sqrt(0.5)*(randn(size(y_filter(:, iRx))) + 1i*randn(size(y_filter(:, iRx)))) ... 
                            .* (sqrt(var(y_filter(:, iRx)) / db2lin(par.env.cnr) )) ; 
                    case 'flat Rayleigh'
                        % TODO
                    otherwise
                end
                
                % 摘除多余采样点  TODO:此处需要优化，将多余的采样点累计到下一个时隙内采集
                
                y = y_filter(1:nS, :);        
                y(~RxMask, :) = logical(0);
            end
        otherwise
            
    end
    
    %% 多普勒效应部分:
    delta_phase_shift_per_Ts = 2* pi * par.env.user_speed * cos(par.env.doppler_theta)  / par.env.carrierlambda;
    start_doppler = delta_phase_shift_per_Ts * gvar.sim.stored.t;
    
    y = y.* exp(1i * repmat(start_doppler + (0:size(y,1)-1)' * delta_phase_shift_per_Ts * par.env.dlTs, [1 par.env.nRx]));    
          
end