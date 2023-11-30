format long
funkcija = @(x)cos(2*x);
x = linspace(-1,1,11);
a = -1;
b = 1;
n = 8;

bernsteinovaAproksimacija(funkcija,a,b,n,x)

%NAPAKA
z = linspace(-1,1,201);
max(abs(arrayfun(funkcija,z) - bernsteinovaAproksimacija(funkcija,a,b,n,z)))


function y = bernsteinovaAproksimacija(f,a,b,n,x)
    y= [];

    for i = 1:size(x,2)
        vsota = 0;
       for k = 0:n 
          vsota = vsota + f(a + k*(b-a)/n)*nchoosek(n,k)*((x(i)-a)/(b-a))^k*(1-(x(i)-a)/(b-a))^(n-k);
      end
      y(i) = vsota;
    end
end


