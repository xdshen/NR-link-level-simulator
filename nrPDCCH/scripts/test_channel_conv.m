hQAM2 = comm.RectangularQAMModulator('ModulationOrder',4,'BitInput',true, 'SymbolMapping', 'Gray','NormalizationMethod','Average power');
hdeQAM2 = comm.RectangularQAMDemodulator('ModulationOrder',4,'BitOutput',true, 'SymbolMapping', 'Gray','NormalizationMethod','Average power', 'DecisionMethod', 'Hard decision');
      
cp = 10;    % 10 out of 64
s = logical( randi([0 1],128,1));
sq = step(hQAM2,s);
sqf = ifft(sq);
sqf_cp = [sqf(end-cp+1:end);sqf];
tx = conv(sqf_cp,[cos(1*pi/180),sin(1*pi/180)]);
rx = tx(1:length(sqf_cp));
rqf = rx(cp+1:end);
rq = fft(rqf);
r = step(hdeQAM2,rq);