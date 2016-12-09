%% ----------------------------------
% | 【Description】 OFDM Tx
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------

function [y, TxMask]= nr_ofdmTx(par,gvar,in)
    % 返回一个矩阵，第一维是时域采样点，第二维是天线
    % TxMask 发送时刻，1代表射频开，0代表射频关，第一维是时域采样点，第二维是天线
    
    persistent hIFFT;
    if isempty(hIFFT)
        hIFFT = dsp.IFFT;
    end
    
    [len, numSymb, numLayers] = size(in);
    
    % N assumes 15KHz subcarrier spacing, else N = 4096
    N = par.env.dlFFTsize;
    slotLen = sum(par.env.dlFFTsize + par.env.dlcp); % 计算一个slot的采样点总数目
    
    tmp = complex(zeros(N, numSymb, numLayers));
    
    % Pack data, add DC, and reorder
    tmp(N/2-len/2+1:N/2, :, :) = in(1:len/2, :, :);
    tmp(N/2+2:N/2+1+len/2, :, :) = in(len/2+1:len, :, :);
    tmp = [tmp(N/2+1:N, :, :); tmp(1:N/2, :, :)];

    % IFFT processing
    x = step(hIFFT, tmp);
    x = x.*(N/sqrt(len));
    
    % Add cyclic prefix per OFDM symbol per antenna port 

    y = complex(zeros(slotLen, numLayers));
    idx =0;
    for k =1:numSymb
        cp = par.env.dlcp(k);
        y(idx + 1 : idx + cp,:) = x(N-cp+1:N,k,:);
        y(idx + cp + 1:idx + cp + N , :) = x(1:N,k,:);
        idx = idx + cp + N;
    end

    TxMask = logical(zeros(size(y)));
    % 只开启第一个符号传送NR-PDCCH    
    TxMask(1:par.env.dlcp(1) + N, :) = logical(1);
    
end