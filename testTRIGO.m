format long
f = @(x) (cos(x)).^4 + exp(-x);
a = 0;
n = 4;
b = 5; %4*pi*n./(2*n+1);

tocke_napake = linspace(0, 2*pi*(2*n)/(2*n+1), 201);
[y, koef] = TrigonometricnaInterpolacija(f, a, b, n, tocke_napake);
koef         %koeficienti trig.poli.
norm(arrayfun(f,tocke_napake) - y, 'inf')    %najvecja napaka

tocke_napake2 = linspace(0,5,201);
[y2, koef2] = TrigonometricnaInterpolacija(f, 0, 5, n, tocke_napake2);
koef2        %koeficienti trig.poli.
norm(arrayfun(f,tocke_napake2) - y2, 'inf')    %najvecja napaka

x = linspace(a, b, 2*n+1);
p = polyfit(x,arrayfun(f,x),2*n);
norm(arrayfun(f,tocke_napake2) - polyval(p,tocke_napake2), 'inf')
