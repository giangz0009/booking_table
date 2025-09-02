import 'package:booking_table/client/controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_table/client/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCtrl = UserController.to;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed(AppRoutes.settings),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await userCtrl.signOut();
              Get.snackbar('Đăng xuất', 'Bạn đã đăng xuất');
            },
          )
        ],
      ),
      body: Center(
        child: Obx(() {
          final u = userCtrl.user.value;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(u != null ? 'Xin chào, ${u.name}' : 'Xin chào'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.table_bar),
                label: const Text('Quản lý bàn'),
                onPressed: () => Get.toNamed(AppRoutes.tables),
              ),
            ],
          );
        }),
      ),
    );
  }
}
