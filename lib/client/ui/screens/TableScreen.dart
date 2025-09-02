import 'package:booking_table/client/controllers/TableController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_table/client/routes/app_routes.dart';
import 'package:booking_table/client/data/models/TableStatus.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(TableController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                  ),
                  const Text(
                    "Bàn",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Floor selector
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (i) {
                final floor = i + 1;
                final selected = ctrl.currentFloor.value == floor;
                return GestureDetector(
                  onTap: () => ctrl.setFloor(floor),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: selected ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Tầng $floor",
                      style: TextStyle(
                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }),
            )),
            const SizedBox(height: 12),

            // Table grid
            Expanded(
              child: Obx(() {
                final list = ctrl.filteredTables;
                if (list.isEmpty) {
                  return const Center(child: Text("Không có bàn"));
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: list.map((table) {
                      Color borderColor;
                      Color bgColor;

                      switch (table.status) {
                        case TableStatus.available:
                          borderColor = Colors.green;
                          bgColor = Colors.green.shade100;
                          break;
                        case TableStatus.waiting:
                          borderColor = Colors.orange;
                          bgColor = Colors.orange.shade100;
                          break;
                        case TableStatus.occupied:
                          borderColor = Colors.red;
                          bgColor = Colors.red.shade100;
                          break;
                        default:
                          borderColor = Colors.grey;
                          bgColor = Colors.grey.shade200;
                      }

                      return GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.tableDetail, arguments: table),
                        child: Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            color: bgColor,
                            border: Border.all(color: borderColor, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Bàn ${table.tableNumber}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
            ),

            // Status legend bottom (filter)
            Obx(() {
              final selected = ctrl.filterStatus.value;
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _legendFilter(
                      label: "All",
                      color: Colors.black,
                      isSelected: selected == null,
                      onTap: () => ctrl.setFilter(null),
                    ),
                    _legendFilter(
                      label: "Bàn trống",
                      color: Colors.green,
                      isSelected: selected == TableStatus.available,
                      onTap: () => ctrl.setFilter(
                        selected == TableStatus.available ? null : TableStatus.available,
                      ),
                    ),
                    _legendFilter(
                      label: "Chờ phục vụ",
                      color: Colors.orange,
                      isSelected: selected == TableStatus.waiting,
                      onTap: () => ctrl.setFilter(
                        selected == TableStatus.waiting ? null : TableStatus.waiting,
                      ),
                    ),
                    _legendFilter(
                      label: "Đang phục vụ",
                      color: Colors.red,
                      isSelected: selected == TableStatus.occupied,
                      onTap: () => ctrl.setFilter(
                        selected == TableStatus.occupied ? null : TableStatus.occupied,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _legendFilter({
    required String label,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
