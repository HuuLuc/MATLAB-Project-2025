function [a, b, r2] = HoiQuyPhiTuyen_HamMu(x,y)
n = length(x);
X = log10(x);
Y = log10(y);
sum_X = 0;
sum_Y = 0;
sum_XY = 0;
sum_X_binh=0;

for i=1:n
   sum_XY=sum_XY+ X(i)*Y(i);
   sum_X = sum_X + X(i);
   sum_Y = sum_Y + Y(i);
   sum_X_binh = sum_X_binh + (X(i))^2;   
end

binh_sumX = sum_X^2;
A1 = (n*sum_XY - sum_X * sum_Y) / (n*sum_X_binh - binh_sumX);
Y_trungbinh = sum_Y / n;
X_trungbinh = sum_X /n;
A0 = Y_trungbinh - A1*X_trungbinh;
a = 10^A0;
b=A1;
st=0;
sr=0;
for i=1:n
    st = st + (Y(i) - Y_trungbinh)^2;
    sr = sr + (Y(i) - (A0 + A1 * X(i)))^2;
end
r2 = (st - sr) / st;
end