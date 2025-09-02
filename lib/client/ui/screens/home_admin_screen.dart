// import 'package:booking_table/client/controllers/UserController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class HomeAdminScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final userController = UserController.to;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Trang chủ"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               userController.clearUser();
//               Get.offAllNamed("/login");
//             },
//           )
//         ],
//       ),
//       body: Center(
//         child: Obx(() {
//           if (userController.user.value == null) {
//             return const Text("Không có dữ liệu user");
//           } else {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Xin chào, ${userController.user.value!.name}"),
//                 Text("Email: ${userController.user.value!.email}"),
//                 Text("Role: ${userController.user.value!.role}"),
//               ],
//             );
//           }
//         }),
//       ),
//     );
//   }
// }
//
// class HomeMainScreen extends StatelessWidget {
//   const HomeMainScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           "Welcome to Home Main Screen 🎉",
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final userController = UserController.to;
//
//     return Obx(() {
//       final user = userController.user.value;
//
//       if (user == null) {
//         return const Scaffold(
//           body: Center(child: CircularProgressIndicator()), // đang load
//         );
//       }
//
//       if (user.role == "admin") {
//         return HomeAdminScreen();
//       } else {
//         return HomeMainScreen();
//       }
//     });
//   }
// }
