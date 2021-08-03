import 'package:daniela/TodosdaLib/models/contato.dart';
import 'package:flutter/material.dart';
import 'package:daniela/contato.dart' as d2;
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Venda_biblioteca.dart' as Biblioteca;

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

  final _controleNome =
      new TextEditingController(text: nomeReturn().toString());
  final _controleValor = new TextEditingController(text: valorReturn());
  final _controleMes =
      new MaskedTextController(mask: '00/00/0000', text: mesReturn());

  var teste = Biblioteca.nomeLibrary;

  bool editado = false;
  Contato _editaContato;
  d2.Contato _editaContato2;

  var mesLocal = Biblioteca.mesLibrary;
  var valorLocal = Biblioteca.valorLibrary;
  var nomeLocal = Biblioteca.nomeLibrary;

  @override
  void initState() {
    super.initState();
    funcValor();
    nomeReturn();
    mesReturn();
    valorReturn();

    if (widget.contato == null) {
      _editaContato = Contato(Biblioteca.idRandom(), '', '', 0, '');
    } else {
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('venda').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(overflow: Overflow.visible, children: <Widget>[
              Expanded(
                child: Container(
                  //BACKGROUND
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("Image/tela2.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                //BOTÃO DE RETORNO - SETA
                padding: const EdgeInsets.only(top: 15.0),
                child: Positioned(
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
                              color: Color.fromARGB(255, 255, 246, 161)
                                  .withOpacity(1.0),
                              spreadRadius: 10.0,
                              blurRadius: 0,
                              offset: Offset(0, 0),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 80, 10, 0),
                child: Card(
                  //CARD COM INPUTS
                  elevation: 3.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      //AJUSTA O ARREDONDAMENTO DO CARD
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
                            Text(
                                Biblioteca.conditionalName(
                                    Biblioteca.varLibrary),
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
                        Column(
                          children: [
                            Container(
                              width: 330,
                              height: 50,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                autofocus: true,
                                cursorColor: Colors.brown,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    height: 1.5,
                                    color: Colors.brown),
                                textAlign: TextAlign.left,
                                controller: _controleNome,
                                decoration: InputDecoration(
                                  labelText: 'Nome ou Descrição',
                                  labelStyle: TextStyle(
                                      color: Colors.brown,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(2.0),
                                ),
                                onChanged: (text) {
                                  if (Biblioteca.varLibrary == false) {
                                    if (text.isEmpty || text == null) {
                                      setState(() {
                                        _editaContato.nome =
                                            Biblioteca.nomeLibrary;
                                        _editaContato2.nome =
                                            Biblioteca.nomeLibrary;
                                      });
                                    } else {
                                      setState(() {
                                        Biblioteca.nomeLibrary = text;
                                        _editaContato.nome = text;
                                        _editaContato2.nome = text;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      Biblioteca.nomeLibrary = text;
                                      _editaContato.nome = text;
                                      _editaContato2.nome = text;
                                    });
                                  }
                                },
                              ),
                            ),
                            Container(
                              //CONTAINER PARA VALOR LÍQUIDO
                              width: 330,
                              height: 50,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                autofocus: true,
                                cursorColor: Colors.brown,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  height: 1.5,
                                  color: Colors.brown,
                                ),
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.number,
                                controller: _controleValor,
                                decoration: InputDecoration(
                                  prefix: Text('R\$ '),
                                  labelText: "Valor",
                                  labelStyle: TextStyle(
                                      color: Colors.brown,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(2.0),
                                  //alignLabelWithHint: true,
                                ),
                                onChanged: (text) {
                                  if (Biblioteca.varLibrary == false) {
                                    if (text.isEmpty || text == null) {
                                      setState(() {
                                        _editaContato.valor =
                                            Biblioteca.valorLibrary;
                                      });
                                    } else {
                                      setState(() {
                                        _editaContato.valor =
                                            double.parse(text) as double;
                                        Biblioteca.valorLibrary =
                                            double.parse(text) as double;
                                      });
                                    }
                                  } else {
                                    editado = true;
                                    setState(() {
                                      _editaContato.valor =
                                          double.parse(text) as double;
                                      Biblioteca.valorLibrary =
                                          double.parse(text) as double;
                                    });
                                  }
                                },
                              ),
                            ),
                            Container(
                              //CONTAINER PARA VALOR LÍQUIDO
                              width: 330,
                              height: 50,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                autofocus: true,
                                cursorColor: Colors.brown,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  height: 1.5,
                                  color: Colors.brown,
                                ),
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.number,
                                controller: _controleMes,
                                decoration: InputDecoration(
                                  prefix: Text(''),
                                  labelText: "Data",
                                  labelStyle: TextStyle(
                                      color: Colors.brown,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(2.0),
                                ),
                                onChanged: (text) {
                                  if (Biblioteca.varLibrary == false) {
                                    if (text.isEmpty || text == null) {
                                      setState(() {
                                        _editaContato.mes =
                                            Biblioteca.mesLibrary;
                                      });
                                    } else {
                                      if (_editaContato.mes.length < 10 &&
                                          Biblioteca.mesLibrary
                                                  .toString()
                                                  .length <
                                              10) {
                                        setState(() {
                                          _editaContato.mes = text;
                                          Biblioteca.mesLibrary = text;
                                          text = "";
                                        });
                                      }
                                    }
                                  } else {
                                    editado = true;
                                    if (_editaContato.mes.length < 10 &&
                                        Biblioteca.mesLibrary
                                                .toString()
                                                .length <
                                            10) {
                                      setState(() {
                                        _editaContato.mes = text;
                                        Biblioteca.mesLibrary = text;
                                        text = "";
                                      });
                                    }
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
            ]);
          }),
      floatingActionButton: //BOTÃO SALVAR
          Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            //AJUSTA O POSICIONAMENTO DO BOTÃO
            padding: const EdgeInsets.only(left: 325.0),
            child: FloatingActionButton(
              heroTag: 'unq2',
              onPressed: () async {
                if (Biblioteca.varLibrary == false) {
                  if (_editaContato.nome != null &&
                      _editaContato.nome.isNotEmpty) {
                    Biblioteca.Vendadeletar(Biblioteca.idLibrary);
                    Future.delayed(const Duration(milliseconds: 400), () {
                      setState(() {
                        Biblioteca.Vendacriar(Biblioteca.idLibrary);
                        Biblioteca.mesLibrary = "";
                        _editaContato.mes = "";
                        Navigator.pop(context);

                      });
                    });
                    _exibeAvisoEditar();
                  }
                  if (_editaContato.nome.isEmpty ||
                      _editaContato.nome == null) {
                    Future.delayed(const Duration(milliseconds: 400), () {
                      setState(() {
                        Biblioteca.Vendacriar(Biblioteca.idLibrary);
                        Biblioteca.mesLibrary = "";
                        _editaContato.mes = "";
                        Navigator.pop(context);
                      });
                    });
                    _exibeAvisoEditar();
                  }
                } else {
                  if (_editaContato.nome.isNotEmpty &&
                      _editaContato.nome != null &&
                      Biblioteca.varLibrary == true) {
                    Biblioteca.addVenda();
                    Navigator.pop(context, _editaContato2);
                  } else {
                    // ADIÇÃO DE PRODUTO SE O NOME NÃO FOR DIGITADO
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
                      Color.fromARGB(255, 230, 119, 53),
                      Color.fromARGB(255, 161, 88, 52)
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
          content: new Text("Informe o nome da Venda"),
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
          content: new Text(
            "Editado com sucesso!!",
            style: TextStyle(color: Colors.brown, fontSize: 20),
          ),
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

  Future<void> funcValor() async {
    if (Biblioteca.varLibrary == false) {
      setState(() {
        _editaContato.nome = Biblioteca.nomeLibrary;
        _editaContato.valor = Biblioteca.valorLibrary;
        _editaContato.mes = Biblioteca.mesLibrary;
      });
    }
  }

  static nomeReturn() {
    if (Biblioteca.varLibrary == false) {
      return Biblioteca.nomeLibrary.toString();
    } else {
      return '';
    }
  }

  static mesReturn() {
    if (Biblioteca.varLibrary == false) {
      return Biblioteca.mesLibrary.toString();
    } else {
      return '';
    }
  }

  static valorReturn() {
    if (Biblioteca.varLibrary == false) {
      return Biblioteca.valorLibrary.toStringAsFixed(2);
    } else {
      return '';
    }
  }
}
