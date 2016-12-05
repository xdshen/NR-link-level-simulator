%% ==================================
% Author: Xiaodong Shen  
% Date: 2016-12-03
% email: xdshen_cn@hotmail.com
% Description: QAMµ÷ÖÆ;
%% ==================================

function info_qam = rectqam(par,gvar,info)
    persistent hQAM2;
    persistent hQAM4;
    persistent hQAM6;
    if isempty(hQAM2) & (par.env.modu==2)
        hQAM2 = comm.RectangularQAMModulator('ModulationOrder',4,'BitInput',true, 'SymbolMapping', 'Gray','NormalizationMethod','Average power');
    end     
    
    if isempty(hQAM4) & (par.env.modu==4)
        hQAM4 = comm.RectangularQAMModulator('ModulationOrder',16,'BitInput',true, 'SymbolMapping', 'Gray','NormalizationMethod','Average power');
    end   
    
    if isempty(hQAM6) & (par.env.modu==6)
        hQAM6 = comm.RectangularQAMModulator('ModulationOrder',64,'BitInput',true, 'SymbolMapping', 'Gray','NormalizationMethod','Average power');
    end       
    
    switch par.env.modu
        case 2
            info_qam = step(hQAM2,info);
        case 4
            info_qam = step(hQAM4,info);
        case 6             
            info_qam = step(hQAM6,info);
    end
    
end