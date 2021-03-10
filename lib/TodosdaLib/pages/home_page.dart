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

        /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            _exibeContatoPage();
          },
          child: Icon(Icons.add),
        ),*/



      body: Stack(
          overflow: Overflow.visible,
        children: <Widget>[
          Container(
            //this is the problem
            //padding: new EdgeInsets.all(105.0),
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("Image/tela2.png"),
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(
                      Colors.green.withOpacity(1.0), BlendMode.dstATop)),
            ),
          ),
          Positioned(
            //left: 5,
            //top: 5,
            child: FloatingActionButton(
              elevation: 0.0,
              onPressed: () {
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, // circular shape
                    color: Color.fromARGB(255,255,246,161),
                    image: DecorationImage(
                        image: AssetImage("Image/Left_Arrow.png"),
                        scale: 1.9
                    ),
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
                    /*Icon(Icons.history, size: 60.0, color: Colors.brown),
                  Text("Histórico de Venda",
                    style: new TextStyle(
                      fontSize: 30.0,
                      color: Colors.brown,
                    ),),*/
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(Icons.history, size: 43.0, color: Colors.brown),
                        Padding(padding:  EdgeInsets.fromLTRB(0, 40, 0, 20)),
                        Text('Tabela de distribuição',
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
      /*body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contatos.length ,
        itemBuilder: (context, index) {
          return _listaContatos(context,index);
        },
      ),*/
    ]
    ),
      floatingActionButton: FloatingActionButton(
        //heroTag: null,
        heroTag: 'unq2',
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