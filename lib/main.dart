// import 'package:booking_table/client/controllers/UserController.dart';
// import 'package:booking_table/client/core/theme/app_theme.dart';
// import 'package:booking_table/client/routes/app_routes.dart';
// import 'package:booking_table/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   Get.put(UserController());
//   runApp(const RestaurantApp());
// }
//
// class RestaurantApp extends StatelessWidget {
//   const RestaurantApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Restaurant Manager',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme,
//       // darkTheme: AppTheme.darkTheme,
//       // themeMode: ThemeMode.system,
//
//       initialRoute: AppRoutes.home,
//       getPages: AppRoutes.routes,
//     );
//   }
//   // Widget build(BuildContext context) {
//   //   return MaterialApp(
//   //     title: 'Restaurant Manager',
//   //     theme: AppTheme.lightTheme,
//   //     darkTheme: AppTheme.darkTheme,
//   //     initialRoute: AppRoutes.home,
//   //     routes: AppRoutes.routes,
//   //   );
//   // }
// }
import 'package:booking_table/client/controllers/UserController.dart';
import 'package:booking_table/client/core/theme/app_theme.dart';
import 'package:booking_table/client/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:booking_table/firebase_options.dart';
import 'package:booking_table/client/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(UserController(), permanent: true);
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Restaurant Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}