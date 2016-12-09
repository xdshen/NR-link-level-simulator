%% ----------------------------------
% | ��Description�� OFDM Rx
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------
function y = nr_ofdmRx(par,gvar,in, RxMask)

% ����һ�����󣬵�һά�����ز����ڶ�ά�Ƿ��ţ�����ά�����ߣ�����ά����ɣ�    
    persistent hFFT;
    if isempty(hFFT)
        hFFT = dsp.FFT;
    end
    
% apply mask

in(~RxMask) = complex(0);
    
% For a subframe of data
numDataTones = par.env.dlnosc ;
numSymb = par.env.dlnosymslot;
[~, numLayers] = size(in);
N = par.env.dlFFTsize;
slotLen = sum(par.env.dlFFTsize + par.env.dlcp); % ����һ��slot�Ĳ���������Ŀ

tmp = complex(zeros(N, numSymb, numLayers));

% Remove CP - unequal lengths over a slot

    idx =0;
    for k =1:numSymb
        cp = par.env.dlcp(k);
        tmp(:,k,:) = in(idx + cp + (1:N),:);
        idx = idx + cp + N;
    end
    numDataTones = par.env.dlnosc;    

% FFT processing
x = step(hFFT, tmp);
x =  x./(N/sqrt(numDataTones));

% For a subframe of data
y = complex(zeros(numDataTones, numSymb, numLayers));

% Reorder, remove DC, Unpack data
x = [x(N/2+1:N, :, :); x(1:N/2, :, :)];
y(1:(numDataTones/2), :, :) = x(N/2-numDataTones/2+1:N/2, :, :);
y(numDataTones/2+1:numDataTones, :, :) = x(N/2+2:N/2+1+numDataTones/2, :, :);
