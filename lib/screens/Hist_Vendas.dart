// import 'dart:io';
// import 'package:daniela/TodosdaLib/models/contato.dart';
// import 'package:flutter/material.dart';
// import 'package:daniela/main.dart';
//
// //import 'package:flutter_masked_text/flutter_masked_text.dart';
//
// class Hist_Vendas extends StatefulWidget {
//
//   final Contato contato;
//   Hist_Vendas({this.contato});
//
//   @override
//   _Hist_VendasState createState() => _Hist_VendasState();
// }
//
// class _Hist_VendasState extends State<Hist_Vendas> {
//
//   final _nomeController = TextEditingController();
//   final _HTController = TextEditingController();
//   final _LEController = TextEditingController();
//   final _VLController = TextEditingController();
//   final _nomeFocus = FocusNode();
//   final _producao = TextEditingController();
//   bool editado= false;
//   Contato _editaContato;
//
//   @override
//   void initState(){
//     super.initState();
//
//     if(widget.contato == null){
//       _editaContato = Contato(null,'',0,0,0,0);
//     }else{
//       _editaContato = Contato.fromMap(widget.contato.toMap());
//
//       _nomeController.text = _editaContato.mes;
//       _VLController.text = _editaContato.caixa.toString();
//       _LEController.text = _editaContato.markup.toString();
//       _HTController.text = _editaContato.TotVendas.toString();
//       _producao.text = _editaContato.Producao.toString();
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.indigo,
//           title: Text(_editaContato.mes == '' ? "Tabela Mês" :
//           _editaContato.mes ),
//           centerTitle: true,
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             if(_editaContato.mes != null && _editaContato.mes.isNotEmpty)
//             {
//               Navigator.pop(context, _editaContato);
//             }else{
//               _exibeAviso();
//               FocusScope.of(context).requestFocus(_nomeFocus);
//             }
//           },
//           child: Icon(Icons.save),
//           backgroundColor: Colors.indigo,
//         ),
//         body: SingleChildScrollView(
//             padding: EdgeInsets.all(10.0),
//             child: Column(
//               children: <Widget>[
//                 GestureDetector(
//                   child: Container(
//                     width: 70.0, height: 70.0,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//
//                     ),
//                   ),
//                 ),
//                 TextField(
//                   controller: _nomeController,
//                   focusNode: _nomeFocus,
//                   decoration: InputDecoration(labelText: "Mês"),
//                   onChanged: (text){
//                     editado = true;
//                     setState(() {
//                       _editaContato.mes = text;
//                     });
//                   },
//                 ),
//                 TextField(
//                   controller: _HTController,
//                   decoration: InputDecoration(labelText: "Vendas"),
//                   onChanged: (text){
//                     editado = true;
//                     setState(() {
//                       //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
//
//                       _editaContato.TotVendas = double.parse(text);
//                     });
//                   },
//                 ),
//                 TextField(
//                   controller: _LEController,
//                   decoration: InputDecoration(labelText: "Lucro esperado o famoso markup"),
//                   onChanged: (text){
//                     editado = true;
//                     setState(() {
//                       _editaContato.markup = double.parse(text);
//                     });
//                   },
//                 ),
//                 TextField(
//                   controller: _VLController,
//                   decoration: InputDecoration(labelText: "Caixa"),
//                   onChanged: (text){
//                     editado = true;
//                     setState(() {
//                       //icone: Icons.monetization_on;
//                       _editaContato.caixa = double.parse(text);
//                     });
//                   },
//                 ),
//                 TextField(
//                   controller: _producao,
//                   decoration: InputDecoration(labelText: "Producao"),
//                   onChanged: (text){
//                     editado = true;
//                     setState(() {
//                       //icone: Icons.monetization_on;
//                       _editaContato.Producao = double.parse(text);
//                     });
//                   },
//                 ),
//
//               ],
//             )
//         )
//     );
//   }
//
//   void _exibeAviso() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: new Text("Nome"),
//           content: new Text("Informe o nome do contato"),
//           actions: <Widget>[
//             new FlatButton(
//               child: new Text("Fechar"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
// }