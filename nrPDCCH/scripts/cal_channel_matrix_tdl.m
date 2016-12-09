%% ----------------------------------
% | ��Description�� ��ʼ����������
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------
% ����TDLģ�ͼ����ŵ������Ӧ���Բ�������� (For LTE 20MHz, Ts = )��
function taps = cal_channel_matrix_tdl(taps_t, Ts, DSdisired, normalized)
    h = round(taps_t(:,1) * DSdisired/1e3 / (Ts*1e6));
    taps = zeros(max(h(:,1))+1,1);
    for j = 1:length(h)
       taps(h(j)+1) = taps(h(j)+1) +db2lin(taps_t(j,2));
    end
    if nargin==3  % �����Ҫ��һ���Ļ�
       taps = taps / sum(taps); 
    end
end