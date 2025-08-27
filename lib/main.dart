import 'package:booking_table/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.system,

      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Restaurant Manager',
  //     theme: AppTheme.lightTheme,
  //     darkTheme: AppTheme.darkTheme,
  //     initialRoute: AppRoutes.home,
  //     routes: AppRoutes.routes,
  //   );
  // }
}
