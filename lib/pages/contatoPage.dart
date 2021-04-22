import 'dart:io';
import 'package:daniela/models/contato.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:daniela/contato.dart' as d2;
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ContatoPages extends StatefulWidget {

  final Contato contato;
  var teste = 'teste';

  ContatoPages({this.contato});

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPages> {
  //var controller = new MoneyMaskedTextController();
  final _nomeController = TextEditingController();
  final _HTController = TextEditingController();
  final _LEController = TextEditingController();
  final _VLController = TextEditingController();
  final _ESController = TextEditingController();
  final _TECQTDController = TextEditingController();
  final _TECCUSController = TextEditingController();
  final _ELAQTDController = TextEditingController();
  final _ELACUSController = TextEditingController();
  final _DTController = TextEditingController();
  final _nomeFocus = FocusNode();

  bool editable = true;
  bool editado = false;
  Contato _editaContato;
  d2.Contato _editaContato2;
  @override
  void initState(){
    super.initState();

    if(widget.contato == null){
      _editaContato = Contato(_idRandom(),'','',0,0,0,0,0,0,0, _dataFormat());
    }else{
      _editaContato = Contato.fromMap(widget.contato.toMap());
      _editaContato2 = d2.Contato.fromMap(widget.contato.toMap());
      _nomeController.text = _editaContato.nome;
      _VLController.text = _editaContato.VL.toString();
      _LEController.text = _editaContato.LE.toString();
      _HTController.text = _editaContato.HT;
      _ESController.text = _editaContato.ES.toString();
      _TECQTDController.text = _editaContato.TECQTD.toString();
      _TECCUSController.text = _editaContato.TECCUS.toString();
      _ELAQTDController.text = _editaContato.ELAQTD.toString();
      _ELACUSController.text = _editaContato.ELACUS.toString();
      _DTController.text = _editaContato.DT.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(_editaContato.nome == '' ? "Novo Produto" :
          _editaContato.nome ),
          centerTitle: true,
        ),
          floatingActionButton: FloatingActionButton(
          onPressed: () {
          if(_editaContato.nome != null && _editaContato.nome.isNotEmpty)
          {
          Navigator.pop(context, _editaContato);
          Navigator.pop(context, _editaContato2);
          }else{
          _exibeAviso();
          FocusScope.of(context).requestFocus(_nomeFocus);
          }
          },
            child: Icon(Icons.save),
            backgroundColor: Colors.indigo,
          ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('pedido').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            //children: snapshot.data.docs.map((collection){
            return SingleChildScrollView(
                padding: EdgeInsets.all(10.0),
                child:
                Column(
                  children:
                  <Widget>[
                    Container(
                      width: 70.0, height: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                      ),
                    ),
                    TextField(
                      controller: _nomeController,
                      focusNode: _nomeFocus,
                      decoration: InputDecoration(labelText: "Nome"),
                      onChanged: (text){
                        editado = true;
                        setState(() {
                          _editaContato.nome = text;
                          _editaContato2.nome = text;
                        });
                      },
                    ),
                    TextFormField(// Testando o Update
                      //autofillHints: _testefunc(),
                      initialValue: _testRead(),
                      decoration: InputDecoration(labelText: "Hora Trabalhada (Ex: 00,30)"),
                      //controller: _HTController,
                      onChanged: (text){
                        editado = true;
                        setState(() {
                          //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');

                          _editaContato.HT = text;
                        });
                      },
                    ),
                    TextField(
                      controller: _LEController,
                      decoration: InputDecoration(labelText: "Lucro esperado"),
                      onChanged: (text){
                        editado = true;
                        setState(() {
                          _editaContato.LE = double.parse(text);
                        });
                      },
                    ),

                    TextField(
                      controller: _VLController,
                      decoration: InputDecoration(labelText: "Valor Liquido"),
                      onChanged: (text){
                        editado = true;
                        setState(() {
                          //icone: Icons.monetization_on;
                          _editaContato.VL = double.parse(text);
                        });
                      },
                    ),
                    TextField(
                      controller: _ESController,
                      decoration: InputDecoration(enabled: editable, labelText: "Estoque"),
                      onChanged: (text){
                        editado = true;
                        setState(() {
                          //icone: Icons.monetization_on;
                          _editaContato.ES = int.parse(text);
                          _editaContato2.ES = int.parse(text);
                        });
                      },
                    ),
                    TextField(
                      controller: _TECQTDController,
                      decoration: InputDecoration(labelText: "Tecido quant/custo"),
                      onChanged: (text){
                        editado = true;
                        setState(() {
                          //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');

                          _editaContato.TECQTD = int.parse(text);
                        });
                      },
                    ),
                    TextField(
                      controller: _ELAQTDController,
                      decoration: InputDecoration(labelText: "Elastico quant/custo"),
                      onChanged: (text){
                        editado = true;
                        setState(() {
                          //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');

                          _editaContato.ELAQTD = int.parse(text);
                          //_editaContato.DT = DateTime.now();
                        });
                      },
                    ),
                    // TextField(
                    //   controller: _DTController,
                    //   decoration: InputDecoration(labelText: "Data atual"),
                    //   onChanged: (text){
                    //     editado = true;
                    //     setState(() {
                    //       //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
                    //       _editaContato.DT = DateTime.parse(text);
                    //     });
                    //   },
                    // ),
                    /*Row(children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(hintText: "TextField 1"),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(hintText: "TextField 2"),
                        ),
                      )
                    ]),*/
                  ],
                )
            );
          }
        )
    );
  }

  _documento(indice, dado){
    FirebaseFirestore.instance
        .collection('pedido')
        .where("id", isEqualTo: indice)
        .get().then((value){
          value.docs.forEach((element) {
            return FirebaseFirestore.instance.collection('pedido').doc(element.id).collection(dado);
          });
    });
  }

  _testRead(){ // TESTE DE LEITURA DE DADO
    FirebaseFirestore.instance
        .collection('pedido')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((collection) {
        return (collection['HT']);
      });
    });
  }

  _testefunc(){ // TESTE DE LEITURA DE DADO
    String teste = 'teste';
    return teste;
  }

  _idRandom(){ // ID RANDÔMICO
    var uuid = Uuid();
    return uuid.v4();
  }

  _dataFormat(){ // DATA ATUAL
    var dtAtual = new DateTime.now().toUtc();
    var dtFormat = new DateFormat('dd/MM/yyyy - kk:mm:ss');
    String dataFormatada = dtFormat.format(dtAtual.toLocal().toUtc());
    var formatado = dtAtual.toLocal().toString();

    return dataFormatada;
  }

  void _exibeAviso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Nome"),
          content: new Text("Informe o nome do contato"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}