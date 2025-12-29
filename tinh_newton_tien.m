function result = tinh_newton_tien(f, x0, h, sai_so)
    % Hàm tính đạo hàm theo Newton Tiến
    % sai_so: chuỗi 'O(h)' hoặc 'O(h^2)'
    
    if strcmp(sai_so, 'O(h)')
        % Công thức 2 điểm: (f(x+h) - f(x)) / h
        result = (f(x0 + h) - f(x0)) / h;
    else
        % Công thức 3 điểm: (-f(x+2h) + 4f(x+h) - 3f(x)) / 2h
        fx0 = f(x0);
        fx1 = f(x0 + h);
        fx2 = f(x0 + 2*h);
        result = (-fx2 + 4*fx1 - 3*fx0) / (2*h);
    end
end