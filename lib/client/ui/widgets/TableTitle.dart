import 'package:booking_table/client/data/models/Table.dart';
import 'package:booking_table/client/data/models/TableStatus.dart';
import 'package:flutter/material.dart';

class TableTile extends StatelessWidget {
  final RestaurantTable table;
  final VoidCallback? onTap;

  const TableTile({super.key, required this.table, this.onTap});

  Color _statusColor(TableStatus s) {
    switch (s) {
      case TableStatus.available: return Colors.green.shade300;
      case TableStatus.waiting: return Colors.orange.shade300;
      case TableStatus.occupied: return Colors.red.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _statusColor(table.status),
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bàn sô: ${table.tableNumber.toString()}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Spacer(),
            if (table.mergedWith.isNotEmpty)
              const Text('Bàn ghép', style: TextStyle(fontSize: 12)),
            Text('Số ghế: ${table.seats}', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
