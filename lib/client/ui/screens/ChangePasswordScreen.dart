import 'package:booking_table/client/controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPwdCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _ob1 = true, _ob2 = true;

  @override
  Widget build(BuildContext context) {
    final userCtrl = UserController.to;

    return Scaffold(
      appBar: AppBar(title: const Text('Đổi mật khẩu')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _newPwdCtrl,
              obscureText: _ob1,
              decoration: InputDecoration(
                labelText: 'Mật khẩu mới',
                suffixIcon: IconButton(
                  icon: Icon(_ob1 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _ob1 = !_ob1),
                ),
              ),
              validator: (v) => (v == null || v.length < 6) ? 'Tối thiểu 6 ký tự' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _confirmCtrl,
              obscureText: _ob2,
              decoration: InputDecoration(
                labelText: 'Xác nhận mật khẩu',
                suffixIcon: IconButton(
                  icon: Icon(_ob2 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _ob2 = !_ob2),
                ),
              ),
              validator: (v) => (v != _newPwdCtrl.text) ? 'Không khớp' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                try {
                  await userCtrl.changePassword(_newPwdCtrl.text.trim());
                  Get.back();
                  Get.snackbar('Thành công', 'Đã đổi mật khẩu');
                } catch (e) {
                  Get.snackbar('Lỗi', e.toString());
                }
              },
              child: const Text('Xác nhận'),
            )
          ],
        ),
      ),
    );
  }
}
