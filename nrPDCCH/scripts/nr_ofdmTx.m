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
    switch par.env.dlrb % depends on the chanBW
        case 6
            N = 128;
            cpLen0 = 10; cpLenR = 9;
        case 15
            N = 256;
            cpLen0 = 20; cpLenR = 18;
        case 25
            N = 512;
            cpLen0 = 40; cpLenR = 36;
        case 50
            N = 1024;
            cpLen0 = 80; cpLenR = 72;
        case 75 
            N = 1536;                   
            cpLen0 = 120; cpLenR = 108; 
        case 100
            N = 2048;
            cpLen0 = 160; cpLenR = 144;
    end
    slotLen = (N*7 + cpLen0 + cpLenR*6);   % 固定的7个符号 TODO
    tmp = complex(zeros(N, numSymb, numLayers));
    
    % Pack data, add DC, and reorder
    tmp(N/2-len/2+1:N/2, :, :) = in(1:len/2, :, :);
    tmp(N/2+2:N/2+1+len/2, :, :) = in(len/2+1:len, :, :);
    tmp = [tmp(N/2+1:N, :, :); tmp(1:N/2, :, :)];

    % IFFT processing
    x = step(hIFFT, tmp);
    x = x.*(N/sqrt(len));
    

    % Add cyclic prefix per OFDM symbol per antenna port 

    y = complex(zeros(numSymb, numLayers));

    % First OFDM symbol
    y((1:cpLen0), :) = x((N-cpLen0+1):N, 1, :);
    y(cpLen0+(1:N), :) = x(1:N, 1, :);

    % Next 6 OFDM symbols
    for k = 1:6
        y(cpLen0+k*N+(k-1)*cpLenR+(1:cpLenR), :) = x(N-cpLenR+1:N, k+1, :);
        y(cpLen0+k*N+k*cpLenR+(1:N), :) = x(1:N, k+1, :);
    end

    TxMask = logical(zeros(size(y)));
    TxMask(1:cpLen0+N, :) = logical(1);
    
end