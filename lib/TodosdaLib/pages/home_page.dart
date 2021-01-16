import 'dart:io';
import 'package:daniela/TodosdaLib/helpers/database_helper.dart';
import 'package:daniela/TodosdaLib/models/contato.dart';
import 'package:daniela/TodosdaLib/pages/contato_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DatabaseHelper db = DatabaseHelper();
  List<Contato> contatos = List<Contato>();

  @override
  void initState() {
    super.initState();

     //Contato c = Contato(null,"Maria",2,2,2,4);
     //db.insertContato(c);
    _exibeTodosContatos();
    //print(Contato(null,"Maria",2,2,2,4));
  }

  void _exibeTodosContatos(){
    db.getContatos().then( (lista) {
      setState(() {
        contatos = lista;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tabela de Distribuição"),
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
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contatos.length ,
        itemBuilder: (context, index) {
          return _listaContatos(context,index);
        },
      ),
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
                          Text(contatos[index].mes ?? "",
                              style: TextStyle(fontSize: 20)
                          ),
                          Text("Vendas: R\$ " + contatos[index].TotVendas.toStringAsFixed(2) ?? "",
                              style: TextStyle(fontSize: 15)
                          ),
                          Text("Lucro Esperado: R\$ " + contatos[index].markup.toStringAsFixed(2) ?? "",
                              style: TextStyle(fontSize: 15)
                          ),
                          Text("Caixa: R\$ " + contatos[index].caixa.toStringAsFixed(2) ?? "",
                              style: TextStyle(fontSize: 15)
                          ),
                          Text("Produção: R\$ " + contatos[index].Producao.toStringAsFixed(2) ?? "",
                              style: TextStyle(fontSize: 15)
                          )
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
              context)=> ContatoPage(contato: contato)
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