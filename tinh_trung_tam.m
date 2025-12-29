function result = tinh_trung_tam(f, x0, h, sai_so)
    % Hàm tính đạo hàm theo Newton Trung Tâm (Central Difference)
    
    if strcmp(sai_so, 'O(h)')
        % Dùng công thức trung tâm 2 điểm (Thực tế chính xác O(h^2))
        result = (f(x0 + h) - f(x0 - h)) / (2*h);
    else
        % Dùng công thức trung tâm 4 điểm (Độ chính xác cao ~O(h^4))
        term1 = -f(x0 + 2*h);
        term2 = 8 * f(x0 + h);
        term3 = -8 * f(x0 - h);
        term4 = f(x0 - 2*h);
        result = (term1 + term2 + term3 + term4) / (12*h);
    end
end