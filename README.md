# 🍽️ Restaurant Table Management App

Ứng dụng Flutter giúp quản lý bàn trong nhà hàng với các chức năng cơ bản:
- Quản lý trạng thái bàn (còn trống, chờ phục vụ, đang phục vụ).
- Gọi món & quản lý thực đơn.
- Thanh toán hóa đơn.
- Xem thống kê doanh thu.

---

## 🚀 Công nghệ sử dụng
- **Flutter** (Dart)
- **Provider** (hoặc Riverpod, tùy chọn) cho State Management
- **Firebase** (tuỳ chọn, cho đăng nhập và lưu dữ liệu)
- **Sqflite** (nếu lưu trữ offline)

---

## 📂 Cấu trúc thư mục
lib/
│── main.dart # Điểm khởi chạy ứng dụng
│
├── core/ # Các config, constants, theme, utils
│ ├── constants/
│ ├── theme/
│ └── utils/
│
├── data/ # Dữ liệu (API services, local DB, models)
│ ├── models/ # Định nghĩa các model (Table, Order, Food, ...)
│ ├── services/ # API / Database services
│ └── repositories/ # Xử lý dữ liệu từ services
│
├── providers/ # State management (Provider / Riverpod)
│
├── ui/ # Toàn bộ phần UI
│ ├── screens/ # Các màn hình chính
│ │ ├── table/ # Quản lý bàn
│ │ ├── order/ # Gọi món
│ │ ├── payment/ # Thanh toán
│ │ └── stats/ # Thống kê
│ │
│ ├── widgets/ # Các widget dùng chung (button, card, ...)
│ └── dialogs/ # Các popup, dialog
│
└── routes/ # Điều hướng các màn hình
---

## ⚡ Hướng dẫn cài đặt

### 1. Clone dự án
```bash
git clone https://github.com/your-username/restaurant_table_app.git
cd restaurant_table_app
```
### 2. Cài đặt dependencies
   flutter pub get
### 3. Chạy ứng dụng
   flutter run