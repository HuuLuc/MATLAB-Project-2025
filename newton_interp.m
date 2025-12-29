function [Px, poly_str] = newton_interp(X, Y, x_interp)
    n = length(X);
    if length(Y) ~= n
        error('Vectors X and Y must have the same length.');
    end
    
    if length(unique(X)) ~= n
        error('Duplicate x-values found, resulting in zero division.');
    end
    
    D = zeros(n, n);
    D(:, 1) = Y';
    
    for j = 2:n 
        for i = j:n
            denominator = X(i) - X(i-j+1);
            if denominator == 0
                error('Error in divided difference calculation: Zero denominator.');
            end
            D(i, j) = (D(i, j-1) - D(i-1, j-1)) / denominator;
        end
    end
    
    % --- 2. TÍNH GIÁ TRỊ ĐA THỨC P(x_interp) DÙNG DÒNG ĐẦU BẢNG SAI PHÂN ---
    
    % Các hệ số Newton là các phần tử trên đường chéo chính (D(i, i))
    Px = D(1, 1); % Bắt đầu với f[x0]
    term = 1;
    for i = 2:n
        term = term * (x_interp - X(i-1));
        Px = Px + D(i, i) * term;
    end
        
    % --- 3. TẠO CHUỖI ĐA THỨC THEO THỨ TỰ GIẢM DẦN (Đã khắc phục cảnh báo) ---
    
    p = polyfit(X, Y, n - 1); 
    
    poly_terms = cell(1, n); 
    
    precision = 5; % Độ chính xác hiển thị
    format_spec = ['%.', num2str(precision), 'f']; % Định dạng số
    first_term = true; 

    for k = 1:n
        coeff = p(k);
        degree = n - k;
        
        coeff_rounded = round(coeff, precision);
        
        if abs(coeff_rounded) < 10^(-precision) && degree ~= 0 
            continue;
        end
        
        current_coeff = abs(coeff); % Giá trị tuyệt đối của hệ số
        
        % Định dạng số thành chuỗi
        coeff_str = sprintf(format_spec, current_coeff);
        
        % --- Xử lý Dấu và Hạng tử ---
        
        term = '';
        
        if coeff < 0
            term = '-';
        elseif ~first_term
            term = '+';
        end
        
        % --- Xây dựng Hạng tử: a*x^k ---
        
        % Nối hệ số
        if degree > 0 || (degree == 0 && abs(coeff_rounded) ~= 0)
            term = strcat(term, coeff_str);
        end
        
        if degree > 1
            term = strcat(term, '*x^', num2str(degree));
        elseif degree == 1
            term = strcat(term, '*x');
        end
        
        % !!! KHẮC PHỤC CẢNH BÁO: Gán trực tiếp vào chỉ mục Cell Array (tối ưu hiệu suất) !!!
        poly_terms{k} = term; 
        first_term = false; 
    end
    
    % Loại bỏ các phần tử rỗng trong poly_terms trước khi nối (do các hạng tử bị bỏ qua)
    poly_terms(cellfun('isempty', poly_terms)) = []; 
    
    if isempty(poly_terms)
        poly_str = '0.0';
    else
        % Nối tất cả các hạng tử
        poly_str = strjoin(poly_terms, '');
    end
    
    % Xử lý thêm dấu cách và dọn dẹp chuỗi (như hàm Lagrange)
    poly_str = strrep(poly_str, '+', ' + ');
    poly_str = strrep(poly_str, '-', ' - ');
    
    if startsWith(poly_str, ' - ')
        poly_str = poly_str(3:end);
        poly_str = strcat('-', poly_str);
    elseif startsWith(poly_str, ' + ')
        poly_str = poly_str(3:end);
    end
end