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
  String dropdownValue = 'One';
  String _chosenValue;

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
      body: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
      /*body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: hists.length ,
        itemBuilder: (context, index) {
          return listaContatos(context,index);
        },
      ),*/
        Container( // PLANO DE FUNDO
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
        Padding( // AJUSTE DE POSIÇÃO, CARD PRINCIPAL
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
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(Icons.history, size: 43.0, color: Colors.brown),
                      Padding(padding:  EdgeInsets.fromLTRB(0, 40, 0, 20)), // AJUSTE ENTRE ÍCONE E TEXTO
                      Text('Histórico de venda',
                          //textAlign: TextAlign.end,
                          style: new TextStyle(
                          fontSize: 33.0,
                          color: Colors.brown,
                      )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10.0, left: 10.0, right: 10.0),
                  ),
                  Card(
                    elevation: 5.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder( //AJUSTA O ARREDONDAMENTO DO CARD
                      //borderRadius: BorderRadius.circular(20.0),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )
                    ),
                    child: DropdownButton<String>(
                      focusColor:Colors.white,
                      value: _chosenValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.brown),
                      underline: Container(
                        height: 2,
                        color: Colors.brown,
                      ),
                      items: <String>['Data', 'Preço', 'A-Z', 'Z-A'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: dropdownValue,
                          child: new Text(value, style: TextStyle(color: Colors.brown),),
                        );
                      }).toList(),
                      hint: Text(
                        "Selecione uma opção",
                        style: TextStyle(color: Colors.brown.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValue = value;
                        });
                      },
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
                child: Icon(Icons.filter_list_alt, size: 40.0),
              ),
            ),
          ),
        ],
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
