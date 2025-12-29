function [root, iter] = NewtonMethod(f, df, x0, eps)
% NEWTONMETHOD  Phương pháp Newton-Raphson

iter = 0;

while true
    if df(x0) == 0
        error('Đạo hàm bằng 0 – Newton không hội tụ');
    end

    x1 = x0 - f(x0)/df(x0);
    iter = iter + 1;

    if abs(x1 - x0) < eps
        break;
    end

    x0 = x1;
end

root = x1;
end
