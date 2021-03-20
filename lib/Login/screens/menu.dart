import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
/* Bem provavel que ira ser deletado (Deletar no routes.dart tambem)
class Menu extends StatelessWidget {
  int _counter = 0;

  /*DatabaseHelper db = DatabaseHelper();

  List<Produto> contatos = List<Produto>();*/
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Menu'), centerTitle: true),
      ),
      //appBar: AppBar(title: Text('Menu'), centerTitle: true),
      debugShowCheckedModeBanner: false,
      /*body: SingleChildScrollView(
        child: Container(
          padding: new EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("Image/bibiimagem.jpeg"),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.green.withOpacity(1.0), BlendMode.dstATop))),
          child: Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new SizedBox(
                    width: 360.0,
                    height: 100.0,
                    // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: RaisedButton(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text("Historico de Vendas"),
                      color: Colors.deepPurple,
                      onPressed: () => Navigator.of(context)
                          .pushNamed('/second', arguments: ''), // ação ,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new SizedBox(
                    width: 360.0,
                    height: 100.0,
                    child: RaisedButton(
                      child: new Text("Produtos"),
                      color: Colors.yellow,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/produto', arguments: '');
                      },
                    ),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new SizedBox(
                    width: 360.0,
                    height: 100.0,
                    child: RaisedButton(
                      child: new Text("Lucros"),
                      color: Colors.blue,
                      onPressed: () {},
                    ),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new SizedBox(
                    width: 360.0,
                    height: 100.0,
                    child: RaisedButton(
                        child: new Text("Tabela de Distribuição"),
                        color: Colors.green,
                        onPressed: () {
                          /*Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Tabela_De_Distribuicao()));*/
                        }),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new SizedBox(
                        width: 360,
                        height: 100,
                        child: RaisedButton(
                            child: Text("Planilha Precificação"),
                            color: Colors.orange,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/precificacao', arguments: '');
                            }))),
                /* Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new SizedBox(
                    width: 360.0,
                    height: 100.0,
                    child: RaisedButton(
                      child: new Text("Botão Precificação "),
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Precificacao()));
                      },
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),*/
    );
  }
}
*/