import 'package:booking_table/client/controllers/TableController.dart';
import 'package:booking_table/client/data/models/Table.dart';
import 'package:booking_table/client/data/models/TableStatus.dart';
import 'package:booking_table/client/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableDetailScreen extends StatelessWidget {
  const TableDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RestaurantTable table = Get.arguments as RestaurantTable;
    final ctrl = Get.find<TableController>();

    Future<void> _pickMerge() async {
      final other = await Get.bottomSheet<String>(
        _SelectTableBottomSheet(excludeId: table.id),
        isScrollControlled: true,
      );
      if (other != null) {
        await ctrl.merge(table.id, other);
        Get.snackbar('Ghép bàn', 'Đã ghép với bàn $other');
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Bàn số: ${table.tableNumber.toString()}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          runSpacing: 16,
          spacing: 16,
          children: [
            _ActionButton(
                icon: Icons.shopping_bag_outlined, 
                label: 'Order', 
                onTap: () { 
                  /* TODO: mở màn order */ 
                  Get.toNamed(AppRoutes.order, arguments: table);
                }
            ),
            _ActionButton(icon: Icons.join_full, label: 'Ghép bàn', onTap: _pickMerge),
            _ActionButton(icon: Icons.call_split, label: 'Tách bàn', onTap: () async {
              await ctrl.split(table.id);
              Get.snackbar('Tách bàn', 'Đã tách bàn');
            }),
            _ActionButton(icon: Icons.swap_horiz, label: 'Chuyển tầng', onTap: () async {
              final f = await _pickFloor();
              if (f != null) {
                await ctrl.move(table.id, f);
                Get.snackbar('Chuyển tầng', 'Chuyển đến tầng $f');
              }
            }),
            _ActionButton(icon: Icons.flag, label: 'Set trạng thái', onTap: () async {
              final s = await _pickStatus();
              if (s != null) await ctrl.setStatus(table.id, s);
            }),
          ],
        ),
      ),
    );
  }

  Future<int?> _pickFloor() async {
    return await Get.dialog<int>(AlertDialog(
      title: const Text('Chọn tầng'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(title: const Text('Tầng 1'), onTap: () => Get.back(result: 1)),
        ListTile(title: const Text('Tầng 2'), onTap: () => Get.back(result: 2)),
        ListTile(title: const Text('Tầng 3'), onTap: () => Get.back(result: 3)),
      ]),
    ));
  }

  Future<TableStatus?> _pickStatus() async {
    return await Get.dialog<TableStatus>(AlertDialog(
      title: const Text('Chọn trạng thái'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(title: const Text('Bàn trống'), onTap: () => Get.back(result: TableStatus.available)),
        ListTile(title: const Text('Chờ phục vụ'), onTap: () => Get.back(result: TableStatus.waiting)),
        ListTile(title: const Text('Đang phục vụ'), onTap: () => Get.back(result: TableStatus.occupied)),
      ]),
    ));
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 120,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 36),
          const SizedBox(height: 8),
          Text(label),
        ]),
      ),
    );
  }
}

class _SelectTableBottomSheet extends StatelessWidget {
  final String excludeId;
  const _SelectTableBottomSheet({required this.excludeId});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<TableController>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: Obx(() {
        final items = ctrl.tables.where((t) => t.id != excludeId).toList();
        return ListView.separated(
          shrinkWrap: true,
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) {
            final t = items[i];
            return ListTile(
              title: Text(t.tableNumber.toString()),
              subtitle: Text('Tầng ${t.floor} • Ghế ${t.seats}'),
              onTap: () => Get.back(result: t.id),
            );
          },
        );
      }),
    );
  }
}
