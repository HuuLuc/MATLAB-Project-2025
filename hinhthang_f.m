function I = hinhthang_f(f, a, b, N)

h = (b - a)/N;
s = f(a) + f(b);

for k = 1:(N - 1)
    xk = a + k*h;
    s = s + 2*f(xk);
end

I = (h/2)*s;
end