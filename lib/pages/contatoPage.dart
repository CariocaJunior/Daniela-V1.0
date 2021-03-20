import 'dart:io';
import 'package:daniela/models/contato.dart';
import 'package:flutter/material.dart';
import 'package:daniela/contato.dart' as d2;
import 'package:flutter_masked_text/flutter_masked_text.dart';
class ContatoPages extends StatefulWidget {

  final Contato contato;
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
  final _nomeFocus = FocusNode();

  bool editado= false;
  Contato _editaContato;
  d2.Contato _editaContato2;
  @override
  void initState(){
    super.initState();

    if(widget.contato == null){
      _editaContato = Contato(null,'','',0,0,0,0,0,0,0);
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
        body: SingleChildScrollView(

            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: 70.0, height: 70.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                    ),
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
                TextField(
                  controller: _HTController,
                  decoration: InputDecoration(labelText: "Hora Trabalhada (Ex: 00,30)"),
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
                  decoration: InputDecoration(labelText: "Estoque"),
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
                    });
                  },
                ),
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
        )
    );
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