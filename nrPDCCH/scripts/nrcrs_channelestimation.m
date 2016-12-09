%% ----------------------------------
% | 【Description】 信道估计
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
function H_est = nrcrs_channelestimation(par,gvar,info)
    H_LS = complex(zeros(par.env.dlnosc, par.env.dlnosymslot, par.env.nlayer));
    H_LS(par.env.RSmapping) = info(par.env.RSmapping) ./ gvar.env.stored.crs(par.env.RSmapping); % 先取得ZF算法的H                  
    switch par.env.ce
        case 'ZF'
            
            % for NR-PDCCH, only implement the first OFDM part
            % TODO: for NR-PDSCH, time-domain interp is needed.
            
            % implement freq 'cubic-spline': see http://www.doc88.com/p-8068023277124.html
            range = find(par.env.REmapping_rb(:,1,1) == true);
            for i = 1:length(range)
                k = range(i); 
                X = find(par.env.RSmapping((k-1) * par.env.dlscrb + (1:par.env.dlscrb)' ,1,1));
                V = H_LS(index2d(X,k,[par.env.dlscrb par.env.dlrb]),1,1);   
                idx = true(par.env.dlscrb,1); idx(X) = false; 
                Xq = find(idx == true);               
                Vq = interp1(X,V,Xq, 'cubic-spline');                                
                H_LS(index2d(Xq,k,[par.env.dlscrb par.env.dlrb]),1,1) = Vq;
            end
            
        case 'MMSE'
            % TODO : H_mmse = RHH * (RHH + sig^2 * (XXH)^-1)^-1 * H_LS;
        case 'LMMSE'
            % TODO : H_lmmse = R(H*Hp) * (R(Hp*Hp) + beta / SNR * I)^-1 * H_LS;  
            % beta = E{(abs(Xk))^2}/E{1/(abs(Xk))^2}, For QPSK， beta =1
            % R(a*b), 是值a和b的互相关矩阵；        
    end
    H_est = H_LS;
    % 2维时频滤波
    % TODO
    
    
    % 返回信道估计结果
    
    
    
