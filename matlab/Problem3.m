%Part (a)
M = NaturalSpline(n,xValue,a);
%calls values from natural spline matrix

plot(xValue,a,'b.') %plot original data first
hold all
for j = 1:n-1
    S = @(x) M(j,1) + (M(j,2).*(x - xValue(j))) + (M(j,3).*(x - xValue(j)).^2) + (M(j,4).*(x - xValue(j)).^3); %spline equation
   if j == 1
    fplot(S,[xValue(j) xValue(j+1)],'r-')
   else
      fplot(S,[xValue(j) xValue(j+1)],'r-','HandleVisibility','off')%allows me to make the legend properly
   end
       
    
end







%Part 2
[Coeffs] = DividedDifferences(xValue,n,a);
%call coefficients from divided differences calculation
E = @(x) 1;
H = @(x) 0;
for i = 2:n
    for j = 1:i-1
         D = @(x) (x-xValue(j)); 
         E = @(x) E(x) * D(x); %product of all (x-x(j))
    end
    G = @(x) Coeffs(i) * E(x); %multiply corresponding coeff. by product of (x-x(j))
    H = @(x) H(x) + G(x); %adds new section of equation to preceeding sections
    E = @(x) 1; %reset function for next loop pass
end

P = @(x) (Coeffs(1) + H(x)); %creates interpolating polynomial by adding first coefficient to rest of generated equation

fplot(P,[xValue(1) xValue(end)],'g-')

xlim([0 14]);
ylim([-6 4]);
legend("Data Points","Cubic Spline","Divided Differences")
grid on
hold off