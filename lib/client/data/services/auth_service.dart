import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final bool success;
  final String? message;
  final User? data;

  AuthResult({required this.success, this.message, this.data});
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Đăng nhập
  Future<AuthResult> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return AuthResult(success: true, data: result.user);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = "Không tìm thấy tài khoản với email này.";
          break;
        case 'wrong-password':
          message = "Tài khoản hoặc mật khẩu không đúng.";
          break;
        case 'invalid-email':
          message = "Email không hợp lệ.";
          break;
        case 'user-disabled':
          message = "Tài khoản đã bị vô hiệu hóa.";
          break;
        default:
          message = "Đăng nhập thất bại. Vui lòng thử lại.";
      }
      return AuthResult(success: false, message: message);
    } catch (e) {
      return AuthResult(success: false, message: "Lỗi không xác định: $e");
    }
  }

  // Lấy role từ Firestore
  Future<String> getUserRole(String uid) async {
    DocumentSnapshot doc = await _firestore.collection("employees").doc(uid).get();
    return doc['role'] ?? 'user';
  }
}
