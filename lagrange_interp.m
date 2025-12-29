function [Px, poly_str] = lagrange_interp(X, Y, x_interp)
    n = length(X);
    if length(Y) ~= n
        error('Vectors X and Y must have the same length.');
    end
    
    % Kiểm tra các giá trị x trùng lặp
    if length(unique(X)) ~= n
        error('Duplicate x-values are not allowed in interpolation.');
    end
    
    % --- 1. TÍNH GIÁ TRỊ NỘI SUY Px (Giữ nguyên) ---
    Px = 0; 
    
    for i = 1:n
        Li = 1; 
        for j = 1:n
            if i ~= j
                Li = Li * (x_interp - X(j)) / (X(i) - X(j));
            end
        end
        
        Px = Px + Y(i) * Li;
    end
    
    % --- 2. TÌM HỆ SỐ ĐA THỨC VÀ TẠO CHUỖI ĐỂ HIỂN THỊ (Đã khắc phục cảnh báo) ---
    
    p = polyfit(X, Y, n - 1); 
    
    poly_terms = cell(1, n); 
    
    precision = 5; 
    format_spec = ['%.', num2str(precision), 'f']; 
    
    first_term = true; % Cờ để xử lý dấu hạng tử đầu tiên

    for k = 1:n
        coeff = p(k);
        degree = n - k;
        
        coeff_rounded = round(coeff, precision);
        
        % Nếu hệ số quá nhỏ (gần như bằng 0), bỏ qua
        if abs(coeff_rounded) < 10^(-precision) && degree ~= 0 
            continue;
        end
        
        current_coeff = abs(coeff); % Giá trị tuyệt đối của hệ số
        
        % Định dạng số thành chuỗi
        coeff_str = sprintf(format_spec, current_coeff);
        
        % --- Xử lý Dấu và Hạng tử ---
        
        term = '';
        
        if coeff < 0
            % Nếu âm, bắt đầu bằng dấu trừ
            term = '-';
        elseif ~first_term
            % Nếu không phải hạng tử đầu tiên và dương, thêm dấu cộng
            term = '+';
        end
        
        % --- Xây dựng Hạng tử: a*x^k ---
        
        % Nối hệ số (chỉ cần nối nếu nó không phải là 1, trừ khi là hằng số)
        if degree > 0 || (degree == 0 && abs(coeff_rounded) ~= 0)
            term = strcat(term, coeff_str);
        end
        
        if degree > 1
            % Ví dụ: 0.125*x^2
            term = strcat(term, '*x^', num2str(degree));
        elseif degree == 1
            % Ví dụ: 2.0*x
            term = strcat(term, '*x');
        end
        
        % Thêm hạng tử đã xây dựng vào Cell Array
        poly_terms{k} = term;
        first_term = false; % Đánh dấu đã xử lý hạng tử đầu tiên
    end
    
    % !!! KHẮC PHỤC CẢNH BÁO: Sử dụng strjoin để nối chuỗi chỉ một lần !!!
    poly_terms(cellfun('isempty', poly_terms)) = [];
    if isempty(poly_terms)
        poly_str = '0.0';
    else
        % Nối tất cả các hạng tử trong cell array lại với nhau (không cần dấu cách)
        poly_str = strjoin(poly_terms, '');
    end
    
    % Xử lý thêm dấu cách giữa các dấu + và - để dễ đọc (ví dụ: '+2.0' -> ' + 2.0')
    poly_str = strrep(poly_str, '+', ' + ');
    poly_str = strrep(poly_str, '-', ' - ');
    
    % Dọn dẹp dấu trừ ở đầu (ví dụ: ' - 0.125' -> '-0.125')
    if startsWith(poly_str, ' - ')
        poly_str = poly_str(3:end);
        poly_str = strcat('-', poly_str);
    % Dọn dẹp dấu cộng ở đầu (ví dụ: ' + 2.0' -> '2.0')
    elseif startsWith(poly_str, ' + ')
        poly_str = poly_str(3:end);
    end
end