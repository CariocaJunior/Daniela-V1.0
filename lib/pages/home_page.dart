import 'dart:io';
import 'package:daniela/HelpMe/database_helper.dart';
import 'package:daniela/models/contato.dart';
import 'package:daniela/pages/contatoPage.dart';
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
      appBar: AppBar(
        title: Text("Produtos"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibeContatoPage();
        },
        child: Icon(Icons.add),
      ),

      // LISTA DADOS DO CLOUD FIRESTORE (FIREBASE)
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('pedido').snapshots(), // INSTANCIA A COLEÇÃO 'PEDIDO'
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // CRIAR UMA FUNÇÃO PARA RETORNAR A LISTA
          // CRIAR UMA FUNÇÃO PARA REALIZAR UPDATE DE ITENS LISTA
          // CRIAR UMA FUNÇÃO PARA REALIZAR DELETE DE ITENS DA LISTA
          // CRIAR UM FILTRO
          return // RETORNA A LISTA DO CLOUD FIRESTORE
            ListView(
            children:
            snapshot.data.docs.map((collection){ // PRINTA NA TELA OS DADOS DO BANCO, MAPEANDO A COLEÇÃO
              return  new ListTile( // LISTA OS DOCUMENTOS COMO TÍTULO E OS CAMPOS COMO SUBTÍTULO
                title: Text('Nome: ' + collection['nome']),
                subtitle: Text('Horas Trabalhadas: ' + collection['HT']),
              );
            }).toList(),
          );
        },
      ),
      // TESTE: LISTAR DADOS DO FIREBASE
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance.collection('pedido').snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     return ListView(
      //       children:
      //       snapshot.data.docs.map((collection){
      //         return Container(
      //           child: Center(child:
      //             Text(collection['nome'])),
      //         );
      //       }).toList(),
      //     );
      //   },
      // ),
    );
  }

  _listaContatos(BuildContext context, int index) {
    return GestureDetector(

      child: Card(
          child: Padding(padding: EdgeInsets.all(10.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 70.0, height: 70.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10.0),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(contatos[index].nome ?? "",
                              style: TextStyle(fontSize: 20)
                          ),
                          Text("Horas/Minutos Trabalhadas(os):  " + contatos[index].HT ?? "",
                              style: TextStyle(fontSize: 15)
                          ),
                          Text("Lucro Esperado: R\$ " + contatos[index].LE.toStringAsFixed(2) ?? "",
                              style: TextStyle(fontSize: 15)
                          ),
                          Text("Valor Liquido: R\$ " + contatos[index].VL.toStringAsFixed(2) ?? "",
                              style: TextStyle(fontSize: 15)
                          ),
                          Text("Estoque: " + contatos[index].ES.toString() ?? "",
                              style: TextStyle(fontSize: 15)
                          ),
                          Text("Tecido quant/custo: " + contatos[index].TECQTD.toStringAsFixed(2) ?? "",
                              style: TextStyle(fontSize: 15)
                          ),
                          Text("Elastico quant/custo: " + contatos[index].ELAQTD.toStringAsFixed(2) ?? "",
                              style: TextStyle(fontSize: 15)
                          ),
                          Text("Data: ${(new DateFormat.yMMMd().format(new DateTime.now()))}",
                          ),
                        ],
                      )
                  ),
              Flexible(
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      _confirmaExclusao(context, contatos[index].id, index);
                    },
                    ),
                  ),
                ],
              )
          )
      ),
      onTap: () {
        _exibeContatoPage(contato: contatos[index]);
      },
    );
  }

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
  
  // Future<void> _updateData(Map data) async{
  //   final pedido = await Firebase
  // }

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