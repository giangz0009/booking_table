import 'package:booking_table/client/controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_table/client/routes/app_routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCtrl = UserController.to;

    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: Obx(() {
        final u = userCtrl.user.value;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (u != null)
              Column(
                children: [
                  CircleAvatar(radius: 36, child: Text(u.name.isNotEmpty ? u.name[0].toUpperCase() : 'U')),
                  const SizedBox(height: 8),
                  Text(u.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(u.email ?? ''),
                  Text(u.role),
                ],
              ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Đổi thông tin'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Get.toNamed(AppRoutes.updateInfo),
            ),
            ListTile(
              title: const Text('Đổi mật khẩu'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Get.toNamed(AppRoutes.changePassword),
            ),
            const Divider(),
            ListTile(
              title: const Text('Theme'),
              subtitle: const Text('Tự tuỳ biến sau'),
              onTap: () {},
            ),
          ],
        );
      }),
    );
  }
}
