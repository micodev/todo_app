import 'package:get/get_navigation/src/routes/get_route.dart';

import '../view/pages/home_page.dart';

class AppRouter {
  static String homeRoute = '/';

  static var routes = [
    GetPage(name: homeRoute, page: () => HomePage()),
  ];
}
