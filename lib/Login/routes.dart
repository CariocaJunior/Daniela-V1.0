import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:daniela/Login/screens/login/homepage.dart';
//import 'package:daniela/Login/screens/login/homepage.dart';
import 'package:daniela/Login/screens/menu.dart';
import 'package:daniela/main.dart';
//import 'package:daniela/Login/screens/login/homepage.dart';
//import 'package:daniela/Login/app.dart';

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
          //screen = Homepage();
        } else {
          screen = Homepage();
        }
        break;
      case LoginPage:
        //screen = MyApp2();
        screen = Homepage();
        break;
        /* Bem provavel que ira ser deletado (Deletar no Menu.dart tambem)
      case MenuPage:
        screen = Menu();
        break;*/
      default:
        screen = Homepage();
        //screen = Menu();
        break;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
