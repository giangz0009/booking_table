//
// import 'package:booking_table/client/middlewares/role_middleware.dart';
// import 'package:booking_table/client/ui/screens/home_admin_screen.dart';
// import 'package:booking_table/client/ui/screens/login_screen.dart';
// import 'package:booking_table/client/ui/screens/splash_screen.dart';
// import 'package:get/get.dart';
//
// // class AppRoutes {
// //   static const home = '/';
// //   static const homeMain = '/home';
// //   static const login = '/login';
// //   static const orders = '/orders';
// //   static const payments = '/payments';
// //   static const statistics = '/statistics';
// //
// //   static Map<String, WidgetBuilder> routes = {
// //     home: (context) => const SplashScreen(),
// //     homeMain: (context) => const HomeScreen(),
// //     login: (context) => const LoginScreen(),
// //     orders: (context) => const Placeholder(),   // Tạm thời
// //     payments: (context) => const Placeholder(),
// //     statistics: (context) => const Placeholder(),
// //   };
// // }
//
// class AppRoutes {
//   static const home = '/';
//   static const homeMain = '/home';
//   static const login = '/login';
//   static const thongKe = '/thong-ke';
//
//   static final routes = [
//     GetPage(
//       name: home,
//       page: () => const SplashScreen(),
//     ),
//     GetPage(
//       name: homeMain,
//       page: () => const HomeScreen(),
//     ),
//     GetPage(
//       name: login,
//       page: () => const LoginScreen(),
//     ),
//     GetPage(
//       name: thongKe,
//       page: () => const HomeScreen(),
//       middlewares: [
//         RoleMiddleware(allowedRoles: ['admin']),
//       ],
//     ),
//   ];
// }

class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
  static const tables = '/tables';
  static const tableDetail = '/table-detail';
  static const settings = '/settings';
  static const updateInfo = '/update-info';
  static const changePassword = '/change-password';
  static const thongKe = '/thong-ke';
}

