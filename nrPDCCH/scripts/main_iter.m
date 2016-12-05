%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: 主函数(用于循环)
%% ==================================


function result = main_iter(varargin)
% 参数格式:
% 'par.env.cnr',[1 2 3 4 5 6 7 8 9 10], 'par.env.n_bit_dci', [30 40 50 60];
% 支持两组参数的变换

% disp(cell2mat(varargin(2)));

    if nargin>0
        nvar = round((nargin)/2);     % 总共变量数目
        for p = 1:nvar
            num(p) = length(cell2mat(varargin(2*p)));%每个变量的iter数目
        end        
        if nvar==1
           for p = 1:nvar
               v = cell2mat(varargin(2*p));
               for q = 1:num(p)
                    % 初始化par
                    par= default_par();
                    par = init_par(par);

                    % 初始化gvar
                    gvar = default_gvar(par);
                    gvar = init_gvar(par,gvar);

                    
                    eval([cell2mat(varargin(1)) '=' num2str(v(q)) ';']);
                    result{q} = main(par,gvar);                   
               end    
           end
        end
        % TODO : nvar =2,3,4,5
   
    else
        result{1}= main;
    end
    
end