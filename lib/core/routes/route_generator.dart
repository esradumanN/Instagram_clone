import 'package:flutter/material.dart';

import '../../pages/main/view/main_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (BuildContext context) => const MainPage(),
        );

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MainPage());
    }
  }
}
