import 'package:flutter/material.dart';
import 'package:daniela/Login/routes.dart';

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return MaterialPageRoute(builder: (context) => Menu());
    return MaterialApp(title: "Roteamento", onGenerateRoute: routes());
  }
}
