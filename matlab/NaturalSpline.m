function [M] = NaturalSpline(n,xValue,a)

%Here M is the table of a,b,c,and d coefficients
    % n is the number of intervals in the array of x-values 
    %(NOTE: use n-1 = 1 here, as MATLAB indexes starting at 1 not zero) 
    % xValue input is an array of x-values to be used for the spline
    % y is the corresponding array of y-values (as f(x))


    for i = 1:n-1
        h(i) = xValue(i+1) - xValue(i);
    end

    for i = 2:n-1
        alpha(i) = ((3/h(i))*(a(i+1)-a(i))) - ((3/h(i-1))*(a(i)-a(i-1)));
    end
    
l(1) = 1;
mu(1) = 0;
z(1) = 0;
    for i = 2:n-1
        l(i) = (2*(xValue(i+1)-xValue(i-1)))-(h(i-1)*mu(i-1));
        mu(i) = h(i)/l(i);
        z(i) = (alpha(i)-(h(i-1)*z(i-1)))/l(i);
    end

l(n) = 1;
z(n) = 0;
c(n) = 0;
    for j = 1:n-1
        c(j) = z(j) - (mu(j)*c(j+1));
        b(j) = ((a(j+1)-a(j))/((h(j))))-((h(j)*(c(j+1)+(2*c(j))))/3);
        d(j) = (c(j+1)-c(j))/(3*h(j));
    end
    
    M = [a(1) b(1) c(1) d(1)];
    for j = 2:n-1
        M = [M;a(j) b(j) c(j) d(j)];
    end
end

        