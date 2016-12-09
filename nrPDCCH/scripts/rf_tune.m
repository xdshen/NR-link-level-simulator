%% ----------------------------------
% | 【Description】 主函数
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
%
% 根据发送调整RF开关接收；

function rxMask = rf_tune(par,gvar,txMask)
% NOTE：发送端有一个天线发送，那么接收端的所有天线都要打开接收
    rxMask = repmat(logical(sum(txMask,2)),[1 par.env.nRx]);
end