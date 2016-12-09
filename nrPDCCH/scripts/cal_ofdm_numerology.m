%% ----------------------------------
% | ��Description�� ������
% | ��Create��2016-12-06
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-06 
% ----------------------------------
% dlFFTsize
% dlTs
% dlcp
% dlscs
% dlrb
% dlnosymslot

function [dlFFTsize,dlTs,dlcp] = cal_ofdm_numerology(dlscs,dlrb,dlnosymslot)
    switch dlscs
        case 15e3
            switch dlrb % depends on the chanBW
                case 6
                    dlFFTsize = 128; %FFT��С��������
                    dlcp = repmat([10 9 9 9 9 9 9],[1,dlnosymslot/7]);                    
                case 15
                    dlFFTsize = 256; %FFT��С��������
                    dlcp = repmat(2*[10 9 9 9 9 9 9],[1,dlnosymslot/7]);              
                case 25
                    dlFFTsize = 512; %FFT��С��������
                    dlcp = repmat(4*[10 9 9 9 9 9 9],[1,dlnosymslot/7]);                            
                case 50
                    dlFFTsize = 1024; %FFT��С��������
                    dlcp = repmat(8*[10 9 9 9 9 9 9],[1,dlnosymslot/7]);        
                case 75 
                    dlFFTsize = 1536;   %FFT��С��������       
                    dlcp = repmat(12*[10 9 9 9 9 9 9],[1,dlnosymslot/7]);        
                case 100
                    dlFFTsize = 2048; %FFT��С��������
                    dlcp = repmat(16*[10 9 9 9 9 9 9],[1,dlnosymslot/7]);        
            end    
    end

    dlTs = 1/(30.72e6 * dlFFTsize/2048);    % ����������������

end