function y = deBoor(t,c,x)
L = length(x);
N = length(t);
cc = length(c);  % = N - k - 1
k = N - cc - 1;

y = zeros(1,L); %seznam kjer shranjujemo vrednosti x-ov
for i = 1:L
    x0 = x(i);
    t2 = t(1, 1 : N-k-1); % iz seznama t izbrise zadnjih k+1 elementov
    j = length(t2(t2 <= x0));  % najde indeks j, da je x \in [t_j, t_{j+1})
    A = zeros(k+1); % matrika, kjer shranjujemo  izracunane vrednosti c_i^r. Na 
                    % koncu pride spodnja trikotna
    A(:, 1) = c(:,(j-k):j);  %prvi stolpec so podane vrednosti
    for r = 1:k     % indeks stolpca
        for p = j-k+r:j   % indeks vrstice
            A(p-j+k+1,r+1) = (1- (x0-t(p))/(t(p+k+1-r)-t(p)))*A(p-j+k,r) ...
                + (x0-t(p))/(t(p+k+1-r)-t(p))*A(p-j+k+1,r);
        end
    end
    y(i) = A(k+1,k+1);
end

end