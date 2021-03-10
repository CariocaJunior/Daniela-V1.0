import 'package:flutter/material.dart';
//Talvez Deletar
class planilhaPrecificacao extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Planilha de precificação"),),
      body: Container(
        padding: new EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("Image/bibiimagem.jpeg"),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.green.withOpacity(1.0), BlendMode.dstATop))),
      ),

    );
  }
}

