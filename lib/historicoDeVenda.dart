import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daniela/HelpMe//database_helper.dart';
import 'package:daniela/models/contato.dart';
import 'package:daniela/pages/contatoPage.dart';
import 'package:daniela/pages/home_page.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:daniela/pages/biblioteca.dart' as Biblioteca;


const _titulo = "Historico de venda";
//final listaHistorico = List
int auxMenuFiltro = 0; // aux=1 -> Mês; aux=2 -> Valor; aux=3 -> A-Z; aux=4-> Z-A
int controleHistoricoVenda = 1;
int ascDesc = 1;
bool booleano = false;
String ordenacao = 'DT';

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
  var dropdownValue;
  @override
  void initState() {
    super.initState();
    ascDesc;
    ordenacao;
    booleano;

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
                          //Icon(Icons.history, size: 43.0, color: Colors.brown),
                          Image(
                            image: AssetImage('Image/Produto.png',),
                            width: 45,
                            fit: BoxFit.cover,
                            color: Colors.brown,
                          ),
                          Padding(padding:  EdgeInsets.fromLTRB(0, 40, 7, 20)),//AJUSTA O ESPAÇAMENTO ENTRE A IMAGEM E O TEXTO
                          Text('Histórico de Vendas',
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
                stream: FirebaseFirestore.instance.collection('pedido')
                  .orderBy(ordenacao.toString(), descending: booleano).snapshots(), // INSTANCIA A COLEÇÃO 'PEDIDO'
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
                            //borderRadius: BorderRadius.circular(20.0),
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
                              //hideArrowOnExpanded: true,
                              arrowColor: Colors.brown,
                              arrowSize: 20,
                              expandArrowStyle: ExpandArrowStyle.icon,
                              icon: Icons.arrow_drop_down,
                              child: Container(
                                child: Column( // LISTA NA TELA OS CAMPOS DO FIREBASE
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Horas trabalhada : ' + collection['HT'] + ' hrs',
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),),
                                    Text('Lucro estimado : R\$ ' + collection['LE'].toStringAsFixed(2),
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),),
                                    Text('Valor líquido : R\$ ' + collection['VL'].toStringAsFixed(2),
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),),
                                    Text('Elástico gasto : ' + collection['ELAQTD'].toStringAsFixed(2) + ' cm',
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),),
                                    Text('Custo do elástico : R\$ ' + collection['ELACUS'].toStringAsFixed(2),
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),),
                                    Text('Tecido gasto : ' + collection['TECQTD'].toStringAsFixed(2) + ' cm',
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),),
                                    Text('Custo do tecido : R\$ ' + collection['TECCUS'].toStringAsFixed(2),
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),),
                                    Text('Estoque do produto : ${collection['ES']}',
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),),
                                    Text('Data do cadastro : ' + collection['DT'],
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
                //elevation: 16,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                // underline: Container(
                //     height: 2,
                //     color: Colors.brown,
                // ),

                 hint: Text(" Filtro", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                onChanged: (String newValue) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    setState(() {
                      if(newValue == '  Mês'){
                        ordenacao = "DT";
                        booleano = false;
                        ascDesc = 2; // Controle de ordem crescente ou descrescente (false = asc; true = desc)
                        controleHistoricoVenda = 3; // Controla o modo de exibição
                      }
                      if(newValue == ' Valor'){
                        // Filtro valor
                        booleano = false;
                        ordenacao = "ES";
                        controleHistoricoVenda = 2;
                        ascDesc = 2;
                      }
                      if(newValue == '  A-Z'){
                        // Filtro A-Z
                        ordenacao = "nome";
                        booleano = false;
                        controleHistoricoVenda = 1;
                        ascDesc = 2;
                      }
                      else{
                        // Filtro Z-A
                        ordenacao = "nome";
                        booleano = true;
                        controleHistoricoVenda = 1;
                        ascDesc = 1;
                      }
                    });
                  });
                    setState(() {
                      print(controleHistoricoVenda);
                      dropdownValue = newValue;
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
                /*child: FloatingActionButton(
                  heroTag: null,
                  //heroTag: 'unq2',
                  onPressed: () {

                    // VARIÁVEL PARA CONTROLE DE EDIÇÃO E ADIÇÃO DE PRODUTO
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
                    child: Icon(Icons.filter_alt_rounded, size: 50.0),
                  ),
                ),*/
              ),
            ],
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

teste(){}
// void sort([int compare(E a, E b)?]);
