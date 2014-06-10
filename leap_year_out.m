function Y = leap_year_out (N1, N2, X)
% function leap_year_out (N1, N2, X) for eliminating the 29th of the leap year

% inputs: N1 is the starting year (scalar)

%         N2 is the ending year (scalar)

%     X is the column vector of daily series from N1 to N2 with 29th Feb.

% outputs: Y is the vector of daily series from N1 to N2 without 29th Feb

% by Van Anh 31/3/2013
N   = N1:1:N2 ;
X1 = X;
for i = 1: length(N)
    if mod(N(i),4)==0
       X1((N(i)-N1)*365+60)=[];
    end   
end
Y = X1;