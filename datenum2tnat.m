function tnat = datenum2tnat(datenums)
% check that it's a column vector
datenums = datenums(:);
% transform datenums into dates
days = datevec(datenums);
% identify the datenum of the 1st of Jan
references = datenum(days(:,1), ones(size(days, 1), 1), ones(size(days, 1), 1));
tnat = datenums - references + 1;
% fix leap days
leap_days = leapyear(days(:,1)) & tnat > 59;
tnat(leap_days) = tnat(leap_days) - 1;
