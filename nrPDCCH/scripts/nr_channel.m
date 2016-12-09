%% ----------------------------------
% | ��Description�� NR Channel 
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------
% TDL�ŵ����� ����˥�� + �ྶЧӦ + ������ЧӦ
% ����˥�䲿�֣�
%   ��ÿһ�η���Ŀ�ʼ���ɣ�������һ�η����б��ֲ����ˡ���������Ϊ�˼��ٷ��������ڷ����һ��ʼ�趨��ÿ�����ķ���Ϊ����ֵ�Ŀ��ţ���λΪ0
% �ྶЧӦ���֣�
%   ��������������ŵ��弤��Ӧ������õ���
% ������ЧӦ���֣�
%   ���չ�ʽ������λ����ת����exp(2 * pi * 1i * v * t / lamda * cos(theta)),
%   �ӵ��ŵ��ĸ������ϣ���֡����ʼʱ��Ϊt0����ǰʱ��Ϊt1����ôt = [t0: sample_time:t1]����ͬ�������ϵ��ŵ����죬�������t�仯������ 


function [y] = nr_channel(par,gvar,in, RxMask)
    
    % TODO:��������ķ���
    
    % ��������Ĵ�С���£�
    [nS, nTxAnt] = size(in);

    
    % TODO: �˴���Ҫ����SNR��������ô����ȥ��    
    % -----  delete it!!!! wrong y(RxMask) = awgn(in(RxMask),par.env.cnr - lin2db(par.env.dlrb/par.env.dlrb_pdcch),'measured');
    % -----  delete it!!!! wrong y(RxMask) = awgn(in(RxMask),par.env.cnr,'measured');

    
    %% �ྶЧӦ����
    
    switch par.env.chmod.filtering
        case 'BlockFading'
            y_filter = complex(zeros(nS + length(par.env.chmod.taps) -1 ,par.env.nRx));  
            for iRx = 1: par.env.nRx
                for iTx =1: par.env.nTx
                    % �����ŵ����
                    switch par.env.chmod.fad
                        case {'TDL-A','TDL-B','TDL-C','TDL-D','TDL-E','awgn'}
                            % ����շ������ߵ�����
                            y_filter(:, iRx) = y_filter(:, iRx) + (conv(in(:,iTx),sqrt(par.env.chmod.taps)));
                        otherwise
                    end
                end
                % ����������
                switch par.env.chmod.type
                    case 'awgn' 
                        y_filter(:, iRx) = y_filter(:, iRx) + ...
                            sqrt(0.5)*(randn(size(y_filter(:, iRx))) + 1i*randn(size(y_filter(:, iRx)))) ... 
                            .* (sqrt(var(y_filter(:, iRx)) / db2lin(par.env.cnr) )) ; 
                    case 'flat Rayleigh'
                        % TODO
                    otherwise
                end
                
                % ժ�����������  TODO:�˴���Ҫ�Ż���������Ĳ������ۼƵ���һ��ʱ϶�ڲɼ�
                
                y = y_filter(1:nS, :);        
                y(~RxMask, :) = logical(0);
            end
        otherwise
            
    end
    
    %% ������ЧӦ����:
    delta_phase_shift_per_Ts = 2* pi * par.env.user_speed * cos(par.env.doppler_theta)  / par.env.carrierlambda;
    start_doppler = delta_phase_shift_per_Ts * gvar.sim.stored.t;
    
    y = y.* exp(1i * repmat(start_doppler + (0:size(y,1)-1)' * delta_phase_shift_per_Ts * par.env.dlTs, [1 par.env.nRx]));    
          
end