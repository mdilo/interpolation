function [Coeffs] = DividedDifferences(xValue,n,a)

% This function will use the divided differences method to provide an array
%   of coefficients which will be used to generate the interpolating
%   polynomial for the given data
%
% xValue is the array of xValues used for calculating divided differences
% n is the number of intervals in data set
%(NOTE: use n = 1 here, as MATLAB indexes starting at 1 not zero) 
% a is the corresponding f(xValues) 


F = zeros(n,n);
for i = 1:length(a)
    F(i,1) = a(i);
end

for i = 2:n
    for j = 2:i
        F(i,j) = (F(i,j-1) - F(i-1,j-1))/(xValue(i)-xValue(i-(j-1)));
    end 
end

Coeffs = diag(F)'; %just switches the coefficients into 'row array' form