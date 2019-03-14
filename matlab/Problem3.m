% Loading in Data
array = [0.9 1.3 1.9 2.1 2.6 3.0 3.9 4.4 4.7 5.0 6.0...
    7.0 8.0 9.2 10.5 11.3 11.6 12.0 12.6 13.0 13.3;...
    1.3 1.5 1.85 2.1 2.6 2.7 2.4 2.15 2.05 2.1 2.25...
    2.3 2.25 1.95 1.4 0.9 0.7 0.6 0.5 0.4 0.25];

% Set function values based on dataset
a = array(2,:);
n = length(array);
xValue = array(1,:);

% Part 1
M = NaturalSpline(n,xValue,a);
% calls values from natural spline matrix

plot(xValue,a,'b.') % plot original data first
hold all

% Use for-loop to plot each spline segment
for j = 1:n-1
    S = @(x) M(j,1) + (M(j,2).*(x - xValue(j))) + (M(j,3).*(x - xValue(j)).^2) + (M(j,4).*(x - xValue(j)).^3); %spline equation
   if j == 1
    fplot(S,[xValue(j) xValue(j+1)],'r-')
   else
      fplot(S,[xValue(j) xValue(j+1)],'r-','HandleVisibility','off')%allows me to make the legend properly
   end    
end

% Part 2
[Coeffs] = DividedDifferences(xValue,n,a);
% call coefficients from divided differences calculation
E = @(x) 1;
H = @(x) 0;
for i = 2:n
    for j = 1:i-1
         D = @(x) (x-xValue(j)); 
         E = @(x) E(x) * D(x); % product of all (x-x(j))
    end
    G = @(x) Coeffs(i) * E(x); % multiply corresponding coeff. by product of (x-x(j))
    H = @(x) H(x) + G(x); % adds new section of equation to preceeding sections
    E = @(x) 1; % reset function for next loop pass
end

P = @(x) (Coeffs(1) + H(x)); % creates interpolating polynomial by adding first coefficient to rest of generated equation

fplot(P,[xValue(1) xValue(end)],'g-')

xlim([0 14]);
ylim([-6 4]);
legend("Data Points","Cubic Spline","Divided Differences")
grid on
hold off