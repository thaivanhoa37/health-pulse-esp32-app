# Health Pulse ESP32 App

## Tổng quan

Health Pulse ESP32 App là một dự án theo dõi sức khỏe sử dụng vi xử lý ESP32 kết hợp với cảm biến MAX30102 để đo các chỉ số như nhịp tim (Heart Rate), SpO2 và nhiệt độ. Dữ liệu được gửi lên Firebase Realtime Database và hiển thị trên ứng dụng Flutter đa nền tảng (Android/iOS/Linux/Windows).

## Chức năng chính

- Đo nhịp tim, SpO2 và nhiệt độ bằng cảm biến MAX30102 kết nối ESP32.
- Hiển thị dữ liệu thời gian thực trên app Flutter: biểu đồ ECG, nhịp tim, SpO2, nhiệt độ.
- Gửi dữ liệu về Firebase Realtime Database.
- Cảnh báo khi các chỉ số vượt ngưỡng (buzzer trên ESP32, gửi thông báo lên Firebase).
- Giao diện app đa nền tảng: Android, iOS, Desktop (Linux/Windows).
- Quản lý, hiển thị thông tin bệnh nhân (matricule).

## Cài đặt

### 1. Phần ESP32 (Micropython)

- Yêu cầu: ESP32, cảm biến MAX30102, OLED SSD1306, buzzer.
- Flash firmware Micropython cho ESP32.
- Clone mã nguồn:
  ```bash
  git clone https://github.com/thaivanhoa37/health-pulse-esp32-app.git
  ```
- Copy code từ thư mục `Source Code micropython/` lên ESP32.
- Cấu hình WiFi, Firebase trong code (SSID, password, FIREBASE_HOST, FIREBASE_AUTH).
- Kết nối phần cứng: MAX30102 (I2C), OLED SSD1306, buzzer.
- Chạy file `main.py` hoặc `main - Copy.py`.

### 2. Ứng dụng Flutter

- Yêu cầu: Flutter SDK, Android Studio/Xcode/VSCode.
- Di chuyển vào thư mục app:
  ```bash
  cd health-pulse-esp32-app/myhealth
  ```
- Cài đặt dependencies:
  ```bash
  flutter pub get
  ```
- Cấu hình Firebase cho app (thêm google-services.json, Info.plist nếu cần).
- Chạy app:
  ```bash
  flutter run
  ```
- App sẽ kết nối dữ liệu với Firebase và hiển thị thông số sức khỏe.

## Sử dụng

1. Khởi động ESP32, đảm bảo kết nối mạng.
2. Mở app Flutter trên điện thoại/PC.
3. Đăng nhập/mở màn hình bệnh nhân (matricule).
4. Theo dõi các chỉ số sức khỏe hiển thị trực tiếp.
5. Nhận cảnh báo khi có dấu hiệu bất thường.

## Yêu cầu hệ thống

- ESP32 đã flash Micropython.
- Cảm biến MAX30102, OLED SSD1306, buzzer.
- Tài khoản Firebase và cấu hình database.
- Máy tính cài Flutter SDK, Android Studio hoặc Xcode (nếu chạy trên mobile).
- Kết nối internet ổn định.

## Thư mục chính

- `Source Code micropython/`: Code ESP32 đo và gửi dữ liệu sức khỏe.
- `myhealth/`: Ứng dụng Flutter hiển thị dữ liệu, giao diện người dùng.
  - `lib/`: Mã nguồn chính của app Flutter.
  - `components/`: Biểu đồ và các widget hiển thị chỉ số.
  - `controller/`: Quản lý dữ liệu bệnh nhân.

## Đóng góp

Bạn có thể fork dự án, tạo pull request hoặc liên hệ chủ repo để đóng góp thêm tính năng!

---

**Tác giả:** [thaivanhoa37](https://github.com/thaivanhoa37)

**Repo gốc:** [ThaiVanHoa/health-pulse-esp32-app](https://github.com/ThaiVanHoa/health-pulse-esp32-app)
