import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:daniela/Login/screens/another_page.dart';
import 'package:daniela/Login/screens/login/homepage.dart';
import 'package:daniela/Login/screens/show_my_text.dart';
//import 'package:daniela/Login/screens/login/homepage.dart';
import 'package:daniela/Login/screens/menu.dart';
import 'package:daniela/main.dart';
//import 'package:daniela/Login/screens/login/homepage.dart';
//import 'package:daniela/Login/app.dart';

const HomepageRoute = "/";
const AnotherPageRoute = "/anotherPage";
const ShowMyTextRoute = "/showMyText";
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
      case AnotherPageRoute:
        screen = AnotherPage();
        break;
      case LoginPage:
        //screen = MyApp2();
        screen = Homepage();
        break;
      case MenuPage:
        screen = Menu();
        break;
      case ShowMyTextRoute:
        screen = ShowMyText(arguments['text']);
        break;
      default:
        screen = Homepage();
        //screen = Menu();
        break;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
