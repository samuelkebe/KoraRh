import 'package:flutter/material.dart';
import 'package:kora_rh/composants/card_conge.dart';
import 'package:kora_rh/views/home_view.dart';


import '../views/acceuil_view.dart';
import 'app_route_name.dart';

class GeneratorRoute {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRouteName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );



      case AppRouteName.acceuil:
        return MaterialPageRoute(
          builder: (context) => const AcceuilView(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
