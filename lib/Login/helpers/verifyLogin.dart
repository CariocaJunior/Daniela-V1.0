import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:daniela/Login/screens/menu.dart';

class VerifyLogin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  verify() async {
    try {
      User user = await FirebaseAuth.instance.currentUser;

      return user;

      /*if (user != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Menu()));
      }*/
    } catch (e) {}
/*if(user!= null) {
    Navigator.pushNamedAndRemoveUntil(context,            rotaParaUsuarioLogado, (Route<dynamic> route) => false);
  }else{
   Navigator.pushNamedAndRemoveUntil(context, rotaParaUsuarioNaoLogado, (Route<dynamic> route) => false);
}
});*/
  }
}
