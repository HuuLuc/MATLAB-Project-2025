function [root, iter] = FixedPoint(g, x0, eps)
% FIXEDPOINT  Phương pháp lặp x = g(x)

iter = 0;

while true
    x1 = g(x0);
    iter = iter + 1;

    if abs(x1 - x0) < eps
        break;
    end

    x0 = x1;
end

root = x1;
end
