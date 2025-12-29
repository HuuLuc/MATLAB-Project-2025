function [root, iter] = Bisection(f, a, b, eps)

iter = 0;

if f(a)*f(b) > 0
    error('f(a) và f(b) phải trái dấu');
end

while (b - a)/2 > eps
    iter = iter + 1;
    c = (a + b)/2;

    if f(c) == 0
        break;
    elseif f(a)*f(c) < 0
        b = c;
    else
        a = c;
    end
end

root = (a + b)/2;
end
