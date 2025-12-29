function result = tinh_newton_lui(f, x0, h, sai_so)
    % Hàm tính đạo hàm theo Newton Lùi
    
    if strcmp(sai_so, 'O(h)')
        % Công thức 2 điểm: (f(x) - f(x-h)) / h
        result = (f(x0) - f(x0 - h)) / h;
    else
        % Công thức 3 điểm: (3f(x) - 4f(x-h) + f(x-2h)) / 2h
        fx0 = f(x0);
        fx_minus1 = f(x0 - h);
        fx_minus2 = f(x0 - 2*h);
        result = (3*fx0 - 4*fx_minus1 + fx_minus2) / (2*h);
    end
end