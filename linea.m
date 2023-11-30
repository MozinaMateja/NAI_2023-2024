funkcija = @(x)cos(2*x);
x = linspace(-1,1,11);
a = -1;
b = 1;
n = 8;

odsekomaLinearnaAproksimacija(funkcija,a,b,n,x)
%NAPAKA
zx = linspace(-1,1,201);
max(abs(arrayfun(funkcija,zx) - odsekomaLinearnaAproksimacija(funkcija,a,b,n,zx)))

function y = odsekomaLinearnaAproksimacija(f,a,b,n,x)
    y= [];
    z = linspace(a,b,n+1);

    for i = 1:size(x,2)
       for j = 1:(size(z,2)-1)
          if x(i) >= z(j) && x(i) <= z(j+1)
             y(i) = f(z(j))*(z(j+1)-x(i))/(z(j+1) - z(j)) + f(z(j+1))*(x(i) - z(j))/(z(j+1) - z(j));
          end  
        end
    end
end