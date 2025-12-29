function I = hinhthang_xy(x, y)
n = length(x);
I = 0;

for i = 1:(n - 1)
    I = I + (y(i) + y(i + 1))*(x(i + 1) - x(i))/2;
end
end