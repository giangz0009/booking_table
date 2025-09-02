import 'package:booking_table/client/data/models/Table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late final RestaurantTable table;

  final _currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0);
  // RxMap để dễ observe. Khi thay đổi, Obx sẽ rebuild phần quan trọng.
  final RxMap<String, int> selectedItems = <String, int>{}.obs;

  @override
  void initState() {
    super.initState();
    table = Get.arguments as RestaurantTable;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _foodsStream() {
    return FirebaseFirestore.instance.collection("menu").snapshots();
  }

  void _toggleItem(String id) {
    // thêm món mới với qty = 1, hoặc nếu đã tồn tại thì remove
    if (selectedItems.containsKey(id)) {
      selectedItems.remove(id);
    } else {
      selectedItems[id] = 1;
    }
  }

  void _changeQty(String id, int delta) {
    final current = selectedItems[id] ?? 0;
    final next = current + delta;
    if (next <= 0) {
      selectedItems.remove(id);
    } else {
      selectedItems[id] = next;
    }
  }

  double _calcTotalPrice(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    double total = 0;
    selectedItems.forEach((id, qty) {
      final doc = docs.firstWhereOrNull((d) => d.id == id);
      if (doc != null) {
        final price = (doc.data()['price'] ?? 0).toDouble();
        total += price * qty;
      }
    });
    return total;
  }

  void _submitOrder(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) async {
    if (selectedItems.isEmpty) {
      Get.snackbar("Thông báo", "Vui lòng chọn ít nhất 1 món");
      return;
    }

    // Ví dụ lưu order đơn giản vào Firestore (collection "orders")
    final orderData = {
      'tableId': table.id,
      'tableNumber': table.tableNumber,
      'items': selectedItems.entries
          .map((e) => {
        'foodId': e.key,
        'qty': e.value,
        // lấy giá tên tạm nếu muốn:
        'price': (docs.firstWhere((d) => d.id == e.key).data()['price'] ?? 0)
      })
          .toList(),
      'total': _calcTotalPrice(docs),
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'pending',
    };

    await FirebaseFirestore.instance.collection('orders').add(orderData);
    Get.snackbar("Thành công", "Đã tạo order cho bàn ${table.tableNumber}");
    selectedItems.clear();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order • Bàn ${table.tableNumber}")),
      body: Column(
        children: [
          // danh sách món (lắng nghe stream từ Firebase)
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _foodsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("Chưa có món ăn nào"));
                }

                final foods = snapshot.data!.docs;

                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: foods.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final doc = foods[index];
                    final id = doc.id;
                    final data = doc.data();
                    final name = data["name"] ?? "Không tên";
                    final price = (data["price"] ?? 0).toDouble();
                    final image = data["image"] ?? "https://via.placeholder.com/100";

                    // Chỉ phần trailing cần rebuild khi selectedItems thay đổi -> dùng Obx
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(image, width: 56, height: 56, fit: BoxFit.cover),
                      ),
                      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(_currencyFormatter.format(price)),
                      trailing: Obx(() {
                        final qty = selectedItems[id] ?? 0;
                        final selected = qty > 0;

                        if (selected) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => _changeQty(id, -1),
                              ),
                              Text(qty.toString(), style: const TextStyle(fontSize: 16)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () => _changeQty(id, 1),
                              ),
                            ],
                          );
                        } else {
                          return IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => _toggleItem(id),
                          );
                        }
                      }),
                    );
                  },
                );
              },
            ),
          ),

          // bottom bar: tổng & nút xác nhận (cần dữ liệu foods để tính tổng -> dùng StreamBuilder kết hợp)
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _foodsStream(),
            builder: (context, snapshot) {
              final foods = snapshot.data?.docs ?? <QueryDocumentSnapshot<Map<String, dynamic>>>[];
              return Obx(() {
                final totalItems = selectedItems.values.fold<int>(0, (a, b) => a + b);
                final totalPrice = _calcTotalPrice(foods);
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Text("Đã chọn: $totalItems món — ${_currencyFormatter.format(totalPrice)}")),
                      Column(
                        children: [
                          // Nút Reset
                          ElevatedButton.icon(
                            onPressed: selectedItems.isEmpty ? null : () {
                              setState(() {
                                selectedItems.clear(); // xóa hết số lượng món đã add
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(160, 30),
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            icon: const Icon(Icons.lock_reset),
                            label: const Text("Reset"),
                          ),
                          const SizedBox(height: 8),

                          // Nút Xác nhận
                          ElevatedButton.icon(
                            onPressed: selectedItems.isEmpty ? null : () => _submitOrder(foods),
                            icon: const Icon(Icons.check),
                            label: const Text("Xác nhận",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              iconColor: Colors.white,
                              backgroundColor: Colors.green,
                              minimumSize: Size(160, 30),
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              });
            },
          )
        ],
      ),
    );
  }
}
