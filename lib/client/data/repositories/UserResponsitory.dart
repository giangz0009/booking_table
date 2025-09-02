import 'package:booking_table/client/data/models/AppUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final _col = FirebaseFirestore.instance.collection('employees');

  Future<AppUser?> getById(String uid) async {
    final doc = await _col.doc(uid).get();
    if (!doc.exists) return null;
    return AppUser.fromMap(doc.data()!, doc.id);
  }

  Future<void> updateProfile(String uid, {required String name, String? avatarUrl}) {
    return _col.doc(uid).set({
      'name': name,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
    }, SetOptions(merge: true));
  }
}
