// import 'package:flutter/material.dart';
//
// class TablesScreen extends StatelessWidget {
//   const TablesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Quản lý bàn")),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // 2 bàn trên 1 hàng
//           childAspectRatio: 1.2,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//         ),
//         itemCount: 6, // ví dụ có 6 bàn
//         itemBuilder: (context, index) {
//           return Card(
//             color: Colors.green[100],
//             child: Center(
//               child: Text("Bàn ${index + 1}",
//                   style: const TextStyle(fontSize: 20)),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
