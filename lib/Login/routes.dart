import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:daniela/Login/screens/login/homepage.dart';
import 'package:daniela/main.dart';

//Rotas para as paginas(MyApp = Home - Homepage = Login)

const HomepageRoute = "/";
const LoginPage = "/loginpage";
const MenuPage = "/menu";

RouteFactory routes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    Widget screen;
    switch (settings.name) {
      case HomepageRoute:
        User user = (FirebaseAuth.instance.currentUser);
        if (user != null) {
          screen = MyApp();
        } else {
          screen = Homepage();
        }
        break;
      case LoginPage:
        screen = Homepage();
        break;
      default:
        screen = Homepage();
        break;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
