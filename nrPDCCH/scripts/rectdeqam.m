%% ----------------------------------
% | ¡¾Description¡¿ QAM½âµ÷;
% | ¡¾Create¡¿2016-12-03
% | ¡¾Email¡¿xdshen_cn@hotmail.com
% | ¡¾History¡¿ 
% |         Xiaodong Shen ²Ý¸å£¬2016-12-03 
% ----------------------------------
function y = rectdeqam(par,gvar,in,noiseVar)

    persistent hQAM2;
    persistent hQAM4;
    persistent hQAM6;
    if isempty(hQAM2) & (par.env.modu==2)
        hQAM2 = comm.RectangularQAMDemodulator('ModulationOrder',4,'BitOutput',true, 'SymbolMapping', 'Gray','NormalizationMethod','Average power', 'DecisionMethod', 'Hard decision');
        %hQAM2 = comm.RectangularQAMDemodulator('ModulationOrder',4,'BitOutput',true, 'SymbolMapping', 'Gray','NormalizationMethod','Average power', 'DecisionMethod', 'Approximate log-likelihood ratio');
    end     
    
    if isempty(hQAM4) & (par.env.modu==4)
        hQAM4 = comm.RectangularQAMDemodulator('ModulationOrder',16,'BitOutput',true, 'SymbolMapping', 'Gray','NormalizationMethod','Average power','DecisionMethod', 'Log-likelihood ratio');
    end   
    
    if isempty(hQAM6) & (par.env.modu==6)
        hQAM6 = comm.RectangularQAMDemodulator('ModulationOrder',64,'BitOutput',true, 'SymbolMapping', 'Gray','NormalizationMethod','Average power','DecisionMethod', 'Log-likelihood ratio');
    end       
    
    switch par.env.modu
        case 2
            %hQAM2.release();hQAM2.Variance = noiseVar;
            y = (step(hQAM2,in));
        case 4
            hQAM4.release();hQAM4.Variance = noiseVar;
            y = (step(hQAM4,in));
        case 6            
            hQAM6.release();hQAM6.Variance = noiseVar;
            y = (step(hQAM6,in));
    end
    y = logical(y);
end