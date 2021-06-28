import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:daniela/main.dart';
import 'package:daniela/Login_senha.dart';
import 'package:daniela/Login/screens/login/homepage.dart' as h;

//Ver se Ainda Precisamos deste Arquivo


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/main':
        return MaterialPageRoute(builder: (_) => MyApp());
      case '/second':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => MyAppLogin(),
          );
        }
        break;
      case '/loginpage':
        //screen = MyApp2();
        return MaterialPageRoute(builder: (_) => h.Homepage());
        break;
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }
//Tratamento de erro de Rota
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
