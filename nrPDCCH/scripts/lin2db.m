function y = lin2db(x)
% function y = lin2db(x)    
% converts linear to dB, no warning if zero
% and error if below

% by Magnus Almgren 951130

if any(x<=0)
  i = find(x <= 0);       %index to zero elements
  if any(x(i)<0)
    error('Input argument is less than zero')
  end
  ettor = ones(1,length(i));
  x(i) = ettor;
  y = 10*log10(x);
  y(i) = ettor .* (-Inf);
else
  y = 10*log10(x);
end
