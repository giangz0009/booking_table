// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:booking_table/client/controllers/UserController.dart';
//
// class RoleMiddleware extends GetMiddleware {
//   final List<String> allowedRoles;
//
//   RoleMiddleware({required this.allowedRoles});
//
//   @override
//   RouteSettings? redirect(String? route) {
//     final user = UserController.to.user.value;
//
//     if (user == null) {
//       // Nếu chưa đăng nhập -> quay về login
//       return const RouteSettings(name: '/login');
//     }
//
//     if (!allowedRoles.contains(user.role)) {
//       // Nếu không đủ quyền -> quay về trang trước
//       Future.delayed(Duration.zero, () {
//         Get.back();
//         Get.snackbar(
//           "Thông báo",
//           "Bạn không có quyền truy cập",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       });
//       return null; // giữ nguyên flow
//     }
//
//     return null; // có quyền thì cho đi
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/UserController.dart';

class RoleMiddleware extends GetMiddleware {
  final String requiredRole;
  RoleMiddleware(this.requiredRole);

  @override
  RouteSettings? redirect(String? route) {
    final userController = Get.find<UserController>();

    if (!userController.isLoggedIn) {
      // Nếu chưa login -> quay lại màn hình login
      return const RouteSettings(name: '/login');
    }

    if (userController.role != requiredRole) {
      // Nếu role không hợp lệ -> hiển thị thông báo + chặn truy cập
      Future.delayed(Duration.zero, () {
        Get.snackbar("Cảnh báo", "Bạn không có quyền truy cập trang này");
        Get.back(); // quay lại trang trước đó
      });
      return null; // Không cho vào route đó
    }

    return null; // Cho phép vào route
  }
}
