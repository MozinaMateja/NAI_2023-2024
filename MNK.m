format long

funkcija = @(x) exp(sin(x.^2/10));   %podana funkcija

%------potencna baza za P4----
d = cell(1,5);
for k = 1:5 
    d{k} = @(x) x.^(k-1);
end

%------T2 BAZA(TRIGONOMETRICNA)-------
t = cell(1,5);
t{1} = @(x) 1./sqrt(2*pi) + 0*x;
t{2} = @(x) 1./sqrt(pi)*cos(x);
t{3} = @(x) 1./sqrt(pi)*sin(x);
t{4} = @(x) 1./sqrt(pi)*cos(2*x);
t{5} = @(x) 1./sqrt(pi)*sin(2*x);

%-------------GLAVNI DEL----------------
uno = MNKzvezna(funkcija, d);
dos = MNKdiskretna(funkcija,d);
tres = MNKzvezna(funkcija, t);
cuatro = MNKdiskretna(funkcija,t);

%------------FUNKCIJE POLINOMOV-------
ena = @(x) polyval(fliplr(uno),x);
dva = @(x) polyval(fliplr(dos),x);
tri = @(x) 4.125898298205215*(1./sqrt(2*pi) + 0*x) -1.375079472208093*(1./sqrt(pi))*cos(x) ...
 -0.741196519820662*(1./sqrt(pi)*sin(x)) - 0.184659763333701*(1./sqrt(pi))*cos(2*x) ...
 + 0.458216683192082*(1./sqrt(pi))*sin(2*x);
stiri = @(x) 4.124646499251147*(1./sqrt(2*pi) + 0*x) -1.376850030718377*(1./sqrt(pi))*cos(x) ...
 -0.741578674049227*(1./sqrt(pi)*sin(x)) - 0.186431066060516*(1./sqrt(pi))*cos(2*x) ...
 + 0.457451767997762*(1./sqrt(pi))*sin(2*x);


sedem = @(x) (ena(x) - funkcija(x));
osem = @(x) (dva(x) - funkcija(x));
devet = @(x) (tri(x) - funkcija(x));
deset = @(x) (stiri(x) - funkcija(x));

%-----------NAPAKE----------------
napaka1 = sqrt(zvezni_skalarni_produkt(sedem,sedem,0,2*pi));
napaka2 = sqrt(zvezni_skalarni_produkt(osem,osem,0,2*pi));
napaka3 = sqrt(zvezni_skalarni_produkt(devet,devet,0,2*pi));
napaka4 = sqrt(zvezni_skalarni_produkt(deset,deset,0,2*pi));

%-------OBCUTLJIVOST----------------------
% K = norm(A)*norm(inv(A))

%-------------METODA NAJMANJSIH KVADRATOV-ZVEZNA--------------------------
function seznam_koeficientov = MNKzvezna(f, seznam_funkcij)
    n = size(seznam_funkcij,2);
    G = zeros(n,n);
    for i = 1:n 
        for j =1:n
            G(i,j) = zvezni_skalarni_produkt(seznam_funkcij{i}, seznam_funkcij{j},0,2*pi);
        end
    end
    %G;
    de = [];
    for k = 1:n
        de = [de; zvezni_skalarni_produkt(seznam_funkcij{k}, f,0,2*pi)];
    end
    %de;
    seznam_koeficientov = (G\de)';

end

%-------------METODA NAJMANJSIH KVADRATOV-DISKRETNA--------------------------
function seznam_koeficientov = MNKdiskretna(f, seznam_funkcij)
    n = size(seznam_funkcij,2);
    G = zeros(n,n);
    for i = 1:n 
        for j =1:n
            G(i,j) = diskretni_skalarni_produkt(seznam_funkcij{i}, seznam_funkcij{j},50);
        end
    end
    %G;
    de = [];
    for k = 1:n
        de = [de; diskretni_skalarni_produkt(seznam_funkcij{k}, f,50)];
    end
    %de;
    seznam_koeficientov = (G\de)';

end


%--------SKALARNI PRODUKTI--------------------------
function vsota = diskretni_skalarni_produkt(f,g,N)
    s = 0;
    for i = 0:N
        s = s + (1/(N+1))*f(2*pi*i/N)*g(2*pi*i/N);
    end
    vsota = s;
end

function integ = zvezni_skalarni_produkt(f,g,a,b)
    fun3 = @(x) f(x).*g(x);
    integ = integral(fun3, a, b, 'AbsTol',1e-14, 'RelTol',1e-14);
end