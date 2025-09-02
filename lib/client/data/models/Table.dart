

import 'package:booking_table/client/data/models/TableStatus.dart';

class RestaurantTable {
  final String id;
  final int tableNumber;   // Bàn 1, Bàn 2...
  final int floor;     // Tầng
  final TableStatus status;
  final List<String> mergedWith; // id các bàn đã ghép chung (nếu có)
  final int seats;

  RestaurantTable({
    required this.id,
    required this.tableNumber,
    required this.floor,
    required this.status,
    required this.seats,
    this.mergedWith = const [],
  });

  factory RestaurantTable.fromMap(Map<String, dynamic> map, String id) {
    return RestaurantTable(
      id: id,
      tableNumber: (map['tableNumber'] ?? 1) as int,
      floor: (map['floor'] ?? 1) as int,
      status: statusFromString(map['status'] ?? 'available'),
      seats: (map['seats'] ?? 4) as int,
      mergedWith: List<String>.from(map['mergedWith'] ?? const []),
    );
  }

  Map<String, dynamic> toMap() => {
    'name': tableNumber,
    'floor': floor,
    'status': statusToString(status),
    'seats': seats,
    'mergedWith': mergedWith,
  };

  RestaurantTable copyWith({
    int? tableNumber,
    int? floor,
    TableStatus? status,
    int? seats,
    List<String>? mergedWith,
  }) {
    return RestaurantTable(
      id: id,
      tableNumber: tableNumber ?? this.tableNumber,
      floor: floor ?? this.floor,
      status: status ?? this.status,
      seats: seats ?? this.seats,
      mergedWith: mergedWith ?? this.mergedWith,
    );
  }
}
