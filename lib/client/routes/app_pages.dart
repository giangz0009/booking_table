import 'package:booking_table/client/middlewares/role_middleware.dart';
import 'package:booking_table/client/ui/screens/ChangePasswordScreen.dart';
import 'package:booking_table/client/ui/screens/HomeScreen.dart';
import 'package:booking_table/client/ui/screens/OrderScreen.dart';
import 'package:booking_table/client/ui/screens/SettingsScreen.dart';
import 'package:booking_table/client/ui/screens/TableDetaliScreen.dart';
import 'package:booking_table/client/ui/screens/TableScreen.dart';
import 'package:booking_table/client/ui/screens/UpdateInfoScreen.dart';
import 'package:booking_table/client/ui/screens/login_screen.dart';
import 'package:booking_table/client/ui/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:booking_table/client/routes/app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.tables, page: () => const TablesScreen()),
    GetPage(name: AppRoutes.tableDetail, page: () => const TableDetailScreen()),
    GetPage(name: AppRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: AppRoutes.updateInfo, page: () => const UpdateInfoScreen()),
    GetPage(name: AppRoutes.changePassword, page: () => const ChangePasswordScreen()),
    GetPage(name: AppRoutes.order, page: () => const OrderScreen()),
    GetPage(
        name: AppRoutes.thongKe,
        page: () => const ChangePasswordScreen(),
        middlewares: [RoleMiddleware("admin")], // Chỉ admin mới vào được page này
    ),
  ];
}
