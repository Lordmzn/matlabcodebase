function tnat = time_date2nat( tdates ) 
%
% tnat = time_date2nat( tdates ) 
%
% tdates = matrix of dates [ dd mm yyyy ]        - matrix ( N , 3 ) %
%   tnat = vector of corresponding natural times - vector ( N , 1 ) %
%          each element of 'tnat' belongs to { 1 , 2 , ... , 365 }
%          where t =   1 : the  1st of January
%                t = 365 : the 31st of December
%          and both the 28th and 29th of February
%          are labeled as t = 59
%
% Last update by Francesca Pianosi, 24/10/2007

% dates in a non leap year :
year =  [ [ 1 : 31 ]' ,  1 * ones( 31 , 1 ) ; ...
          [ 1 : 28 ]' ,  2 * ones( 28 , 1 ) ; ...
          [ 1 : 31 ]' ,  3 * ones( 31 , 1 ) ; ...          
          [ 1 : 30 ]' ,  4 * ones( 30 , 1 ) ; ...
          [ 1 : 31 ]' ,  5 * ones( 31 , 1 ) ; ...
          [ 1 : 30 ]' ,  6 * ones( 30 , 1 ) ; ...
          [ 1 : 31 ]' ,  7 * ones( 31 , 1 ) ; ...
          [ 1 : 31 ]' ,  8 * ones( 31 , 1 ) ; ...
          [ 1 : 30 ]' ,  9 * ones( 30 , 1 ) ; ...
          [ 1 : 31 ]' , 10 * ones( 31 , 1 ) ; ...
          [ 1 : 30 ]' , 11 * ones( 30 , 1 ) ; ...
          [ 1 : 31 ]' , 12 * ones( 31 , 1 ) ] ; 

tnat = zeros( size( tdates( : , 1 ) ) ) ;
for i = 1 : 365 ;
    tnat( find( ( tdates( : , 1 ) == year( i , 1 ) ) & ( tdates( : , 2 ) == year( i , 2 ) ) ) ) = i ;
end
tnat( tnat == 0 ) = 31 + 28 ; % any element of 'tnat' still equal to zero
% corresponds to a date that does not appear in 'year' , i.e. the 29th of
% February, which is associated to the natural time index 59