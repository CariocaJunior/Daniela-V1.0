import 'dart:io';
import 'package:daniela/HelpMe/database_helper.dart';
import 'package:daniela/models/contato.dart';
import 'package:daniela/pages/contatoPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=> _HomePageState();
}
class _HomePageState extends State<HomePage>{
  DateTime data = DateTime.now();
  DatabaseHelper db = DatabaseHelper();
  List<Contato> contatos = List<Contato>();

  @override
  void initState() {
    super.initState();

    //Contato c = Contato(null,"Maria",2,2,2,2,0);
    // Contato c1 = Contato(2,"Pedro","pedro@uol.com.br",null);
    //db.insertContato(c);
    // db.insertContato(c1);
    _exibeTodosContatos();
  }

  void _exibeTodosContatos(){ // FUNÇÃO SEM UTILIDADE
    // db.getContatos().then( (lista) {
    //
    //   print(lista);
    //   setState(() {
    //     contatos = lista;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('pedido').snapshots(), // INSTANCIA A COLEÇÃO 'PEDIDO'
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          return Stack(
              overflow: Overflow.visible,
              children: <Widget>[
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
                Padding( //BOTÃO DE RETORNO - SETA
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Positioned(
                    left: 5,
                    top: 5,
                    child: FloatingActionButton(
                      elevation: 0.0,
                      onPressed: () { Navigator.pop(context);
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        child:
                        Image(
                          image: AssetImage('Image/Left_Arrow.png',),
                          width: 50,
                          fit: BoxFit.scaleDown,
                          color: Colors.brown,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, // circular shape
                            color: Color.fromARGB(255,255,246,161),
                            boxShadow: [
                              BoxShadow(
                                //color: Colors.yellow[16774817].withOpacity(0.0),
                                color: Color.fromARGB(255,255,246,161).withOpacity(1.0),
                                spreadRadius: 10.0,
                                blurRadius: 0,
                                offset: Offset(0,0),
                              )
                            ]
                        ),
                      ),
                    ),
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
                        )
                    ),
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
                                image: AssetImage('Image/Produto.png',),
                                width: 45,
                                fit: BoxFit.cover,
                                color: Colors.brown,
                              ),
                              Padding(padding:  EdgeInsets.fromLTRB(0, 40, 7, 20)),//AJUSTA O ESPAÇAMENTO ENTRE A IMAGEM E O TEXTO
                              Text('Tabela de produto',
                                  //textAlign: TextAlign.end,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 140, 10, 80),
                  child: ListView(
                    scrollDirection: Axis.vertical,// EXIBE ITENS ADCIONADOS NO BOTÃO
                    children:
                    snapshot.data.docs.map((collection){ // PRINTA NA TELA OS DADOS DO BANCO, MAPEANDO A COLEÇÃO
                      return  Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          //borderRadius: BorderRadius.circular(20.0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )
                        ),
                        child: ListTile(
                          title: Row( // TITULO (NOME DO DOCUMENTO DO FIREBASE)
                            children: <Widget>[
                              Expanded(
                                  child: Text(collection['nome'].toUpperCase(), // PRINTA NA TELA O NOME DO PRODUTO EM MAIUSCULO
                                    textAlign: TextAlign.left,
                                    style: // ESTILOS DO TEXTO
                                    TextStyle(color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),)
                              ),
                            ],
                          ),
                          subtitle: // SUBTITULO (OS CAMPOS DO FIREBASE)
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column( // LISTA NA TELA OS CAMPOS DO FIREBASE
                                children: [
                                  Text('Horas Trab : ' + collection['HT'],
                                    style: TextStyle(color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),),
                                  Text('Lucro Estm : ${collection['LE']}',
                                    style: TextStyle(color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),),
                                  Text('Valor Liqu : ${collection['ELAQTD']}',
                                    style: TextStyle(color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),),
                                  Text('Tecido Cus : ${collection['TECCUS']}',
                                    style: TextStyle(color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),),
                                  Text('Valor Liqu : ${collection['VL']}',
                                    style: TextStyle(color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),),
                                  Text('Data Produ :' + collection['DT'],
                                    style: TextStyle(color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),),
                                ],
                              ),
                            ),
                          ),
                          trailing:
                          Column(
                            children: <Widget>[
                              Container(
                                child: IconButton(
                                  icon: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                                    child: Icon(Icons.keyboard_arrow_up),
                                  ),
                                  color: Colors.brown,
                                  iconSize: 40,
                                  onPressed: () {
                                    //_deletar(collection['id']);
                                    //_atualizar(collection['id']);
                                    _exibeContatoPage();
                                  },
                                ),
                              ),
                              // Container(
                              //   child: IconButton(
                              //     icon: Padding(
                              //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              //       child: Icon(Icons.system_update_tv_sharp),
                              //     ),
                              //     color: Colors.brown,
                              //     iconSize: 30,
                              //     onPressed: () {
                              //       _atualizar(collection['id']);
                              //       //_exibeContatoPage();
                              //       },
                              //   ),
                              // ),
                              // Expanded(
                              //   child: Padding(
                              //     padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              //     child: Container(
                              //       child: IconButton(
                              //         icon: Icon(Icons.system_update_alt_sharp),
                              //         color: Colors.brown,
                              //         iconSize: 30,
                              //         onPressed: () {_atualizar(collection['id']);},
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ]
          );
        }
      ),
      floatingActionButton: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 325.0),
            child: FloatingActionButton(
              heroTag: null,
              //heroTag: 'unq2',
              onPressed: () {
                _exibeContatoPage();
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
                      Color.fromARGB(255,230,119,53), Color.fromARGB(255,161,88,52)
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

  void _deletar(indice) {
    FirebaseFirestore.instance
        .collection("pedido")
        .where("id", isEqualTo : indice)
        .get().then((value){
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("pedido").doc(element.id).delete().then((value){
          //ESCREVER UMA MENSAGEM
        });
      });
    });
  }

  void _atualizar(indice){
    FirebaseFirestore.instance
        .collection('pedido')
        .where("id", isEqualTo : indice)
        .get().then((value){
      value.docs.forEach((element){
        FirebaseFirestore.instance.collection("pedido").doc(indice).update({
          'ELACUS': 5,
          'ELAQTD': 100,
          'ES': 3,
          'HT': '10',
          'LE': 670,
          'TECCUS': 10,
          'TECQTD': 5,
          'VL': 100,
          'id': '001',
          'nome': 'vaso grande'
           });
      });
    });
  }

  // _listaContatos(BuildContext context, int index) {
  //   return GestureDetector(
  //
  //     child: Card(
  //         child: Padding(padding: EdgeInsets.all(10.0),
  //             child:Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 Container(
  //                   width: 70.0, height: 70.0,
  //                   decoration: BoxDecoration(
  //                     shape: BoxShape.circle,
  //                   ),
  //                 ),
  //                 Padding(
  //                     padding: EdgeInsets.only(left: 10.0),
  //
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Text(contatos[index].nome ?? "",
  //                             style: TextStyle(fontSize: 20)
  //                         ),
  //                         Text("Horas/Minutos Trabalhadas(os):  " + contatos[index].HT ?? "",
  //                             style: TextStyle(fontSize: 15)
  //                         ),
  //                         Text("Lucro Esperado: R\$ " + contatos[index].LE.toStringAsFixed(2) ?? "",
  //                             style: TextStyle(fontSize: 15)
  //                         ),
  //                         Text("Valor Liquido: R\$ " + contatos[index].VL.toStringAsFixed(2) ?? "",
  //                             style: TextStyle(fontSize: 15)
  //                         ),
  //                         Text("Estoque: " + contatos[index].ES.toString() ?? "",
  //                             style: TextStyle(fontSize: 15)
  //                         ),
  //                         Text("Tecido quant/custo: " + contatos[index].TECQTD.toStringAsFixed(2) ?? "",
  //                             style: TextStyle(fontSize: 15)
  //                         ),
  //                         Text("Elastico quant/custo: " + contatos[index].ELAQTD.toStringAsFixed(2) ?? "",
  //                             style: TextStyle(fontSize: 15)
  //                         ),
  //                         Text("Data: ${(new DateFormat.yMMMd().format(new DateTime.now()))}",
  //                         ),
  //                       ],
  //                     )
  //                 ),
  //                 Flexible(
  //                   child: IconButton(
  //                     icon: Icon(Icons.delete),
  //                     onPressed: (){
  //                       _confirmaExclusao(context, contatos[index].id, index);
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             )
  //         )
  //     ),
  //     onTap: () {
  //       _exibeContatoPage(contato: contatos[index]);
  //     },
  //   );
  // }

  void _exibeContatoPage({Contato contato}) async {
    final contatoRecebido =  await Navigator.push(context,
      MaterialPageRoute(
          builder: (
              context)=> ContatoPages(contato: contato)
      ),
    );

    if(contatoRecebido != null){
      if(contato != null )
      {
        await db.updateContato(contatoRecebido);
      }else{
        await db.insertContato(contatoRecebido);
      }
      _exibeTodosContatos();
    }
  }

  // ATUALIZAR NO FIREBASE
  CollectionReference users = FirebaseFirestore.instance.collection('pedido');
  Future<void> updateDoc() {
  return users
      .doc('pedido')
      .update({'alguem feio': 'docUm'})
      .then((value) => print("Update realizado com êxito!!!"))
      .catchError((error) => print("Falha ao atualizar os dados: $error"));
  }

  void _confirmaExclusao(BuildContext context, int contatoid, index) {
      showDialog(
          context: context,
        builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Excluir Contato"),
              content: Text("Confirma a exclusão do Contato"),
              actions: <Widget>[
                FlatButton(onPressed: () {Navigator.of(context).pop();}
                , child: Text('Cancelar')),
                FlatButton(onPressed: () {
                  setState(() {
                    contatos.removeAt(index);
                    db.deleteContato(contatoid);
                  });
                  Navigator.of(context).pop();
                }
                , child: Text('Excluir'))
              ],
            );
        }
      );
  }
}