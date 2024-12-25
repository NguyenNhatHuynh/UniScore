lib/
├── main.dart                     # Điểm vào của ứng dụng, nơi chạy đầu tiên
├── screens/                       # Thư mục chứa các màn hình của ứng dụng
│   ├── home_screen.dart           # Màn hình chính
│   ├── temporary_average_screen.dart  # Màn hình tính điểm trung bình môn học
│   ├── history_screen.dart        # Màn hình lịch sử tính điểm
│   ├── grade_classification_screen.dart # Màn hình xếp loại điểm
    |   gpa_calculator_screen.dart # Màn hình tính điểm GPA
├── widgets/                       # Thư mục chứa các widget tái sử dụng
│   ├── function_card.dart         # Widget card hiển thị các chức năng
│   ├── custom_text_field.dart     # Widget TextField tùy chỉnh (nếu cần)
├── models/                        # Thư mục chứa các mô hình (model)
│   ├── point_history.dart         # Mô hình lịch sử tính điểm
│   ├── grade.dart                 # Mô hình xếp loại điểm
├── services/                      # Thư mục chứa các dịch vụ (services)
│   ├── database_service.dart      # Dịch vụ liên quan đến lưu trữ (SQLite hoặc lưu trữ local)
├── utils/                         # Thư mục chứa các tiện ích (utilities)
│   ├── calculator.dart            # Hàm tính toán điểm trung bình, GPA, xếp loại
│   ├── validator.dart             # Hàm kiểm tra dữ liệu nhập (ví dụ: kiểm tra trọng số)
└── assets/                        # Thư mục chứa tài nguyên như hình ảnh, font chữ
    ├── images/                    # Thư mục chứa hình ảnh
    ├── fonts/                     # Thư mục chứa font chữ tùy chỉnh








- temporary_average_screen.dart => màn hình mới cho chức năng tính điểm trung bình môn học



