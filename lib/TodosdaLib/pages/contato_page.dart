import 'dart:io';
import 'package:daniela/TodosdaLib/models/contato.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:daniela/contato.dart' as d2;
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'dart:math';
import 'biblioteca.dart' as Biblioteca;


class ContatoPages extends StatefulWidget {

  final Contato contato;
  ContatoPages({this.contato});

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPages> {
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  final _mesController = TextEditingController();
  final _nomeFocus = FocusNode();

  final _controleNome = new TextEditingController(text: nomeReturn().toString());
  final _controleValor = new TextEditingController(text: valorReturn());
  final _controleMes = new MaskedTextController(mask: '00/00/0000', text: mesReturn());


  var teste = Biblioteca.nomeLibrary;

  bool editado = false;
  Contato _editaContato;
  d2.Contato _editaContato2;

  var mesLocal = Biblioteca.mesLibrary;
  var valorLocal = Biblioteca.valorLibrary;
  var nomeLocal = Biblioteca.nomeLibrary;

  @override
  void initState(){
    super.initState();
    funcValor();
    nomeReturn();
    mesReturn();
    valorReturn();
    //_atualizar(Biblioteca.idLibrary);

    if(widget.contato == null){
      _editaContato = Contato(null,'','',0);
    }else{
      _editaContato = Contato.fromMap(widget.contato.toMap());
      _editaContato2 = d2.Contato.fromMap(widget.contato.toMap());
      _nomeController.text = _editaContato.nome;
      _valorController.text = _editaContato.valor.toString();
      _mesController.text = _editaContato.mes.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      body:
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection('venda').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
                overflow: Overflow.visible,
                children: <Widget>[

                  Expanded(
                    child: Container( //BACKGROUND
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("Image/tela2.png"),
                          //alignment: Alignment.center,
                          fit: BoxFit.fill,
                          //colorFilter: new ColorFilter.mode(
                          //    Colors.green.withOpacity(1.0), BlendMode.dstATop)
                        ),
                      ),
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
                              // image: DecorationImage(
                              //     image: AssetImage("Image/Left_Arrow.png"),
                              //     scale: 1.9
                              // ),
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
                    child: Card( //CARD COM INPUTS
                      elevation: 3.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder( //AJUSTA O ARREDONDAMENTO DO CARD
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
                                Image(
                                  image: AssetImage('Image/Venda.png',),
                                  width: 45,
                                  fit: BoxFit.cover,
                                  color: Colors.brown,
                                ),
                                //Icon(Icons.point_of_sale_sharp, size: 37.0, color: Colors.brown),
                                Padding(padding:  EdgeInsets.fromLTRB(0, 40, 7, 20)), //AJUSTA O ESPAÇAMENTO ENTRE A IMAGEM E O TEXTO
                                Text(Biblioteca.conditionalName(Biblioteca.varLibrary),
                                    //textAlign: TextAlign.end,
                                    style: new TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.brown,
                                    )
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10.0, left: 10.0, right: 10.0),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 330,
                                  height: 50,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    //initialValue: VarEstrangeira.nomeLibrary.toString(),
                                    autofocus: true,
                                    cursorColor: Colors.brown,
                                    style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                    textAlign: TextAlign.left,
                                    controller: _controleNome,
                                    //focusNode: _nomeFocus,
                                    decoration: InputDecoration(
                                      labelText: 'Nome ou Descrição',
                                      labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0, fontWeight: FontWeight.w700),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2.0),
                                    ),
                                    //validator: ,
                                    onChanged: (text) {
                                      if(Biblioteca.varLibrary == false){
                                        if(text.isEmpty || text == null){
                                          setState(() {
                                            _editaContato.nome = Biblioteca.nomeLibrary;
                                            _editaContato2.nome = Biblioteca.nomeLibrary;
                                          });
                                        }
                                        else{
                                          setState(() {
                                            Biblioteca.nomeLibrary = text;
                                            _editaContato.nome = text;
                                            _editaContato2.nome = text;
                                          });
                                        }
                                      }
                                      else{
                                        setState(() {
                                          Biblioteca.nomeLibrary = text;
                                          _editaContato.nome = text;
                                          _editaContato2.nome = text;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Container( //CONTAINER PARA VALOR LÍQUIDO
                                  width: 330,
                                  height: 50,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    //initialValue: VarEstrangeira.valorLiqLibrary.toString(),
                                    //initialValue: valorLiqReturn().toStringAsFixed(2).toString(),
                                    autofocus: true,
                                    cursorColor: Colors.brown,
                                    style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown,),
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    controller: _controleValor,
                                    //controller: ValorLController,
                                    decoration: InputDecoration(
                                      //filled: true,
                                      prefix: Text('R\$ '),
                                      labelText: "Valor",
                                      labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0, fontWeight: FontWeight.w700),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2.0),
                                      //alignLabelWithHint: true,
                                    ),
                                    onChanged: (text){
                                      if(Biblioteca.varLibrary == false){
                                        if(text.isEmpty || text == null){
                                          setState(() {
                                            _editaContato.valor = Biblioteca.valorLibrary;
                                          });
                                        }
                                        else{
                                          setState(() {
                                            _editaContato.valor = double.parse(text) as double;
                                            Biblioteca.valorLibrary = double.parse(text) as double;
                                          });
                                        }
                                      }
                                      else{
                                        editado = true;
                                        setState(() {
                                          //icone: Icons.monetization_on;
                                          _editaContato.valor = double.parse(text) as double;
                                          Biblioteca.valorLibrary = double.parse(text) as double;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Container( //CONTAINER PARA VALOR LÍQUIDO
                                  width: 330,
                                  height: 50,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    //initialValue: VarEstrangeira.valorLiqLibrary.toString(),
                                    //initialValue: valorLiqReturn().toStringAsFixed(2).toString(),
                                    autofocus: true,
                                    cursorColor: Colors.brown,
                                    style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown,),
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    controller: _controleMes,
                                    //controller: ValorLController,
                                    decoration: InputDecoration(
                                      //filled: true,
                                      prefix: Text(''),
                                      labelText: "Data",
                                      labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0, fontWeight: FontWeight.w700),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2.0),
                                      //alignLabelWithHint: true,
                                    ),
                                    onChanged: (text){
                                      if(Biblioteca.varLibrary == false){
                                        if(text.isEmpty || text == null){
                                          setState(() {
                                            _editaContato.mes = Biblioteca.mesLibrary;
                                          });
                                        }
                                        else{
                                          setState(() {
                                            _editaContato.mes = text;
                                            Biblioteca.mesLibrary = text;
                                          });
                                        }
                                      }
                                      else{
                                        editado = true;
                                        setState(() {
                                          //icone: Icons.monetization_on;
                                          _editaContato.mes = text;
                                          Biblioteca.mesLibrary = text;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
            );
          }
      ),
      floatingActionButton: //BOTÃO SALVAR
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding( //AJUSTA O POSICIONAMENTO DO BOTÃO
            padding: const EdgeInsets.only(left: 325.0),
            child: FloatingActionButton(
              //heroTag: null,
              heroTag: 'unq2',
              onPressed: () async{
                if(Biblioteca.varLibrary == false) {
                  if(_editaContato.nome != null && _editaContato.nome.isNotEmpty)
                  {
                    Biblioteca.deletar(Biblioteca.idLibrary);
                    Future.delayed(const Duration(milliseconds: 400), () {
                      setState(() {

                        Navigator.pop(context);
                      });
                    });
                    _exibeAvisoEditar();
                  }
                  if(_editaContato.nome.isEmpty || _editaContato.nome == null)
                  {
                    Future.delayed(const Duration(milliseconds: 400), () {
                      setState(() {
                        Biblioteca.criar(Biblioteca.idLibrary);
                        Navigator.pop(context);
                      });
                    });
                    _exibeAvisoEditar();
                  }
                }
                else{
                  if(_editaContato.nome.isNotEmpty && _editaContato.nome != null && Biblioteca.varLibrary == true) {
                    Biblioteca.criar(Biblioteca.idLibrary);
                    Navigator.pop(context, _editaContato);
                    Navigator.pop(context, _editaContato2);
                  }
                  else
                  { // ADIÇÃO DE PRODUTO SE O NOME NÃO FOR DIGITADO
                    _exibeAviso();
                    FocusScope.of(context).requestFocus(_nomeFocus);
                  }
                }
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
                child: Icon(Icons.save, size: 40.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _exibeAviso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Nome"),
          content: new Text("Informe o nome do produto"),
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

  void _exibeAvisoEditar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: new Text("Edição"),
          content: new Text("Editado com sucesso!!", style: TextStyle(color: Colors.brown, fontSize: 20),),
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

  Future<void> funcValor() async{
    if(Biblioteca.varLibrary == false){
      setState(() {
        _editaContato.nome = Biblioteca.nomeLibrary;
        _editaContato.valor = Biblioteca.valorLibrary;
        _editaContato.mes = Biblioteca.mesLibrary;
      });
    }
  }

  static nomeReturn (){
    if(Biblioteca.varLibrary == false){
      //_editaContato.nome = Biblioteca.nomeLibrary;
      return Biblioteca.nomeLibrary.toString();
    }
    else{
      return '';
    }
  }
  static mesReturn (){
    if(Biblioteca.varLibrary == false){
      //_editaContato.HT = Biblioteca.horaTrabLibrary;
      return Biblioteca.mesLibrary.toString();
    }
    else{
      return '';
    }
  }
  static valorReturn (){
    if(Biblioteca.varLibrary == false){
      //_editaContato.VL = Biblioteca.valorLiqLibrary;
      return Biblioteca.valorLibrary.toStringAsFixed(2);
    }
    else{
      return '';
    }
  }
// Future<String> _testRead() async{// TESTE DE LEITURA DE DADO
//   await
//   FirebaseFirestore.instance
//       .collection('pedido')
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((collection) {
//       var teste = collection['HT'];
//       //return teste;
//       setState(() {
//         testeInput = teste;
//       });
//     });
//   });
// }

}

// Future _atualizar(indice) async{
//   await
//   FirebaseFirestore.instance
//       .collection('pedido')
//       .where("id", isEqualTo : indice)
//       .get().then((value){
//     value.docs.forEach((element){
//       FirebaseFirestore.instance.collection("pedido").doc(indice).update({
//         'ELACUS': 8.98,
//         'ELAQTD': 7.58,
//         'ELAQTD': 8.9,
//         'ES': 8,
//         'HT': '51:22:69',
//         'LE': 10.8,
//         'TECCUS': 10.7,
//         'TECQTD': 10.7,
//         'VL': 10.7,
//         'id': Biblioteca.idLibrary ,
//         'nome': Biblioteca.nomeLibrary
//       });
//     });
//   });
//   //return _exibeContatoPage();
// }
