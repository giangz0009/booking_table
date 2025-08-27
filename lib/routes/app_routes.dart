import 'package:booking_table/ui/screens/home_main_screen.dart';
import 'package:booking_table/ui/screens/login_screen.dart';
import 'package:booking_table/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';
  static const homeMain = '/home';
  static const login = '/login';
  static const orders = '/orders';
  static const payments = '/payments';
  static const statistics = '/statistics';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const SplashScreen(),
    homeMain: (context) => const HomeMainScreen(),
    login: (context) => const LoginScreen(),
    orders: (context) => const Placeholder(),   // Tạm thời
    payments: (context) => const Placeholder(),
    statistics: (context) => const Placeholder(),
  };
}
