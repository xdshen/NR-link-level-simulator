function r=index2d(rowid,colid,sz)
% function r=index2d(rowid,colid,sz)
r=rowid+(colid-1)*(sz(1));