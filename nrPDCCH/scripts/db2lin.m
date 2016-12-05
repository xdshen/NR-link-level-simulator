function y = db2lin(x)
% function y = db2lin(x)           converts dB to linear
% by Magnus Almgren 951104

y= 10 .^ (x/10);

