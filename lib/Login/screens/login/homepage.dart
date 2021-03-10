import 'package:flutter/material.dart';
import 'package:daniela/Login/screens/login/ui/login_page.dart';

//Redirecionar para o Login

void main() => runApp(new LoginPage());

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TheGorgeousLogin',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(),
    );
  }
}
