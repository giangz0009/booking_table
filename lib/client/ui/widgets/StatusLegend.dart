import 'package:flutter/material.dart';

class StatusLegend extends StatelessWidget {
  const StatusLegend({super.key});

  Widget _dot(Color c) => Container(width: 16, height: 16, decoration: BoxDecoration(color: c, shape: BoxShape.circle));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [_dot(Colors.green), const SizedBox(width: 8), const Text('Bàn trống')]),
            const SizedBox(height: 6),
            Row(children: [_dot(Colors.orange), const SizedBox(width: 8), const Text('Chờ phục vụ')]),
            const SizedBox(height: 6),
            Row(children: [_dot(Colors.red), const SizedBox(width: 8), const Text('Đang được phục vụ')]),
          ],
        ),
      ),
    );
  }
}
