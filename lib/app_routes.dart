import 'package:amplify_todo/pages/email_sign_in_page.dart';
import 'package:amplify_todo/pages/home_page.dart';
import 'package:amplify_todo/pages/landing_page.dart';
import 'package:amplify_todo/pages/sign_in_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/home',
      page: () => HomePage(),
    ),
    GetPage(
      name: '/emaillogin',
      page: () => EmailSignInPage(),
    ),
    GetPage(
      name: '/',
      page: () => LandingPage(),
    ),
    GetPage(
      name: '/signin',
      page: () => SignInPage(),
    ),
  ];
}
