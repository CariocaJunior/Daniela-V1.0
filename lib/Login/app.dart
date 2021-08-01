import 'package:flutter/material.dart';
import 'package:daniela/Login/routes.dart';

//Vai para as rotas para decidir qual pagina redirecioonar(Login ou a Home)

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Roteamento", onGenerateRoute: routes());
  }
}
