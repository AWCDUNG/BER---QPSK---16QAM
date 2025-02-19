clc; close all; clear;
N = 10^5; % Số ký tự truyền
M = 16; % Số chòm sao
k = log2(M); % Số bit/mỗi ký tự

alphaRe = [-(2*sqrt(M)/2-1):2:-1 1:2:2*sqrt(M)/2-1];
alphaIm = [-(2*sqrt(M)/2-1):2:-1 1:2:2*sqrt(M)/2-1];
k_16QAM = 1/sqrt(10);

Eb_N0_dB = 0:15; % Es/N0 tương ứng
Es_N0_dB = Eb_N0_dB + 10*log10(k);

% Ánh xạ -> mã Gray
ref = 0:k-1;
map = bitxor(ref, floor(ref/2));
[~, ind] = sort(map);

BerThucTe = zeros(1, length(Eb_N0_dB));

for ii = 1:length(Eb_N0_dB)
    % Tạo ký tự
    ipBit = rand(1, N*k) > 0.5; % Ngẫu nhiên 0 và 1
    ipBitReshape = reshape(ipBit, k, N).';
    bin2DecMatrix = ones(N, 1)*(2.^[(k/2-1):-1:0]);
    
    % Phần thực
    ipBitRe = ipBitReshape(:, 1:k/2);
    ipDecRe = sum(ipBitRe.*bin2DecMatrix, 2);
    ipGrayDecRe = bitxor(ipDecRe, floor(ipDecRe/2));
    
    % Phần ảo
    ipBitIm = ipBitReshape(:, k/2+1:k);
    ipDecIm = sum(ipBitIm.*bin2DecMatrix, 2);
    ipGrayDecIm = bitxor(ipDecIm, floor(ipDecIm/2));
    
    % Ánh xạ các ký tự từ Gray code sang chòm sao
    modRe = alphaRe(ipGrayDecRe+1);
    modIm = alphaIm(ipGrayDecIm+1);
    
    % Tạo chòm sao
    mod = modRe + 1j*modIm;
    s = k_16QAM * mod;
    
    % Nhiễu
    n = 1/sqrt(2) * (randn(1, N) + 1j*randn(1, N));
    
    % Thu nhận tín hiệu
    y = s + 10^(-Es_N0_dB(ii)/20)*n;
    
    % Giải mã
    y_re = real(y)/k_16QAM;
    y_im = imag(y)/k_16QAM;
    
    % Làm tròn giá trị thu
    ipHatRe = 2*floor(y_re/2) + 1;
    ipHatRe(ipHatRe > max(alphaRe)) = max(alphaRe);
    ipHatRe(ipHatRe < min(alphaRe)) = min(alphaRe);
    
    ipHatIm = 2*floor(y_im/2) + 1;
    ipHatIm(ipHatIm > max(alphaIm)) = max(alphaIm);
    ipHatIm(ipHatIm < min(alphaIm)) = min(alphaIm);
    
    % Chuyển chòm sao về thập phân
    ipDecHatRe = ind(floor((ipHatRe+4)/2+1))-1;
    ipDecHatIm = ind(floor((ipHatIm+4)/2+1))-1;
    
    % Chuyển đổi sang dạng nhị phân
    ipBinHatRe = dec2bin(ipDecHatRe, k/2) - '0';
    ipBinHatIm = dec2bin(ipDecHatIm, k/2) - '0';
    
    % Đếm số lỗi bit
    BerThucTe(ii) = sum(ipBitRe(:) ~= ipBinHatRe(:)) + sum(ipBitIm(:) ~= ipBinHatIm(:));
end

% Tỷ lệ lỗi bit thực tế và lý thuyết
BerLyThuyet = (1/k) * (3/2) * erfc(sqrt(k*0.1*(10.^(Eb_N0_dB/10))));

% Vẽ đồ thị
figure;
semilogy(Eb_N0_dB, BerLyThuyet, 'r-', 'LineWidth', 2, 'DisplayName', 'Lý thuyết');
hold on;
semilogy(Eb_N0_dB, BerThucTe/(N*k), 'g*', 'LineWidth', 2, 'DisplayName', 'Thực tế');
axis([0 15 10^-5 1]);
grid on;
legend('show', 'Location', 'southwest');
xlabel('SNR [dB]', 'FontSize', 12, 'Color', 'b');
ylabel('BER', 'FontSize', 12, 'Color', 'm');
title('BER với phương pháp điều chế 16-QAM', 'FontSize', 14, 'Color', 'r');
hold off;

% Biểu đồ phân bố chòm sao
figure;
scatter(real(y), imag(y), 'b.');
grid on;
xlabel('I');
ylabel('Q');
title('Sơ đồ chòm sao của 16-QAM');

% Hiển thị thêm thông tin phân tích
fprintf('Phân tích kết quả BER:\n');
for ii = 1:length(Eb_N0_dB)
    fprintf('SNR = %d dB: BER thực tế = %e, BER lý thuyết = %e\n', Eb_N0_dB(ii), BerThucTe(ii)/(N*k), BerLyThuyet(ii));
end
