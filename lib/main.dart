import 'package:daniela/screens/TabelaDeDistribuicao.dart';
import 'package:flutter/material.dart';
import 'package:daniela/HelpMe/database_helper.dart';
import 'package:daniela/models/contato.dart';
import 'package:daniela/pages/home_page.dart' as prodhome;
import 'package:daniela/historicoDeVenda.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Login/app.dart';
import 'package:daniela/Login/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Inicializa o Firebase no Aplicativo e dps Redireciona para a parte de Login
  await Firebase.initializeApp();
  runApp(MyApp2());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHome());
  }
}

class MyHome extends StatelessWidget {
  int _counter = 0;

  DatabaseHelper db = DatabaseHelper();
  List<Contato> contatos = List<Contato>();

  @override
  Widget build(BuildContext context) {
    //Função para dar opções quando o botão voltar do celular for pressionado
    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Tem Certeza?'),
          content: new Text('Quer Sair do aplicativo?'),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("Não"),
            ),
            SizedBox(height: 16),
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("Sim"),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      // Chama a Função Para o botão voltar do celular
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
                //Imagem de Fundo da Tela Principal
                decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("Image/bibiimagem.jpg"),
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(
                      Colors.green.withOpacity(1.0), BlendMode.dstATop)),
            )),
            //Gradiente Na parte debaixo da Tela Principal
            Container(
              height: 810.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 255, 252, 227).withOpacity(0.0),
                        Color.fromARGB(255, 255, 252, 227),
                      ],
                      stops: [
                        0.85,
                        1.0
                      ])),
            ),
            //Coluna para Colocar os Botões
            Column(
              children: [
                //Configurações e Posicionamento dos Botões Produto e Histórico
                Center(
                  child: new Column(
                    children: <Widget>[
                      Center(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new SizedBox(
                          child: Row(
                            children: <Widget>[
                              //Botão Histórico
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      18, 230, 12, 12),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 240.0,
                                        height: 140.0,
                                        child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.grey)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18),
                                              child: Column(
                                                // Replace with a Row for horizontal icon + text
                                                children: <Widget>[
                                                  Icon(Icons.history,
                                                      size: 70.0,
                                                      color: Colors.lightGreen),
                                                  Text(
                                                    "Histórico",
                                                    style: new TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            color: Colors.white,
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Historico_De_Venda()));
                                            } // ação ,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //Botão Produto
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12, 230, 18, 12),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 240.0,
                                        height: 140.0,
                                        //Image/bibiimagem.jpeg
                                        child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.grey)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 13),
                                              child: Column(
                                                // Replace with a Row for horizontal icon + text
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Image.asset(
                                                        'Image/Produto.png'),
                                                    iconSize: 60,
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  prodhome
                                                                      .HomePage()));
                                                    },
                                                  ),
                                                  Text(
                                                    "Produto",
                                                    style: new TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black54,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            textColor: Colors.black,
                                            color: Colors.white,
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          prodhome.HomePage()));
                                            } // ação ,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Configurações e Posicionamento do Botão Vendas
                Center(
                  child: new Column(
                    children: <Widget>[
                      Center(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new SizedBox(
                          child: Row(
                            children: <Widget>[
                              //Botão Vendas
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(100, 0, 12, 60),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 170.0,
                                        height: 140.0,
                                        child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.grey)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18),
                                              child: Column(
                                                // Replace with a Row for horizontal icon + text
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Image.asset(
                                                        'Image/Venda.png'),
                                                    iconSize: 65,
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Tabela_De_Distribuicao()));
                                                    },
                                                  ),
                                                  Text(
                                                    "Vendas",
                                                    style: new TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            color: Colors.white,
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Tabela_De_Distribuicao()));
                                            } // ação ,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
