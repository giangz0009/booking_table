import 'package:booking_table/client/data/models/Table.dart';
import 'package:booking_table/client/data/models/TableStatus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableRepository {
  final _col = FirebaseFirestore.instance.collection('tables');

  Stream<List<RestaurantTable>> streamByFloor(int floor) {
    return _col.where('floor', isEqualTo: floor).snapshots().map(
          (snap) => snap.docs.map((d) => RestaurantTable.fromMap(d.data(), d.id)).toList(),
    );
  }

  Future<void> updateStatus(String id, TableStatus status) {
    return _col.doc(id).update({'status': statusToString(status)});
  }

  /// Ghép 2 bàn (logic tối giản: set mergedWith cho cả 2, status chuyển sang waiting)
  Future<void> mergeTables(String idA, String idB) async {
    final aRef = _col.doc(idA);
    final bRef = _col.doc(idB);
    await FirebaseFirestore.instance.runTransaction((trx) async {
      final a = await trx.get(aRef);
      final b = await trx.get(bRef);
      if (!a.exists || !b.exists) throw Exception('Bàn không tồn tại');

      final mergedA = Set<String>.from((a['mergedWith'] ?? [])).union({idB}).toList();
      final mergedB = Set<String>.from((b['mergedWith'] ?? [])).union({idA}).toList();

      trx.update(aRef, {'mergedWith': mergedA, 'status': 'waiting'});
      trx.update(bRef, {'mergedWith': mergedB, 'status': 'waiting'});
    });
  }

  /// Tách bàn: xoá quan hệ mergedWith của tất cả liên quan
  Future<void> splitTable(String id) async {
    final ref = _col.doc(id);
    await FirebaseFirestore.instance.runTransaction((trx) async {
      final doc = await trx.get(ref);
      if (!doc.exists) return;
      final merged = List<String>.from(doc['mergedWith'] ?? []);
      for (final otherId in merged) {
        final otherRef = _col.doc(otherId);
        final other = await trx.get(otherRef);
        if (!other.exists) continue;
        final list = List<String>.from(other['mergedWith'] ?? []);
        list.remove(id);
        trx.update(otherRef, {'mergedWith': list});
      }
      trx.update(ref, {'mergedWith': [], 'status': 'free'});
    });
  }

  Future<void> moveFloor(String id, int newFloor) {
    return _col.doc(id).update({'floor': newFloor});
  }
}
