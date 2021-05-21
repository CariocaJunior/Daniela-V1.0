import 'dart:io';
import 'package:daniela/models/contato.dart';
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
import 'biblioteca.dart' as Biblioteca;


class ContatoPages extends StatefulWidget {

  final Contato contato;
  ContatoPages({this.contato});

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPages> {
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

  TextEditingController _controleNome = new TextEditingController(text: nomeReturn().toString());
  var teste = Biblioteca.nomeLibrary;

  var ValorLController = new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  var LucroEQTDController = new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  var ElaCUSController = new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  var ElaQTDController = new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  var TecCUSController = new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  var TecQTDController = new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  var DatController = new MaskedTextController(mask: '00/00/0000');
  var HoraController = new MaskedTextController(mask: '00:00:00');

  bool editado = false;
  Contato _editaContato;
  d2.Contato _editaContato2;

  var DTLocal = Biblioteca.dataLibrary;
  var ELACUSLocal = Biblioteca.elastCustLibrary;
  var ELAQTDLocal = Biblioteca.elastQTDLibrary;
  var ESLocal = Biblioteca.estLibrary;
  var HTLocal = Biblioteca.horaTrabLibrary;
  var LELocal = Biblioteca.lucroEstLibrary;
  var TECCUSLocal = Biblioteca.tecCustLibrary;
  var TECQTDLocal = Biblioteca.tecQTDLibrary;
  var VLLocal = Biblioteca.valorLiqLibrary;
  var nomeLocal = Biblioteca.nomeLibrary;

  @override
  void initState(){
    super.initState();
    //funcValor();
    nomeReturn();
    horaTrabReturn();
    lucroEstReturn();
    valorLiqReturn();
    estoqueReturn();
    tecidoCusReturn();
    tecidoQTDReturn();
    elastCusReturn();
    elastQTDReturn();

    if(widget.contato == null){
      _editaContato = Contato(Biblioteca.idRandom(),'','',0,0,0,0,0,0,0, Biblioteca.dataFormat());
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
      resizeToAvoidBottomPadding: false,

      body:
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection('pedido').snapshots(),
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
                                    image: AssetImage('Image/Produto.png',),
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
                                        //initialValue: nomeReturn(),
                                        autofocus: true,
                                        cursorColor: Colors.brown,
                                        style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                        textAlign: TextAlign.left,
                                        controller: _controleNome,
                                        //controller: TextEditingController()..text = 'Teste',
                                        //controller: _nomeController,
                                        //focusNode: _nomeFocus,
                                        decoration: InputDecoration(
                                          labelText: 'Nome',
                                          labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0, fontWeight: FontWeight.w700),
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(2.0),
                                        ),
                                        //validator: ,
                                        onChanged: (text) {
                                          editado = true;
                                          setState(() {
                                            _editaContato.nome = text;
                                            _editaContato2.nome = text;
                                          });
                                        }
                                        //   if(text.isEmpty || text == null){
                                        //     setState(() {
                                        //       text = Biblioteca.nomeLibrary;
                                        //       _editaContato.nome = 'ABC';
                                        //       _editaContato2.nome = 'ABC';
                                        //     });
                                        //   }else{
                                        //     setState(() {
                                        //       _editaContato.nome = text;
                                        //       _editaContato2.nome = text;
                                        //     });
                                        //   }
                                        // },
                                        //onChanged: (text) => setState(() => _editaContato.nome = nomeReturn()),
                                        // onSaved: (value){
                                        //   _editaContato.nome = nomeReturn();
                                        //   _editaContato2.nome = nomeReturn();
                                        // },
                                        // validator: (String value){
                                        //   if(value.isEmpty) {
                                        //     return '';
                                        //   }
                                        //   return null;
                                        // },
                                    ),
                                  ),
                                Container( //CONTAINER HORA TRABALHADA
                                  width: 330,
                                  height: 50,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    initialValue: horaTrabReturn().toString(),
                                    autofocus: true,
                                    cursorColor: Colors.brown,
                                    style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    //controller: HoraController,
                                    decoration: InputDecoration(
                                      labelText: "Hora Trabalhada",
                                      labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0, fontWeight: FontWeight.w700),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2.0),
                                      //alignLabelWithHint: true,
                                    ),
                                    onChanged: (text){
                                      editado = true;
                                      setState(() {
                                        //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
                                        _editaContato.HT = text;
                                      });
                                    },
                                  ),
                                ),
                                Container( //CONTAINER INPUT LUCRO
                                  width: 330,
                                  height: 50,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    //initialValue: VarEstrangeira.lucroEstLibrary.toString(),
                                    initialValue: lucroEstReturn().toString(),
                                    autofocus: true,
                                    cursorColor: Colors.brown,
                                    style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    //controller: _LEController,
                                    //controller: LucroEQTDController,
                                    decoration: InputDecoration(
                                      prefix: Text('R\$ '), //PREFIXO PARA DIGITAÇÃO
                                      labelText: "Lucro Esperado",
                                      labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0, fontWeight: FontWeight.w700),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2.0),
                                      //contentPadding: EdgeInsets.only(left: 0, bottom: 15, top: 2.0), alignLabelWithHint: true,
                                    ),
                                    onChanged: (text){
                                      editado = true;
                                      setState(() {
                                        _editaContato.LE = double.parse(text) as double;
                                      });
                                    },
                                  ),
                                ),
                                Container( //CONTAINER PARA VALOR LÍQUIDO
                                  width: 330,
                                  height: 50,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    //initialValue: VarEstrangeira.valorLiqLibrary.toString(),
                                    initialValue: valorLiqReturn().toString(),
                                    autofocus: true,
                                    cursorColor: Colors.brown,
                                    style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown,),
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    //controller: _VLController,
                                    //controller: ValorLController,
                                    decoration: InputDecoration(
                                      //filled: true,
                                      prefix: Text('R\$ '),
                                      labelText: "Valor Líquido",
                                      labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0, fontWeight: FontWeight.w700),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2.0),
                                      //alignLabelWithHint: true,
                                    ),
                                    onChanged: (text){
                                      editado = true;
                                      setState(() {
                                        //icone: Icons.monetization_on;
                                        _editaContato.VL = double.parse(text) as double;
                                      });
                                    },
                                  ),
                                ),
                                Container( //CONTAINER ESTOQUE
                                  width: 330,
                                  height: 50,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    //initialValue: VarEstrangeira.estLibrary.toString(),
                                    initialValue: estoqueReturn().toString(),
                                    autofocus: true,
                                    cursorColor: Colors.brown,
                                    style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    //controller: _ESController,
                                    decoration: InputDecoration(
                                      labelText: "Estoque",
                                      labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0, fontWeight: FontWeight.w700),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2.0),
                                      //alignLabelWithHint: true,
                                    ),
                                    onChanged: (text){
                                      editado = true;
                                      setState(() {
                                        //icone: Icons.monetization_on;
                                        _editaContato.ES = int.parse(text);
                                        _editaContato2.ES = int.parse(text);
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0), // ESPAÇAMENTO PARA ALINHAR
                                  child: Row(
                                    children: [
                                      Text('Tecido:  ', style: TextStyle(color: Colors.brown, fontSize: 20.0, fontWeight: FontWeight.w700),),
                                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),),
                                      Container( // TECIDO/QUANT CUSTO
                                        width: 115,
                                        height: 50,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          initialValue: tecidoCusReturn().toString(),
                                          autofocus: true,
                                          cursorColor: Colors.brown,
                                          style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                          textAlign: TextAlign.left,
                                          keyboardType: TextInputType.number,
                                          //controller: _TECCUSController,
                                          //controller: TecCUSController,
                                          decoration: InputDecoration(
                                            prefix: Text('R\$ '),
                                            labelText: "Custo",
                                            labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0, fontWeight: FontWeight.w700),
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(2.0),
                                            //alignLabelWithHint: true,
                                          ),
                                          onChanged: (text){
                                            editado = true;
                                            setState(() {
                                              //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
                                              _editaContato.TECCUS = double.parse(text) as double;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),),
                                      Container( // TECIDO/QUANT CUSTO
                                        width: 115,
                                        height: 50,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          //initialValue: VarEstrangeira.tecQTDLibrary.toString(),
                                          initialValue: tecidoQTDReturn().toString(),
                                          autofocus: true,
                                          cursorColor: Colors.brown,
                                          style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                          textAlign: TextAlign.left,
                                          keyboardType: TextInputType.number,
                                          //controller: _TECQTDController,
                                          //controller: TecQTDController,
                                          decoration: InputDecoration(
                                            prefix: Text('cm '),
                                            labelText: "Comprimento",
                                            labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0, fontWeight: FontWeight.w700),
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(2.0),
                                            //alignLabelWithHint: true,
                                          ),
                                          onChanged: (text){
                                            editado = true;
                                            setState(() {
                                              //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
                                              _editaContato.TECQTD = double.parse(text) as double;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding( // ELÁSTICO
                                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0), // ESPAÇAMENTO PARA ALINHAR
                                  child: Row(
                                    children: [
                                      Text('Elástico:', style: TextStyle(color: Colors.brown, fontSize: 20.0, fontWeight: FontWeight.w700),),
                                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),),
                                      Container( // ELÁSTICO/QUANT CUSTO
                                        width: 115,
                                        height: 50,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          initialValue: elastCusReturn().toString(),
                                          autofocus: true,
                                          cursorColor: Colors.brown,
                                          style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                          textAlign: TextAlign.left,
                                          keyboardType: TextInputType.number,
                                          //controller: _ELACUSController,
                                          //controller: ElaCUSController,
                                          decoration: InputDecoration(
                                            prefix: Text('R\$ '),
                                            labelText: "Custo",
                                            labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0, fontWeight: FontWeight.w700),
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(2.0),
                                            //alignLabelWithHint: true,
                                          ),
                                          onChanged: (text){
                                            editado = true;
                                            setState(() {
                                              //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
                                              _editaContato.ELACUS = double.parse(text) as double;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),),
                                      Container(
                                        width: 115,
                                        height: 50,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.done,
                                          initialValue: elastQTDReturn().toString(),
                                          autofocus: true,
                                          cursorColor: Colors.brown,
                                          style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                          textAlign: TextAlign.left,
                                          keyboardType: TextInputType.number,
                                          //controller: _ELAQTDController,
                                          //controller: ElaQTDController,
                                          decoration: InputDecoration(
                                            prefix: Text('cm '),
                                            labelText: "Comprimento",
                                            labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0, fontWeight: FontWeight.w700),
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(2.0),
                                            //alignLabelWithHint: true,
                                          ),
                                          onChanged: (text){
                                            editado = true;
                                            setState(() {
                                              //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
                                              _editaContato.ELAQTD = double.parse(text) as double;
                                            });
                                          },
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
              onPressed: () {
                if(_editaContato.nome != null && _editaContato.nome.isNotEmpty && Biblioteca.varLibrary == false)
                {
                  Biblioteca.deletar(Biblioteca.idLibrary);
                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      Navigator.pop(context, _editaContato);
                      Navigator.pop(context, _editaContato2);
                    });
                  });
                }
                if(_editaContato.nome != null && _editaContato.nome.isNotEmpty)
                {
                  Navigator.pop(context, _editaContato);
                  Navigator.pop(context, _editaContato2);
                }
                  if(_editaContato.nome.isEmpty && Biblioteca.varLibrary == false){
                    Biblioteca.deletar(Biblioteca.idLibrary);
                    _editaContato.nome = nomeReturn();
                    _editaContato2.nome = nomeReturn();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      setState(() {
                        Navigator.pop(context, _editaContato);
                        Navigator.pop(context, _editaContato2);
                      });
                    });
                  }
                  if(Biblioteca.varLibrary == true){
                    _exibeAviso();
                    FocusScope.of(context).requestFocus(_nomeFocus);
                  }
                // else
                // {
                //   _exibeAviso();
                //   FocusScope.of(context).requestFocus(_nomeFocus);
                // }
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

  funcValor() {
    _editaContato.nome = Biblioteca.nomeLibrary;
    // _editaContato.VL = Biblioteca.valorLiqLibrary;
    // _editaContato.LE = Biblioteca.lucroEstLibrary;
    // _editaContato.ES = Biblioteca.estLibrary;
    // _editaContato.ELAQTD = Biblioteca.elastQTDLibrary;
    // _editaContato.ELACUS = Biblioteca.elastCustLibrary;
    // _editaContato.TECQTD = Biblioteca.tecQTDLibrary;
    // _editaContato.TECCUS = Biblioteca.tecCustLibrary;
    // _editaContato.HT = Biblioteca.horaTrabLibrary;
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
  horaTrabReturn (){
    if(Biblioteca.varLibrary == false){
      //_editaContato.HT = Biblioteca.horaTrabLibrary;
      return Biblioteca.horaTrabLibrary.toString();
    }
    else{
      return '';
    }
  }
  lucroEstReturn (){
    if(Biblioteca.varLibrary == false){
      //_editaContato.LE = Biblioteca.lucroEstLibrary;
      return Biblioteca.lucroEstLibrary.toString();
    }
    else{
      return '';
    }
  }
  valorLiqReturn (){
    if(Biblioteca.varLibrary == false){
      //_editaContato.VL = Biblioteca.valorLiqLibrary;
      return Biblioteca.valorLiqLibrary.toString();
    }
    else{
      return '';
    }
  }
  estoqueReturn (){
    if(Biblioteca.varLibrary == false){
      //_editaContato.ES = Biblioteca.estLibrary;
      return Biblioteca.estLibrary.toString();
    }
    else{
      return '';
    }
  }
  tecidoCusReturn (){
    if(Biblioteca.varLibrary == false){
      //_editaContato.TECCUS = Biblioteca.tecCustLibrary;
      return Biblioteca.tecCustLibrary.toString();
    }
    else{
      return '';
    }
  }
  tecidoQTDReturn (){
    if(Biblioteca.varLibrary == false){
      //_editaContato.TECQTD = Biblioteca.tecQTDLibrary;
      return Biblioteca.tecQTDLibrary.toString();
    }
    else{
      return '';
    }
  }
  elastCusReturn (){
    if(Biblioteca.varLibrary == false){
      //_editaContato.ELACUS = Biblioteca.elastCustLibrary;
      return Biblioteca.elastCustLibrary.toString();
    }
    else{
      return '';
    }
  }
  elastQTDReturn (){
    if(Biblioteca.varLibrary == false){
      //_editaContato.ELAQTD = Biblioteca.elastQTDLibrary;
      return Biblioteca.elastQTDLibrary.toString();
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

  // void _atualizar(indice){
  //
  //   FirebaseFirestore.instance
  //       .collection('pedido')
  //       .where("id", isEqualTo : indice)
  //       .get().then((value){
  //     value.docs.forEach((element){
  //       FirebaseFirestore.instance.collection("pedido").doc(indice).update({
  //         'ELACUS': 5,
  //         'ELAQTD': 100,
  //         'ES': 3,
  //         'HT': '10',
  //         'LE': 670,
  //         'TECCUS': 10,
  //         'TECQTD': 5,
  //         'VL': 100,
  //         'id': '001',
  //         'nome': 'vaso grande'
  //       });
  //     });
  //   });
  //   //return _exibeContatoPage();
  // }

}
