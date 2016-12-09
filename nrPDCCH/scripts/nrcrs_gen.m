%% ----------------------------------
% | 【Description】 生成NR-CRS导频;
% | 【Create】2016-12-03
% | 【Email】xdshen_cn@hotmail.com
% | 【History】 
% |         Xiaodong Shen 草稿，2016-12-03 
% ----------------------------------
% 返回值是一个3维矩阵：1.子载波 2.符号 3.layer
function y = nrcrs_gen(par,gvar)

    persistent hSeqGen;
    persistent hInt2Bit;
    if isempty(hInt2Bit)
        for k = 1:size(par.env.RSlen,2)
            if 2*par.env.RSlen(k,1)>0
                hSeqGen{k} = comm.GoldSequence('FirstPolynomial',[1 zeros(1, 27) 1 0 0 1],...
                    'FirstInitialConditions', [zeros(1, 30) 1], ...
                    'SecondPolynomial', [1 zeros(1, 27) 1 1 1 1],...
                    'SecondInitialConditionsSource', 'Input port',...
                    'Shift', 1600,...
                    'SamplesPerFrame', 2*par.env.RSlen(k,1)); % 此处序列长度可变需要重新设置；
            end
                  
        end

    hInt2Bit = comm.IntegerToBit('BitsPerInteger', 31);
    end
    % y = complex(zeros(par.env.RSlen, par.env.nlayer)) ;
    y = complex(zeros(par.env.dlnosc, par.env.dlnosymslot, par.env.nlayer));
    
     % 按照TS36.211的规范;
    % Generate the common first antenna port sequences
    for i = 1:1 % slot wise
        lIdx = 1; % symbol wise , in LTE lIdx = 1 or 2;
        
        nS = gvar.env.stored.nS ; % TODO nS的定义和LTE有不同；
        c_init = (2^10)*(7*((nS+i-1)+1)+ 1 +1)*(2*par.env.Ncellid+1) + 2*par.env.Ncellid ; % (+ Ncp);
        % c_init = (2^10)*(7*((nS+i-1)+1)+l(lIdx)+1)*(2*NcellID+1) + 2*NcellID + Ncp;
        
        % Convert to binary vector
        iniStates = step(hInt2Bit, c_init);

        % Scrambling sequence - as per Section 7.2, 36.211
        seq = step(hSeqGen{1}, iniStates);

        % Store the common first antenna port sequences
        
        y(par.env.RSmapping(:,1,1),1,1) = (1/sqrt(2))*complex(1-2.*seq(1:2:end), 1-2.*seq(2:2:end));        
    end
    
    % Copy the duplicate set for second antenna port, if exists
    if (par.env.nlayer>1)
        y(:,:,2) = y(:,:,1);
    end
    
end