import 'package:daniela/TodosdaLib/helpers/database_helper.dart';
import 'package:daniela/TodosdaLib/models/contato.dart';
import 'package:daniela/TodosdaLib/pages/contato_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Venda_biblioteca.dart' as Biblioteca;
import 'dart:math';
import 'package:expand_widget/expand_widget.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime data = DateTime.now();
  DatabaseHelper db = DatabaseHelper();
  List<Contato> contatos = List<Contato>();

  bool testVar = Biblioteca.varLibrary;
  bool option =
      true; // CONTROLA A TELA DE EDIÇÃO/CRIAÇÃO DO PRODUTO (TRUE-> EDITAR | FALSE-> ADICIOANAR)

  @override
  void initState() {
    super.initState();
    _editarCampos;

  }

  String mesLocal;
  double valorLocal;
  String nomeLocal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(overflow: Overflow.visible, children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("Image/tela2.png"),
                fit: BoxFit.fill,
                colorFilter: new ColorFilter.mode(
                    Colors.green.withOpacity(1.0), BlendMode.dstATop)),
          ),
        ),
        Padding(
          //BOTÃO DE RETORNO - SETA
          padding: const EdgeInsets.only(top: 15.0),
          child: Stack(
              children: <Widget>[
            Positioned(
              left: 5,
              top: 5,
              child: FloatingActionButton(
                elevation: 0.0,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  child: Image(
                    image: AssetImage(
                      'Image/Left_Arrow.png',
                    ),
                    width: 50,
                    fit: BoxFit.scaleDown,
                    color: Colors.brown,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, // circular shape
                      color: Color.fromARGB(255, 255, 246, 161),
                      boxShadow: [
                        BoxShadow(
                          //color: Colors.yellow[16774817].withOpacity(0.0),
                          color:
                              Color.fromARGB(255, 255, 246, 161).withOpacity(1.0),
                          spreadRadius: 10.0,
                          blurRadius: 0,
                          offset: Offset(0, 0),
                        )
                      ]),
                ),
              ),
            ),
            ]
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 80, 10, 0),
          child: Card(
            elevation: 3.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                //borderRadius: BorderRadius.circular(20.0),
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
            child: Container(
              width: 750.0,
              height: 750.0,
              child: Column(
                children: <Widget>[
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      //Icon(Icons.history, size: 43.0, color: Colors.brown),
                      Image(
                        image: AssetImage(
                          'Image/Venda.png',
                        ),
                        width: 45,
                        fit: BoxFit.cover,
                        color: Colors.brown,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 40, 7, 20)),
                      //AJUSTA O ESPAÇAMENTO ENTRE A IMAGEM E O TEXTO
                      Text('Tabela de Vendas',
                          style: new TextStyle(
                            fontSize: 30.0,
                            color: Colors.brown,
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10.0, left: 10.0, right: 10.0),
                  ),
                  Container(
                    width: 1.0,
                    height: 1.0,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('venda')
                .snapshots(), // INSTANCIA A COLEÇÃO 'PEDIDO'
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 140, 10, 80),
                child: ListView(
                  children: snapshot.data.docs.map((collection) {
                    // PRINTA NA TELA OS DADOS DO BANCO, MAPEANDO A COLEÇÃO
                    return Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              collection['nome'].toUpperCase(),
                              // PRINTA NA TELA O NOME DO PRODUTO EM MAIUSCULO
                              style: // ESTILOS DO TEXTO
                                  TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                            ),
                          ],
                        ),
                        subtitle: // SUBTITULO (OS CAMPOS DO FIREBASE)
                            ExpandChild(
                          arrowPadding: EdgeInsets.fromLTRB(0, 0, 210, 0),
                          arrowColor: Colors.brown,
                          arrowSize: 20,
                          expandArrowStyle: ExpandArrowStyle.icon,
                          icon: Icons.arrow_drop_down,
                          child: Container(
                            child: Column(
                              // LISTA NA TELA OS CAMPOS DO FIREBASE
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Valor: R\$ ' +
                                      collection['valor'].toStringAsFixed(2),
                                  style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  'Data: ' + collection['mes'],
                                  style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: PopupMenuButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(9, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.cancel,
                                        size: 20,
                                        color: Colors.brown,
                                      ),
                                      Text(" Cancelar",
                                          style: TextStyle(
                                              color: Colors.brown,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(9, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.brown,
                                      ),
                                      Text(" Editar",
                                          style: TextStyle(
                                              color: Colors.brown,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(9, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete_rounded,
                                        size: 20,
                                        color: Colors.brown,
                                      ),
                                      Text(" Deletar",
                                          style: TextStyle(
                                              color: Colors.brown,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            onCanceled: () {
                              print("ERROR!!!");
                            },
                            onSelected: (value) {
                              if (value == 1) {
                                //cancelar
                              }
                              if (value == 2) {
                                _editarCampos(collection['id']);
                                Biblioteca.varLibrary =
                                    false; // VARIÁVEL DE CONTROLE EDIÇÃO E ADIÇÃO DE PRODUTO
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  setState(() {
                                    _exibeContatoPage(); // Here you can write your code for open new view
                                  });
                                });
                              }
                              if (value == 3) {
                                Biblioteca.Vendadeletar(collection['id']);
                                _deleteExito();
                              } else {
                                print('ERROR!!!');
                              }
                            },
                            icon: Icon(
                              Icons.more_vert,
                              size: 30,
                              color: Colors.brown,
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
      ]),
      floatingActionButton: Row(
        // BOTÃO ADD NOVO PRODUTO
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 325.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                _exibeContatoPage();
                Biblioteca.varLibrary =
                    true; // VARIÁVEL PARA CONTROLE DE EDIÇÃO E ADIÇÃO DE PRODUTO
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // circular shape
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.centerLeft,
                    stops: [0.3, 1.0],
                    colors: [
                      Color.fromARGB(255, 230, 119, 53),
                      Color.fromARGB(255, 161, 88, 52)
                    ],
                  ),
                ),
                child: Icon(Icons.add, size: 50.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _editarCampos(indice) async {
    // VARIÁVEL DA BIBLIOTECA RECEBE OS DADOS DO FIREBASE DAS RESPECTIVAS VARIÁVEIS LOCAIS
    await FirebaseFirestore.instance
        .collection('venda')
        .where("id", isEqualTo: indice)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((collection) {
        var editdt = collection['mes'];
        var editvl = collection['valor'];
        var editnome = collection['nome'];
        var editid = collection['id'];
        setState(() {
          Biblioteca.mesLibrary = editdt;
          Biblioteca.valorLibrary = editvl;
          Biblioteca.nomeLibrary = editnome;
          Biblioteca.idLibrary = editid;
        });
      });
    });
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void _deleteExito() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Deletado com êxito!!!"),
          );
        });
  }

  void _exibeContatoPage({Contato contato}) async {
    final contatoRecebido = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContatoPages(contato: contato)),
    );
    if (contatoRecebido != null) {
      if (contato != null) {
        await db.updateContato(contatoRecebido);
      } else {
        await db.insertContato(contatoRecebido);
      }
    }
  }
}
