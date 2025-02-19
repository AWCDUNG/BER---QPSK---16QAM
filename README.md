# Khảo sát tỉ lệ lỗi bit (BER) lý thuyết và thực tế trên kênh truyền AWGN với các phương pháp điều chế QPSK và 16-QAM

## Giới thiệu
Mã MATLAB này mô phỏng hiệu suất của điều chế 16-QAM và QPSK bằng cách tính toán tỷ lệ lỗi bit (BER) thực tế và lý thuyết dựa trên tỷ lệ tín hiệu trên nhiễu (SNR). Chương trình tạo dữ liệu, điều chế tín hiệu, thêm nhiễu Gaussian, giải điều chế và so sánh BER.

## Kiến thức về QPSK và 16-QAM

### QPSK (Quadrature Phase Shift Keying)
QPSK là phương pháp điều chế số trong đó mỗi ký hiệu mang hai bit dữ liệu, nhờ đó giúp cải thiện hiệu suất băng thông so với BPSK. Chòm sao QPSK bao gồm 4 điểm nằm trên trục I-Q với các pha 0°, 90°, 180°, và 270°.

- **Nguyên tắc hoạt động:**
  - Ánh xạ 2 bit thành một ký hiệu.
  - Các ký hiệu được biểu diễn dưới dạng số phức: \( S = I + jQ \), trong đó \( I, Q \) nhận giá trị \( \pm 1 \).
  - Khi truyền qua kênh, tín hiệu bị ảnh hưởng bởi nhiễu Gaussian.
  - Ở phía thu, bộ giải điều chế quyết định giá trị bit dựa trên phần thực và phần ảo của tín hiệu nhận.

### 16-QAM (16-Quadrature Amplitude Modulation)
16-QAM sử dụng 16 điểm trong chòm sao để biểu diễn tín hiệu, với mỗi ký hiệu mang 4 bit dữ liệu, giúp tăng tốc độ truyền dữ liệu so với QPSK nhưng yêu cầu SNR cao hơn để đạt cùng mức BER.

- **Nguyên tắc hoạt động:**
  - Ánh xạ 4 bit thành một ký hiệu dựa trên mã Gray.
  - Các mức biên độ của tín hiệu điều chế được xác định theo \( \pm 1, \pm 3 \) trên cả hai trục I và Q.
  - Khi truyền qua kênh, tín hiệu bị nhiễu và có thể dịch khỏi vị trí ban đầu.
  - Bộ giải điều chế sẽ quyết định vị trí gần nhất trong chòm sao và giải mã lại thành bit dữ liệu.

## Cấu trúc mã

- **Khởi tạo thông số:**
  - `N`: Số ký tự hoặc số bit truyền
  - `M`: Số mức của chòm sao (16-QAM hoặc QPSK)
  - `k`: Số bit trên mỗi ký tự
  - `Eb_N0_dB`, `SNRdB`: Tỷ lệ năng lượng bit trên nhiễu theo dB
  - `alphaRe`, `alphaIm`: Các mức biên độ của chòm sao

- **Mô phỏng truyền dữ liệu:**
  - Sinh dãy bit ngẫu nhiên
  - Điều chế 16-QAM/QPSK sử dụng mã Gray
  - Thêm nhiễu AWGN
  - Giải điều chế và ước lượng BER

- **Biểu đồ và phân tích:**
  - Vẽ đồ thị BER lý thuyết và thực nghiệm
  - Hiển thị sơ đồ chòm sao (chỉ cho 16-QAM)
  - Xuất thông tin BER

## Cách chạy mã
1. Mở MATLAB
2. Chạy tập lệnh `.m`
3. Xem kết quả BER và sơ đồ chòm sao (nếu có)

## Kết quả
Kết quả mô phỏng cho thấy rằng BER của QPSK thấp hơn so với 16-QAM trong cùng điều kiện SNR. Điều này là do khoảng cách giữa các ký hiệu trong chòm sao QPSK lớn hơn so với 16-QAM, giúp giảm xác suất lỗi khi có nhiễu.

- Với mức SNR thấp, BER của cả hai phương pháp điều chế đều cao, nhưng BER của 16-QAM cao hơn đáng kể so với QPSK.
- Khi tăng SNR, BER của cả hai phương pháp giảm, nhưng QPSK đạt mức lỗi thấp hơn so với 16-QAM ở cùng mức SNR.
- Kết quả thực nghiệm phù hợp với kết quả lý thuyết, với sai lệch nhỏ do số lượng mẫu hữu hạn trong mô phỏng.

### Kết luận
- QPSK có hiệu suất BER tốt hơn so với 16-QAM trong môi trường AWGN khi xét trên cùng mức SNR.
- 16-QAM có tốc độ dữ liệu cao hơn nhưng yêu cầu SNR lớn hơn để đạt BER thấp.
- Việc lựa chọn phương pháp điều chế phụ thuộc vào yêu cầu về băng thông và độ tin cậy của hệ thống.

## Yêu cầu hệ thống
- MATLAB phiên bản mới
- Bộ xử lý đủ mạnh để chạy mô phỏng với số lượng ký tự lớn

## Liên hệ
Nếu có bất kỳ câu hỏi nào, hãy liên hệ qua [GitHub Issues] hoặc 21013348@st.phenikaa-uni.edu.vn

