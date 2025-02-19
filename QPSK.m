clc; close all; clear;
N = 1e6; % Số bit truyền (1 triệu)
SNRdB = 0:10; % Dải SNR từ 0 đến 10 dB
SNRlinear = 10.^(SNRdB/10); 
BER_MP = zeros(size(SNRlinear)); 

% Tạo dãy bit ngẫu nhiên
b = randi([0 1], 2, N); 

% Ánh xạ bit sang các ký hiệu QPSK
I = 2 * b(1,:) - 1; 
Q = 2 * b(2,:) - 1;
S = I + 1j * Q; % Ký hiệu QPSK

N0 = 1 ./ SNRlinear; % Phương sai nhiễu

for k = 1:length(SNRdB)
    % Tạo nhiễu Gaussian AWGN
    noise = sqrt(N0(k)/2) * (randn(1, N) + 1j * randn(1, N));
    
    % Tín hiệu nhận sau khi truyền qua kênh
    sig_Rx = S + noise;
    
    % Phục hồi tín hiệu (quyết định bit)
    bld = [real(sig_Rx) > 0; imag(sig_Rx) > 0];
    
    % Tính BER
    BER_MP(k) = sum(bld(:) ~= b(:)) / (2 * N);
end

% BER lý thuyết sử dụng hàm erfc thay thế qfunc
BER_LT = 0.5 * erfc(sqrt(SNRlinear));

% Vẽ biểu đồ
figure;
semilogy(SNRdB, BER_LT, 'r-', 'LineWidth', 2, 'DisplayName', 'Lý thuyết');
hold on;
semilogy(SNRdB, BER_MP, 'g*', 'MarkerSize', 8, 'DisplayName', 'Mô phỏng');
grid on;
ax = gca;
ax.GridColor = [0.3, 0.3, 0.3]; % Màu lưới
ax.XColor = 'b'; % Màu trục X
ax.YColor = 'm'; % Màu trục Y
xlabel('SNR (dB)', 'FontSize', 12, 'Color', 'b');
ylabel('BER', 'FontSize', 12, 'Color', 'm');
legend('show', 'Location', 'southwest');
title('BER của QPSK trên kênh AWGN', 'FontSize', 14, 'Color', 'r');
hold off;
