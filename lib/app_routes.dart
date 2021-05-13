import 'package:amplify_todo/pages/email_sign_in_page.dart';
import 'package:amplify_todo/pages/home_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/home',
      page: () => HomePage(),
    ),
    GetPage(
      name: '/emaillogin',
      page: () =>
          EmailSignInPage(), //(uncomment here to swith to todo app)TodoList(),
    ),
    // GetPage(
    //   name: '/login',
    //   page: () => LoginPage(),
    // ),
    // GetPage(
    //   name: '/register',
    //   page: () => RegisterPage(),
    // ),
    // GetPage(
    //   name: '/todos',
    //   page: () => TodoList(),
    // ),
    // GetPage(
    //   name: '/todos/:id/edit',
    //   page: () => EditTodo(),
    // ),
    // GetPage(
    //   name: '/add-todo',
    //   page: () => AddTodo(),
    // ),
    // GetPage(
    //   name: "/products/:product_id/view",
    //   page: () => ProductDetailsPage(),
    // )
  ];
}
