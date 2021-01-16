import 'package:daniela/HelpMe//database_helper.dart';
import 'package:daniela/models/contato.dart';
import 'package:daniela/pages/contatoPage.dart';
import 'package:daniela/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _titulo = "Historico de venda";
class Historico_De_Venda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HistVenda(
    );

  }
}


class HistVenda extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HistVenda> {

  DatabaseHelper db = DatabaseHelper();
  List<Contato> hists = List<Contato>();
  List<Contato> hists2 = List<Contato>();

  @override
  void initState() {
    super.initState();

    //Contato c = Contato(1,"Maria",2,2,2,2);
    //db.insertContato(c);
     _exibeTodosContatos();
    //print(Contato(2,"Maria",2,2,2,4));
  }


  void _exibeTodosContatos(){
    db.getContatos2().then((lista) {
      setState(() {
        hists = lista.cast<Contato>();
      });
    });
    db.getContatos().then((lista) {
      setState(() {
        hists2 = lista.cast<Contato>();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titulo),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,


      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: hists.length ,
        itemBuilder: (context, index) {
          return listaContatos(context,index);
        },
      ),
    );
  }

  listaContatos(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
          child: Padding(padding: EdgeInsets.all(10.0),
              child:Row(
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
                          Text(hists[index].nome ?? "",
                              style: TextStyle(fontSize: 20)
                          ),
                          Text("Mudança no Estoque: " + (hists[index].ES).toString() ?? "",
                              style: TextStyle(fontSize: 15)
                          ),
                          /*Text("Renda Estimada: R\$ " + (hists[index].VL).toStringAsFixed(2) ?? "",
                              style: TextStyle(fontSize: 15)
                          ),*/
                          Text("Data: ${(new DateFormat.yMMMd().format(new DateTime.now()))}",
                          ),

                        ],
                      )
                  )
                ],
              )
          )
      ),

    );
  }



  void _exibeContatoPage({Contato hist}) async {
    final contatoRecebido =  await Navigator.push(context,
      MaterialPageRoute(
          builder: (
              context)=> ContatoPages(contato: hist)
      ),
    );

    if(contatoRecebido != null){
      if(hist != null )
      {
        await db.updateContato(contatoRecebido);
      }else{
        await db.insertContato(contatoRecebido);
      }
      _exibeTodosContatos();
    }
  }
}
