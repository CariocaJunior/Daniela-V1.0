import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daniela/TodosdaLib/models/contato.dart';
import 'package:daniela/TodosdaLib/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:daniela/main.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:daniela/TodosdaLib/pages/home_page.dart' as dan;

class ContatoPage extends StatefulWidget {

  final Contato contato;
  final List<String> names;
  ContatoPage({this.contato, this.names});


  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {

  final _nomeController = TextEditingController();
  final _HTController = TextEditingController();
  final _LEController = TextEditingController();
  final _VLController = TextEditingController();
  final _nomeFocus = FocusNode();
  final _producao = TextEditingController();
  bool editado= false;
  Contato _editaContato;
  //var maskFormatter = new MaskTextInputFormatter(mask: '+# (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });
  var VenController = new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  var LucController = new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  var DatController = new MaskedTextController(mask: '00/00/0000');
  //var controller = new MoneyMaskedTextController();
  //var controller = new MaskedTextController(mask: '000.000.000-00');


  String _selectedValue = "";
  @override
  void initState(){

    super.initState();

    if(widget.contato == null){
      _editaContato = Contato(null,'',0,0,0,0);
    }else{
      _editaContato = Contato.fromMap(widget.contato.toMap());

      _nomeController.text = _editaContato.mes;
      _VLController.text = _editaContato.caixa.toString();
      _LEController.text = _editaContato.markup.toString();
      _HTController.text = _editaContato.TotVendas.toString();
      _producao.text = _editaContato.Producao.toString();

    }
  }
  void pass(List<String> names) async{

  }
  /*Future<List> draggin() async {
    QuerySnapshot dosd = await FirebaseFirestore.instance.collection("pedido").get();
    dosd.docs.forEach((element) {
      names2.add(element.get("nome"));
      setState(() {
        names = names2;
      });
    });
  }*/
  int _count = 1;
  @override
  Widget build(BuildContext context) {
    List<Widget> _contatos =
    new List.generate(_count, (int i) => new ContactRow());

    return Scaffold(
      resizeToAvoidBottomPadding: false, //RETIRA O OVERFLOW DO BACKGROUND
      /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            if(_editaContato.mes != null && _editaContato.mes.isNotEmpty)
            {
              Navigator.pop(context, _editaContato);
            }else{
              _exibeAviso();
              FocusScope.of(context).requestFocus(_nomeFocus);
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Colors.indigo,
        ),*/
      /*body: SingleChildScrollView(
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
                  decoration: InputDecoration(labelText: "Mês"),
                  onChanged: (text){
                    editado = true;
                    setState(() {
                      _editaContato.mes = text;
                    });
                  },
                ),
                TextField(
                  controller: _HTController,
                  decoration: InputDecoration(labelText: "Vendas"),
                  onChanged: (text){
                    editado = true;
                    setState(() {
                      //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');

                      _editaContato.TotVendas = double.parse(text);
                    });
                  },
                ),
                TextField(
                  controller: _LEController,
                  decoration: InputDecoration(labelText: "Lucro esperado o famoso markup"),
                  onChanged: (text){
                    editado = true;
                    setState(() {
                      _editaContato.markup = double.parse(text);
                    });
                  },
                ),
                TextField(
                  controller: _VLController,
                  decoration: InputDecoration(labelText: "Caixa"),
                  onChanged: (text){
                    editado = true;
                    setState(() {
                      //icone: Icons.monetization_on;
                      _editaContato.caixa = double.parse(text);
                    });
                  },
                ),
                TextField(
                  controller: _producao,
                  decoration: InputDecoration(labelText: "Producao"),
                  onChanged: (text){
                    editado = true;
                    setState(() {
                      //icone: Icons.monetization_on;
                      _editaContato.Producao = double.parse(text);
                    });
                  },
                ),

              ],
            )
        )*/

      body: Stack(
          overflow: Overflow.visible,

          children: <Widget>[
            Container( //BACKGROUND
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
            // FittedBox(
            //   child: Image.asset('Image/tela2.png'),
            //   fit: BoxFit.cover
            // ),
            /*body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: hists.length ,
        itemBuilder: (context, index) {
          return listaContatos(context,index);
        },
      ),*/
            Padding( //BOTÃO DE RETORNO - SETA
              padding: const EdgeInsets.only(top: 15.0),
              child: Stack(
                children: [
                  Positioned(
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
                ],
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
                          Padding(padding:  EdgeInsets.fromLTRB(0, 40, 7, 20)),//AJUSTA O ESPAÇAMENTO ENTRE A IMAGEM E O TEXTO
                          Text('Nova Venda',
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
                      //LISTA DE CAIXAS DE TEXTO (INPUT)
                      Container( //CONTAINER - INPUT DATA
                        width: 330,
                        height: 70,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextField(
                            autofocus: true,
                            cursorColor: Colors.brown,
                            style: TextStyle(fontSize: 22.0, height: 1.5, color: Colors.brown),
                            textAlign: TextAlign.left,
                            //controller: _nomeController,
                            controller: DatController,
                            //focusNode: _nomeFocus,
                            decoration: InputDecoration(
                              //errorText: 'Error!!!',
                              //prefix: Text('R\$ '),
                              labelText: 'Data',
                              //hintText: 'Mês',
                              labelStyle: TextStyle(color: Colors.brown, fontSize: 22.0),
                              isDense: true,
                              contentPadding: EdgeInsets.all(2.0),
                              //alignLabelWithHint: true,
                              //contentPadding: EdgeInsets.only(top: -20.0),
                              //border: OutlineInputBorder(),
                            ),
                            onChanged: (text){
                              editado = true;
                              setState(() {
                                _editaContato.mes = text;
                              });
                            },
                          ),
                        ),
                      ),
                      Container( //CONTAINER INPUT VENDA
                        width: 330,
                        height: 70,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextField(
                            autofocus: true,
                            cursorColor: Colors.brown,
                            style: TextStyle(fontSize: 22.0, height: 1.5, color: Colors.brown),
                            textAlign: TextAlign.left,
                            //controller: _HTController,
                            controller: VenController,
                            decoration: InputDecoration(
                              prefix: Text('R\$ '),
                              labelText: "Venda",
                              labelStyle: TextStyle(color: Colors.brown, fontSize: 22.0),
                              isDense: true,
                              contentPadding: EdgeInsets.all(2.0),
                              //alignLabelWithHint: true,
                            ),
                            onChanged: (text){
                              editado = true;
                              setState(() {
                                //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
                                _editaContato.TotVendas = double.parse(text);
                              });
                            },
                          ),
                        ),
                      ),

                      Container( //CONTAINER PARA CAIXA
                        width: 330,
                        height: 70,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextField(
                            autofocus: true,
                            cursorColor: Colors.brown,
                            style: TextStyle(fontSize: 22.0, height: 1.5, color: Colors.brown,),
                            textAlign: TextAlign.left,
                            controller: _VLController,
                            decoration: InputDecoration(
                              labelText: "Caixa",
                              labelStyle: TextStyle(color: Colors.brown, fontSize: 22.0),
                              isDense: true,
                              contentPadding: EdgeInsets.all(2.0),
                              //alignLabelWithHint: true,
                            ),
                            onChanged: (text){
                              editado = true;
                              setState(() {
                                //icone: Icons.monetization_on;
                                _editaContato.caixa = double.parse(text);
                              });
                            },
                          ),
                        ),
                      ),

                      /*Row(
                        children: [
                          DropdownButton<String>(
                            items: temp
                                .map((data) => DropdownMenuItem<String>(
                              child: Text(data),
                              value: data,
                            ))
                                .toList(),
                            onChanged: (String value) {
                              setState(() => _selectedValue = "value");
                            },
                            hint: Text('Select Key'),
                          ),
                          RaisedButton(
                            onPressed: (){},
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle, // circular shape
                                /*gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.centerLeft,
                                  stops: [0.3, 1.0],
                                  colors: [
                                    Color.fromARGB(255,230,119,53), Color.fromARGB(255,161,88,52)
                                  ],
                                ),*/
                              ),
                              child: Icon(Icons.save, size: 40.0),
                            ),
                          ),

                        ],
                      ),*/
                      new Container(
                        height: 250.0,
                        width: 500,
                        padding: new EdgeInsets.fromLTRB(20, 5, 5, 5),
                        child: new ListView(
                          children: _contatos,
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                      Container(
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
                        child: new FlatButton(
                          onPressed: _addNewContactRow,
                          child: new Icon(Icons.add,color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]
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
                //Alerta
                return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Alerta'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: const <Widget>[
                              Text('Desabilitado temporariamente'),

                            ],
                          ),
                        ),
                      );
                    }
                );
                /*if(_editaContato.mes != null && _editaContato.mes.isNotEmpty)
                {
                  Navigator.pop(context, _editaContato);
                }else{
                  _exibeAviso();
                  FocusScope.of(context).requestFocus(_nomeFocus);
                }*/
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


  /* );
  }*/
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
  void _addNewContactRow() {
    setState(() {
      _count = _count + 1;
    });
  }
}

//Implementação da lista de produtos vendidos
class ContactRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ContactRow();
}
class _ContactRow extends State<ContactRow> {
  String _selectedValue = "";
  @override
  Widget build(BuildContext context) {
    return new Container(
        width: 150,
        padding: new EdgeInsets.all(5.0),
        child: new Column(children: <Widget>[
          new Text("Produto:",style: TextStyle(fontSize: 35.0, height: 1.5, color: Colors.brown,)),
          new DropdownButton<String>(
            items: temp
                .map((data) => DropdownMenuItem<String>(
              child: Text(data),
              value: data,
            ))
                .toList(),
            onChanged: (String value) {
              setState(() => _selectedValue = value);
            },
            style: TextStyle(fontSize: 22.0, height: 1.5, color: Colors.brown,),
            hint: Text(_selectedValue),
          ),
          new TextFormField(
            style: TextStyle(fontSize: 22.0, height: 1.5, color: Colors.brown,),
            decoration: new InputDecoration(
              labelText: 'Quantidade:',
            ),
          ),
          new Container(
            padding: new EdgeInsets.all(10.0),
          ),
        ]));
  }

  List _contactTypes = ["testing", "test2"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentContactType;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentContactType = null;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _contactTypes) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentContactType = selectedCity;
    });
  }
}
