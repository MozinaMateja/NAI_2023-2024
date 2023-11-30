format long
%funkcija = @(x) abs(x).*cos(x.^2);
funkcija = @(x)cos(2*x);
x = linspace(-1,1,11);
a = -1;
b = 1;
n = 8;

kantorovicevaAproksimacija(funkcija,a,b,n,x)

%NAPAKA
z = linspace(-1,1,201);
max(abs(arrayfun(funkcija,z) - kantorovicevaAproksimacija(funkcija,a,b,n,z)))


function y = kantorovicevaAproksimacija(f,a,b,n,x)
    F = @(x) integral(f, 0, x);
    for i = 1:size(x,2)
        vsota = 0;
       for k = 0:n 
           fin = -F(a + k*(b-a)/(n+1)) + F(a + (k+1)*(b-a)/(n+1));
          vsota = vsota + nchoosek(n,k)*((x(i)-a)/(b-a))^k*(1-(x(i)-a)/(b-a))^(n-k)*fin;
      end
      y(i) = (n+1)*vsota/(b-a);
    end
end
