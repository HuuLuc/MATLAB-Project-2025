function plot_interp(app, X, Y, method, x_interp, result)
% PLOT_INTERP Vẽ biểu đồ nội suy
%   plot_interp(X, Y, method, x_interp, result) vẽ đường nội suy và các điểm dữ liệu.

    cla(app.UIAxes_2); 
    
    % Giữ đồ thị để vẽ nhiều đối tượng lên cùng một trục
    hold(app.UIAxes_2, 'on'); 
    
    % 1. Vẽ các điểm dữ liệu ban đầu
    plot(app.UIAxes_2, X, Y, 'o', 'MarkerFaceColor', [0 0.4470 0.7410], 'DisplayName', 'Điểm Dữ Liệu');
    
    % 2. Tạo đường cong nội suy mượt
    x_plot = linspace(min(X), max(X), 100);
    y_plot = zeros(size(x_plot));
    
    % Tính giá trị y cho đường cong (giả định các hàm lagrange_interp và newton_interp đã tồn tại)
    for k = 1:length(x_plot)
        if strcmp(method, 'Lagrange')
            % Gọi hàm Lagrange đã tách
            y_plot(k) = lagrange_interp(X, Y, x_plot(k)); 
        elseif strcmp(method, 'Nội suy Newton')
            % Gọi hàm Newton đã tách
            y_plot(k) = newton_interp(X, Y, x_plot(k)); 
        end
    end
    
    % Vẽ đường cong nội suy
    plot(app.UIAxes_2, x_plot, y_plot, '-', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1.5, 'DisplayName', [method ' Curve']);
    
    % 3. Vẽ điểm nội suy đã tính
    plot(app.UIAxes_2, x_interp, result, 'r*', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', ['Kết Quả tại x = ' num2str(x_interp, 4)]);
    
    % 4. Thiết lập đồ thị trên UIAxes
    title(app.UIAxes_2, ['Nội Suy ' method]);
    xlabel(app.UIAxes_2, 'X');
    ylabel(app.UIAxes_2, 'Y');
    
    legend(app.UIAxes_2, 'show', 'Location', 'best'); 
    grid(app.UIAxes_2, 'on');
    
    % Tắt chế độ giữ đồ thị
    hold(app.UIAxes_2, 'off');
end