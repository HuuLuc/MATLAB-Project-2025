function I = simpson13(f, a, b, N)

if mod(N, 2) ~= 0
   uialert(app.UIFigure, "N phải là số chẵn để áp dụng Simpson 1/3", "Lỗi");
end

h = (b - a)/N;   
sum1 = 0;
sum2 = 0;
            
for k = 1:2:(N - 1)
    sum1 = sum1 + f(a + k*h);
end

for k = 2:2:(N - 2)
    sum2 = sum2 + f(a + k*h);
end
            
I = (h/3)*(f(a) + f(b) + 4*sum1 + 2*sum2);
end