function I = simpson38(f, a, b, N)
if mod(N, 3) ~= 0
   uialert(app.UIFigure, "N phải chia hết cho 3 để áp dụng Simpson 3/8", "Lỗi");
end
            
h = (b - a)/N;
sum3 = 0;
sum2 = 0;

for k = 1:(N - 1)
    xk = a + k*h;
    if mod(k, 3) == 0
        sum2 = sum2 + f(xk);
    else
        sum3 = sum3 + f(xk);
    end
end

I = (3*h/8)*(f(a) + f(b) + 3*sum3 + 2*sum2);
end