function [a0, a1, r2] = HoiQuyTuyenTinh(x,y)

n = length(x);
sum_x = 0;
sum_y = 0;
sum_xy = 0;
sum_x_binh=0;
sum_Sr = 0;
sum_St = 0;

for i=1:n
   sum_xy=sum_xy+ x(i)*y(i);
   sum_x = sum_x + x(i);
   sum_y = sum_y + y(i);
   sum_x_binh = sum_x_binh + (x(i))^2;   
end

binh_sumx = sum_x^2;
a1 = (n*sum_xy - sum_x * sum_y) / (n*sum_x_binh - binh_sumx);
y_trungbinh = sum_y / n;
x_trunbinh = sum_x /n;
a0 = y_trungbinh - a1*x_trunbinh;

for i=1:n
    sum_Sr = sum_Sr + (y(i) - a0 -a1*x(i))^2;
    sum_St = sum_St + (y(i) - y_trungbinh)^2;
end
r2 = (sum_St - sum_Sr)/sum_St;
end