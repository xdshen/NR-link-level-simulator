%% ----------------------------------
% | ��Description�� ������(����ѭ��)
% | ��Create��2016-12-03
% | ��Email��xdshen_cn@hotmail.com
% | ��History�� 
% |         Xiaodong Shen �ݸ壬2016-12-03 
% ----------------------------------
%
% ʾ���÷����£�
% rst = main_iter('par.env.n_bit_dci', [30 40 50 60]);  
% showtext(rst,'par.env.n_bit_dci','errorStatsBLER(1)','errorStatsBLER(2)','errorStatsBLER(3)');
%
% rst = main_iter('par.env.cnr', [-10:10]);  
% showtext(rst,'par.env.cnr','errorStatsBLER(1)','errorStatsBLER(2)','errorStatsBLER(3)');
%% ==================================


function result = main_iter(varargin)
% ������ʽ:
% 'par.env.cnr',[1 2 3 4 5 6 7 8 9 10], 'par.env.n_bit_dci', [30 40 50 60];
% ֧����������ı任

    if nargin>0
        nvar = round((nargin)/2);     % �ܹ�������Ŀ
        
        % ����ÿ��������iter��Ŀ���洢������num��
        for p = 1:nvar
            num(p) = length(cell2mat(varargin(2*p)));
        end
        
        
        if nvar==1
           for p = 1:nvar
               v = cell2mat(varargin(2*p));
               for q = 1:num(p)  
                   % Show var
                   disp([cell2mat(varargin(2*p-1)) ' = ' num2str(v(q))]);
                   
                    % ��ʼ��par
                    par= default_par();
                    par = init_par(par);

                    % ��ʼ��gvar
                    gvar = default_gvar(par);
                    gvar = init_gvar(par,gvar);
% 
%                     % ��Ϊparfor��֧��eval������ֻ����switch���
%                     switch cell2mat(varargin(1))
%                         case 'par.env.cnr'
%                             par.env.cnr = num2str(v(q));
%                     end
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