# Ứng Dụng UniScore 📊
Ứng dụng **"UniScore"** giúp sinh viên tính toán điểm trung bình môn, GPA và theo dõi tiến trình học tập. Ứng dụng cung cấp giao diện thân thiện, dễ sử dụng và hỗ trợ chế độ sáng/tối cho trải nghiệm người dùng tối ưu.

## Mục Tiêu 🎯
- Tính toán điểm trung bình môn và GPA cho sinh viên.
- Lưu trữ lịch sử tính điểm và theo dõi kết quả học tập.
- Giúp sinh viên quản lý và phân loại các môn học theo học kỳ và năm học.
- Hỗ trợ chế độ sáng/tối cho người dùng tùy chỉnh.

## Các Tính Năng Chính 🛠️
- **Tính điểm trung bình môn** 🎓: Cho phép nhập điểm các môn học và tính toán điểm trung bình môn.
- **Tính điểm GPA** 📈: Tính toán điểm GPA dựa trên các hệ số môn học.
- **Lịch sử tính điểm** 📜: Lưu trữ kết quả tính điểm theo thời gian.
- **Xếp loại tốt nghiệp** 🏅: Giúp sinh viên xác định xếp loại tốt nghiệp dựa trên điểm GPA.
- **Chế độ sáng/tối** 🌞🌜: Người dùng có thể chuyển đổi giữa chế độ sáng và chế độ tối theo sở thích cá nhân.

## Cấu Trúc Dự Án 📁
Dự án sử dụng Flutter để phát triển ứng dụng di động với cấu trúc thư mục rõ ràng và dễ quản lý. Các phần chính trong dự án bao gồm:
- **models/**: Các mô hình dữ liệu (Subject, Grade, History, User).
- **screens/**: Các màn hình của ứng dụng (Home, GPA Calculator, History, Profile).
- **components/**: Các widget tùy chỉnh (buttons, app bar, grade input form).
- **network/**: Quản lý các yêu cầu API (nếu có).
- **state_management/**: Quản lý trạng thái của ứng dụng (Provider/Riverpod).
- **utils/**: Các tiện ích (định dạng điểm số, chuyển đổi hệ điểm).

## Công Nghệ Sử Dụng ⚙️
- **Flutter**: Framework để phát triển ứng dụng di động.
- **Provider** hoặc **Riverpod**: Quản lý trạng thái.
- **SQLite**: Lưu trữ dữ liệu cục bộ (lưu trữ lịch sử tính điểm, môn học yêu thích, v.v.).

## Screenshots
<!--  <div style="display: flex; flex-wrap: wrap; gap: 20px; justify-content: center;">
    <img src="https://imgur.com/GAs1eMF.png" alt="Image 1" style="width: 45%; height: auto; object-fit: cover; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
    <img src="https://imgur.com/RSfEyWZ.png" alt="Image 2" style="width: 45%; height: auto; object-fit: cover; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
    <img src="https://imgur.com/7qqb0Ij.png" alt="Image 3" style="width: 45%; height: auto; object-fit: cover; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
    <img src="https://imgur.com/oI4HpUu.png" alt="Image 4" style="width: 45%; height: auto; object-fit: cover; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
</div> -->

## Hướng Dẫn Cài Đặt 🛠️
### Điều Kiện
Đảm bảo bạn đã cài đặt những phần mềm sau trên máy của mình:
- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter
- Android Studio (for Android development)
- Visual Studio Code or any other IDE

1. Clone dự án về máy của bạn:
   ```bash
   git clone https://github.com/NguyenNhatHuynh/UniScore.git
2. Chuyển đến thư mục dự án:
   ```bash
   cd UniScore
3. Cài đặt các phụ thuộc:
   ```bash
   flutter pub get
4. Chạy ứng dụng:
    ```bash
   flutter run

## ✅ Todo
### Giao Diện Người Dùng
- [ ] Tính điểm trung bình môn: Cho phép nhập điểm và tính toán điểm trung bình.
- [ ] Tính điểm GPA: Cung cấp công cụ tính toán GPA theo hệ số.
- [ ] Lịch sử tính điểm: Lưu trữ kết quả tính điểm và cho phép người dùng xem lại.
- [ ] Chế độ sáng/tối: Cho phép chuyển đổi giữa chế độ sáng và tối.
- [ ] Xếp loại tốt nghiệp: Cung cấp xếp loại tốt nghiệp dựa trên điểm GPA.
- [ ] Xếp loại tốt nghiệp: Cung cấp xếp loại tốt nghiệp dựa trên điểm GPA.
### Giao Diện Người Dùng
- [ ] Trang chủ: Hiển thị các chức năng chính và trạng thái hiện tại của sinh viên.
- [ ] Màn hình tính điểm GPA: Hiển thị công cụ nhập điểm và tính toán GPA.
- [ ] Màn hình lịch sử tính điểm: Hiển thị các lần tính điểm đã lưu trước đó.
- [ ] Profile người dùng: Cho phép người dùng cập nhật thông tin cá nhân.
 
## Tác giả 👨‍💻
Tôi sẽ rất cảm kích nếu bạn có thể cho kho lưu trữ này một ngôi sao 🌟. Nó sẽ giúp những người khác khám phá ra điều này. Cảm ơn vì sự hỗ trợ của bạn [Xoan Dev]👨‍💻
   

