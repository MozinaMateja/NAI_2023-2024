function [y, koef] = TrigonometricnaInterpolacija(f, a, b, n, x)

fi = @(x) (4*pi*n.*(x-a))./((2.*n+1).*(b-a)); % reparametrizacija iz [a,b] v [0,2pi*2n/(2n+1)]
L = linspace(a,b,2*n+1);  %x_j-ji
L2 = arrayfun(fi,L);  % x_j ji preslikani na [0, 2pi]
omega = exp(1i*L2');

W = [];
for l = -n:n
    W = [W,omega.^l];
end

alfa = W'*arrayfun(f,L)';
alfa = (1./(2*n+1))*alfa;

a0 = alfa(n+1);  %prosti koeficient
aji = [];   %koeficienti a_k pred kosinusi
for j = 1:n
    aji(j) = alfa(n+1-j) + alfa(n+1+j);
end

bji = [];    %koeficienti b_k pred sinusi
for j = 1:n
    bji(j) = 1i*(alfa(n+1+j) - alfa(n+1-j));
end

koef = [a0, aji, bji];   %seznam vseh koeficientov

y= [];  %izracunane vrednosti trigonometricnega polinoma v x
for m = 1 : length(x)
    x0 = x(m);
    stolpeccos = [];
    for t = 1:n
        stolpeccos = [stolpeccos; cos(t.*fi(x0))];
    end
    stolpecsin = [];
    for t = 1:n
        stolpecsin = [stolpecsin; sin(t.*fi(x0))];
    end
    y(m) = a0 + aji*stolpeccos + bji*stolpecsin;
end

end