format long 
t = [0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10];
c = [5, 7, 3, 9, 2, 4, 1, 6];
x = 0:0.5:10;
deBoor(t,c,x)';


n = 10;
s = linspace(-1,1,n+1);  %sticne tocke
f = @(x) cos(2*x);
x2 = -1:(2/n):1;
t2 = [s(1), s(1), s(1), s, s(end), s(end), s(end)];
lambda = zeros(1,n + 3);
lambda(1) = f(s(1));
lambda(2) = 1/18*(-5*f(s(1)) + 40*f((s(2)+s(1))/2)- 24*f(s(2)) + 8*f((s(3)+s(2))/2)- f(s(3)));
lambda(n+3) = f(s(n+1));
lambda(n+2) = 1/18*(-f(s(n-1)) + 8*f((s(n)+s(n-1))/2)- 24*f(s(n)) + 40*f((s(n+1)+s(n))/2)- 5*f(s(n+1)));
for i = 3:n+1
    lambda(i) = 1/6*(f(s(i-2)) - 8*f((s(i-1)+s(i-2))/2)+ 20*f(s(i-1)) - 8*f((s(i)+s(i-1))/2) + f(s(i)));
end
deBoor(t2,lambda,x2)';

tocke_napake = -1:0.01:1;
norm(arrayfun(f,tocke_napake) - deBoor(t2,lambda,tocke_napake), 'inf');


% Linearna interpolacija
t3 = [s(1), s, s(end)];
ci = arrayfun(f,s);
norm(arrayfun(f,tocke_napake) - deBoor(t3,ci,tocke_napake), 'inf');
