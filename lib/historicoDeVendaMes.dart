import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daniela/HelpMe/database_helper.dart';
import 'package:daniela/historicoDeVendaValor.dart';
import 'package:daniela/models/contato.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';


import 'historicoDeVenda.dart';
import 'main.dart';

int auxMenuFiltro = 0; // aux=1 -> Mês; aux=2 -> Valor; aux=3 -> A-Z; aux=4-> Z-A
int controleHistoricoVenda = 1;
int ascDesc = 1;
bool booleano = false;
String ordenacao = 'mes';

class Historico_De_Venda_Mes extends StatelessWidget {
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
  var dropdownValue;
  @override
  void initState() {
    super.initState();
    ascDesc;
    ordenacao;
    booleano;

    _exibeTodosContatos();
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


    Future<bool> _onBackPressed() {
      return Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  MyApp()));
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
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
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                MyApp()));
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
                          boxShadow: [
                            BoxShadow(
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
                child: Card(
                  elevation: 3.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
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
                            Padding(padding:  EdgeInsets.fromLTRB(0, 40, 7, 20)),//AJUSTA O ESPAÇAMENTO ENTRE A IMAGEM E O TEXTO
                            Text('Histórico de Vendas',
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
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('venda')
                      .orderBy("mesFiltro", descending: true).snapshots(), // INSTANCIA A COLEÇÃO 'PEDIDO'
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 140, 10, 80),
                      child: ListView(
                        children:
                        snapshot.data.docs.map((collection){ // PRINTA NA TELA OS DADOS DO BANCO, MAPEANDO A COLEÇÃO
                          return  Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )
                            ),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(collection['nome'].toUpperCase(), // PRINTA NA TELA O NOME DO PRODUTO EM MAIUSCULO
                                    style: // ESTILOS DO TEXTO
                                    TextStyle(color: Colors.brown,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),),
                                ],
                              ),
                              subtitle: // SUBTITULO (OS CAMPOS DO FIREBASE)
                              ExpandChild(
                                arrowPadding: EdgeInsets.fromLTRB(0, 0, 210, 0),
                                arrowColor: Colors.brown,
                                arrowSize: 20,
                                expandArrowStyle: ExpandArrowStyle.icon,
                                icon: Icons.arrow_drop_down,
                                child: Container(
                                  child: Column( // LISTA NA TELA OS CAMPOS DO FIREBASE
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Valor : R\$ ' + collection['valor'].toStringAsFixed(2),
                                        style: TextStyle(color: Colors.brown,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),),
                                      Text('Data do cadastro : ' + collection['mes'],
                                        style: TextStyle(color: Colors.brown,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
              ),
            ]
        ),

        floatingActionButton:
        Row( // BOTÃO TIPO DE LISTAGEM
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 325.0),
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
                      child: Center(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.brown,
                          ),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            underline: SizedBox(),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 0,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),


                            hint: Text(" Filtro", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                            onChanged: (String newValue) {
                              Future.delayed(const Duration(milliseconds: 100), () {
                                setState(() {
                                  if(newValue == '  Mês'){
                                    ordenacao = "mes";
                                    return;
                                  }
                                  if(newValue == ' Valor'){
                                    // Filtro valor
                                    ordenacao = "valor";
                                    booleano = false;
                                    controleHistoricoVenda = 2;
                                    ascDesc = 2;
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Historico_De_Venda_Valor()));
                                  }
                                  if(newValue == '  A-Z'){
                                    // Filtro A-Z
                                    ordenacao = "nome";
                                    booleano = false;
                                    controleHistoricoVenda = 1;
                                    ascDesc = 2;
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Historico_De_Venda()));
                                  }
                                  else{
                                    // Filtro Z-A
                                    ordenacao = "nome";
                                    booleano = true;
                                    controleHistoricoVenda = 1;
                                    ascDesc = 1;
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Historico_De_Venda()));
                                  }
                                });
                              });
                              setState(() {
                                print(controleHistoricoVenda);
                                //dropdownValue = newValue;
                              });
                            },
                            items: <String>['  Mês', ' Valor', '  A-Z', '  Z-A']
                                .map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, textAlign: TextAlign.center,),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

crescOuDecresc (x){ // 1 RETORNA ORDEM DECRESCENTE
  if (x == 1){
    return true;
  }
  if (x == 2){
    return false; // RETORNA ORDEM CRESCENTE
  }
  else{
    return false;
  }
}

variavelOrdenacao (x){
  if (x == 1){
    return 'nome';
  }
  if (x == 2){
    return 'ES';
  }
  if (x == 3){
    return 'DT';
  }
  else {
    return 'nome';
  }
}

estoque (){
  return 'ES';
}

crescente (){
  return false;
}

