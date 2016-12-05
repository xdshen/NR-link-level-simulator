%% ----------------------------------
% | 【Description】 OFDM Rx
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
function y = nr_ofdmRx(par,gvar,in, RxMask)

% 返回一个矩阵，第一维是子载波，第二维是符号，第三维是天线（第三维待完成）    
    persistent hFFT;
    if isempty(hFFT)
        hFFT = dsp.FFT;
    end
    
% apply mask

in(~RxMask) = complex(0);
    
% For a subframe of data
numDataTones = par.env.dlrb*par.env.noscrb;
numSymb = par.env.nosymslot;
[~, numLayers] = size(in);
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
slotLen = (N*7 + cpLen0 + cpLenR*6); % 固定的7个符号 TODO

tmp = complex(zeros(N, numSymb, numLayers));

% Remove CP - unequal lengths over a slot

    % First OFDM symbol
    tmp(:, 1, :) = in(cpLen0 + (1:N), :);

    % Next 6 OFDM symbols
    for k = 1:6
        tmp(:, k+1, :) = in(cpLen0+k*N+k*cpLenR + (1:N), :);
    end    


% FFT processing
x = step(hFFT, tmp);
x =  x./(N/sqrt(numDataTones));

% For a subframe of data
y = complex(zeros(numDataTones, numSymb, numLayers));

% Reorder, remove DC, Unpack data
x = [x(N/2+1:N, :, :); x(1:N/2, :, :)];
y(1:(numDataTones/2), :, :) = x(N/2-numDataTones/2+1:N/2, :, :);
y(numDataTones/2+1:numDataTones, :, :) = x(N/2+2:N/2+1+numDataTones/2, :, :);
