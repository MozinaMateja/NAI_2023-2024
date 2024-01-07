format long 
f = @(x) exp(-x.^2);
df = @(x) (-2).*x.*exp(-x.^2);
ddf = @(x) (4.*(x.^2)-2).*exp(-x.^2);
a = -1;
b = 4;
x = a:0.5:b;
[y,g] = HermitovPolinom(f,df,ddf,a,b,x);
norm(arrayfun(f,linspace(-1,4,1001))- arrayfun(g,linspace(-1,4,1001)), 'inf');

n = 4;
X = linspace(-1,4,n+1);
HermitovZlepek(f,df,ddf,X,x);
norm(arrayfun(f,linspace(-1,4,1001))- HermitovZlepek(f,df,ddf,X,linspace(-1,4,1001)), 'inf')