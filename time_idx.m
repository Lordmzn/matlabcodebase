function [ doy, dates ] = time_idx( ini_date , fin_date )
%
% [ doy, dates ] = time_idx( ini_date , fin_date )
%

[ni,mi]=size(ini_date);
[nf,mf]=size(fin_date);
if any([ni~=1,mi~=3,nf~=1,mf~=3])
    error('''ini_date'' and ''fin_date'' must be row vectors [dd mm yyyy]')
end
jd1 = time_date2JD(ini_date);
jd2 = time_date2JD(fin_date);
if jd2 < jd1
    error('''fin_date'' must follow ''ini_date''')
end
jd  = [ jd1: jd2 ]' ;
dates = time_JD2date( jd ) ;
doy = time_date2nat( dates ) ;
