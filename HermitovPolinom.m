function [y,g] = HermitovPolinom(f,df,ddf,a,b,x)

%n = 5;
cero = [a;a;a;b;b;b];
uno = arrayfun(f,cero);
dos = [df(a); df(a); (uno(3)-uno(4))/(a-b); df(b); df(b)];
tres = [ddf(a)/2; (dos(3)-dos(2))/(b-a);(dos(3)-dos(4))/(a-b); ddf(b)/2];
cuatro =[(tres(1)-tres(2))/(a-b);(tres(2)-tres(3))/(a-b);(tres(3)-tres(4))/(a-b)];
cinco = [(cuatro(1)-cuatro(2))/(a-b);(cuatro(2)-cuatro(3))/(a-b)];
seis = (cinco(1)-cinco(2))/(a-b);

g = @(xx) uno(1) + dos(1)*(xx-a) + tres(1)*((xx-a).^2) + cuatro(1)*((xx-a).^3) + cinco(1)*(xx-b)*((xx-a).^3) + seis*((xx-b).^2)*((xx-a).^3);
y = arrayfun(g,x);

end