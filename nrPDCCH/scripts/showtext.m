%% ----------------------------------
% | 【Description】 将main_iter的仿真结果呈现出来
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
% 示例用法如下：
% rst = main_iter('par.env.n_bit_dci', [30 40 50 60]);  
% showtext(rst,'par.env.n_bit_dci','errorStatsBLER(1)','errorStatsBLER(2)','errorStatsBLER(3)');
%
% rst = main_iter('par.env.cnr', [-10:10]);  
% showtext(rst,'par.env.cnr','errorStatsBLER(1)','errorStatsBLER(2)','errorStatsBLER(3)');
%% ==================================


function showtext(result, varargin)



    t = uitable; 
    cnames = varargin;
    
    disp(varargin);
    n = length(result);
    table = zeros(n,length(varargin));
    
    
    for i = 1:n
        for j = 1:length(varargin)
            eval(['table(i,j) = (result{i}.' cell2mat(varargin(j)) ');']);
        end 
    end
    t = uitable('Data',table,'ColumnName',cnames);
end
