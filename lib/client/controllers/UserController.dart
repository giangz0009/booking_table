// import 'package:booking_table/client/data/models/AppUser.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class UserController extends GetxController {
//   static UserController get to => Get.find();
//
//   var user = Rxn<AppUser>();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> loadUser() async {
//     User? firebaseUser = _auth.currentUser;
//     if (firebaseUser != null) {
//       DocumentSnapshot doc =
//       await _firestore.collection("employees").doc(firebaseUser.uid).get();
//       if (doc.exists) {
//         final data = doc.data() as Map<String, dynamic>;
//         data["email"] = firebaseUser.email; // thêm email từ FirebaseAuth
//         user.value = AppUser.fromMap(data, doc.id);
//       }
//     }
//   }
//
//   void clearUser() {
//     user.value = null;
//   }
// }

import 'package:booking_table/client/data/models/AppUser.dart';
import 'package:booking_table/client/data/repositories/UserResponsitory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _repo = UserRepository();

  final Rxn<AppUser> user = Rxn<AppUser>();

  bool get isLoggedIn => user.value != null;
  String? get role => user.value?.role;

  @override
  void onInit() {
    super.onInit();
    _bindAuthChanges();
  }

  void _bindAuthChanges() {
    _auth.authStateChanges().listen((acc) async {
      if (acc == null) {
        user.value = null;
      } else {
        final profile = await _repo.getById(acc.uid);
        user.value = profile?.copyWith() ??
            AppUser(id: acc.uid, name: acc.email ?? 'User', role: 'staff', email: acc.email);
      }
    });
  }

  Future<void> loadUser() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot doc =
      await _firestore.collection("employees").doc(firebaseUser.uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        data["email"] = firebaseUser.email; // thêm email từ FirebaseAuth
        user.value = AppUser.fromMap(data, doc.id);
      }
    }
  }

  void clearUser() {
    user.value = null;
  }

  Future<void> updateProfile({required String name}) async {
    final u = _auth.currentUser;
    if (u == null) return;
    await _repo.updateProfile(u.uid, name: name);
    final profile = await _repo.getById(u.uid);
    if (profile != null) user.value = profile;
  }

  Future<void> changePassword(String newPassword) async {
    final u = _auth.currentUser;
    if (u == null) throw Exception('Chưa đăng nhập');
    await u.updatePassword(newPassword);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    user.value = null;
  }
}
