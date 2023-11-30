format long
funkcija = @(x)abs(x).*sin(2*exp(1.5*x)-1);

%    NE DELA ZA VELIKE N !

re = Remesov_postopek(funkcija,-1,1, 4, 10)';

% NAPAKA
ui = linspace(-1,1,1001);
residual = @(x) (funkcija(x) - polyval(re,x));
norm(residual(ui), 'inf');



Remesov_postopek(funkcija,-1,1, 4, 10)
%--------------------------------------------------------
function seznam_koeficientov_polinoma = Remesov_postopek(funkcija,a,b, stopnja_polinoma, koraki)
    E = linspace(a,b,stopnja_polinoma + 2);
    for k = 1:koraki
        [g,m] = najdipolinom(funkcija, E, stopnja_polinoma); %  m je minimaks
        [mm, xx] = najvecjix(1000,a,b,funkcija,g);
        razlika = abs(abs(m)-abs(mm));
        if razlika >= 1e-10
            E = pomozna(funkcija, g, E, xx);
        end
    end
    seznam_koeficientov_polinoma = g;
end

function seznam = pomozna(funki, polinom, seznam,tc)
    [~,indeksa] = mink(abs(seznam-tc),2);
    indeksa = sort(indeksa);
    fun3 = @(x) (funki(x) - polyval(polinom,x));
    if sign(fun3(tc)) == sign(fun3(seznam(indeksa(1))))
%        if indeksa(1) == 1
%            if sign(fun3(tc)) == sign(fun3(seznam(2)))
%                seznam(2) = tc;
%            else
%                seznam(end) = tc;
%            end
%        else
        seznam(indeksa(1)) = tc;
%        end
    else
%        if indeksa(2) == size(seznam,2)
%            if sign(fun3(tc)) == sign(fun3(seznam(size(seznam,2) - 1)))
%                seznam(size(seznam,2) - 1) = tc;
%            else
%                seznam(1) = tc;
%            end
%        else
        seznam(indeksa(2)) = tc;
%        end
    end
end

function [val, najvecji] = najvecjix(N,a,b,f,g)
    xy = linspace(a,b,N+1);
    r = @(x) (f(x) - polyval(g,x));
    rr = abs(r(xy)); % vrstica absolutnih vrednosti funkcije r = f-p v tockah x
    [val, idx] = max(rr);
    najvecji = xy(idx);
end

function [g,m] = najdipolinom(funk, E, n)
    b2 = arrayfun(funk,E)';
    x1 = matrikaA(n,E)\b2;
    m = abs(x1(1));
    g = x1(end:-1:2,:); %vodilni koeficient je prvi
end


function A = matrikaA(n, E)
A =[];
for i = 1:(n+2)
    if i == 1
        A = ((-1).^(0:(n+1)))';
    else
        t = (E').^(i-2);
        A = [A, t];
    end
end
A;
end
