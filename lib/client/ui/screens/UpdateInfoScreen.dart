import 'package:booking_table/client/controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final u = UserController.to.user.value;
    _nameCtrl.text = u?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final userCtrl = UserController.to;

    return Scaffold(
      appBar: AppBar(title: const Text('Đổi thông tin')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Họ & Tên'),
              validator: (v) => (v == null || v.isEmpty) ? 'Nhập tên' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                await userCtrl.updateProfile(name: _nameCtrl.text.trim());
                Get.back();
                Get.snackbar('Thành công', 'Đã cập nhật thông tin');
              },
              child: const Text('Xác nhận'),
            )
          ],
        ),
      ),
    );
  }
}
