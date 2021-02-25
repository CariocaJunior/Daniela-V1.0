import 'package:daniela/screens/TabelaDeDistribuicao.dart';
import 'package:daniela/screens/planilhaPrecificacao.dart';
import 'package:flutter/material.dart';
import 'package:daniela/Roteamento.dart';
import 'package:daniela/HelpMe/database_helper.dart';
import 'package:daniela/models/contato.dart';
import 'package:daniela/pages/home_page.dart' as prodhome;
import 'package:daniela/TodosdaLib/pages/home_page.dart' as distrihome;
import 'package:daniela/historicoDeVenda.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Login/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:daniela/Login/screens/menu.dart';
//import 'package:daniela/Login/screens/login/ui/login_page.dart';
import 'pages/home_page.dart';
import 'package:daniela/Login/routes.dart';
import 'package:daniela/Login/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User user = await FirebaseAuth.instance.currentUser;
  runApp(MyApp2());
}

TextEditingController _txtCtrl = TextEditingController();

final FocusNode myFocusNodeEmailLogi = FocusNode();

TextEditingController loginEmailControlle = new TextEditingController();

//testebranch
var tabela = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        home: MyHome());
  }
}

class MyHome extends StatelessWidget {
  int _counter = 0;

  DatabaseHelper db = DatabaseHelper();

  List<Contato> contatos = List<Contato>();

  @override
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Historico_De_Venda()));*/
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Tem Certeza?'),
          content: new Text('Quer Sair do aplicativo?'),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("Não"),
            ),
            SizedBox(height: 16),
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("Sim"),
            ),
          ],
        ),
      );
      false;
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        // Botão para Desconectar
        /*floatingActionButton: FloatingActionButton(

          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, LoginPage);
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(

              shape: BoxShape.circle, // circular shape
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.3, 1.0],
                colors: [
                  Color.fromARGB(255,230,119,53), Color.fromARGB(255,161,88,52)
                ],
              ),
              image: DecorationImage(
                  image: AssetImage("Image/Left_Arrow.png"),
                  scale: 1.9
                 ),
            ),

          ),
        ),*/
        body: Stack(
          children: <Widget>[
            Container(
                //this is the problem
                //padding: new EdgeInsets.all(105.0),
                decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("Image/bibiimagem.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.green.withOpacity(1.0), BlendMode.dstATop)),
            )),

            /*Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(

                  children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                   child: IconButton(
                    icon: Image.asset('Image/Produto.png',color: Color.fromARGB(255, 148,82,52)),
                    iconSize: 60,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => prodhome.HomePage()));
                    },
                  ),
                  //child: Icon(Icons.history, size: 50,),
                ),
                Text("Produtos",style: TextStyle(fontSize: 36.0,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 148,82,52)),),
              ]),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                focusNode: myFocusNodeEmailLogi,
                controller: loginEmailControlle,
                onChanged: (text) {
                  //Colocar Variavel depois
                  //email = text;
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    fontFamily: "WorkSansSemiBold",
                    fontSize: 16.0,
                    color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Nome do Produto",
                  hintStyle: TextStyle(
                      fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                ),
              ),
            ),


        ]),*/

            //Botão para ser usado em outras telas
            /*Positioned(
          left: 5,
          top: 5,
          child: FloatingActionButton(
            onPressed: () {

            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(

                shape: BoxShape.circle, // circular shape
                color: Color.fromARGB(255,255,246,161),
                image: DecorationImage(
                    image: AssetImage("Image/Left_Arrow.png"),
                    scale: 1.9
                ),
              ),
            ),
          ),
        ),*/
            Container(
              height: 810.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 255, 252, 227).withOpacity(0.0),
                        Color.fromARGB(255, 255, 252, 227),
                      ],
                      stops: [
                        0.85,
                        1.0
                      ])),
            ),
            Column(
              children: [
                Center(
                  child: new Column(
                    children: <Widget>[
                      Center(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new SizedBox(
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      18, 230, 12, 12),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 240.0,
                                        height: 140.0,
                                        child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.grey)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18),
                                              child: Column(
                                                // Replace with a Row for horizontal icon + text
                                                children: <Widget>[
                                                  Icon(Icons.history,
                                                      size: 70.0,
                                                      color: Colors.lightGreen),
                                                  Text(
                                                    "Histórico",
                                                    style: new TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            color: Colors.white,
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Historico_De_Venda()));
                                            } // ação ,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12, 230, 18, 12),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 240.0,
                                        height: 140.0,
                                        //Image/bibiimagem.jpeg
                                        child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.grey)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 13),
                                              child: Column(
                                                // Replace with a Row for horizontal icon + text
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Image.asset(
                                                        'Image/Produto.png'),
                                                    iconSize: 60,
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  prodhome
                                                                      .HomePage()));
                                                    },
                                                  ),
                                                  Text(
                                                    "Produto",
                                                    style: new TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black54,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            textColor: Colors.black,
                                            color: Colors.white,
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          prodhome.HomePage()));
                                            } // ação ,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: new Column(
                    children: <Widget>[
                      Center(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new SizedBox(
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(100, 0, 12, 60),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 170.0,
                                        height: 140.0,
                                        child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.grey)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18),
                                              child: Column(
                                                // Replace with a Row for horizontal icon + text
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Image.asset(
                                                        'Image/Venda.png'),
                                                    iconSize: 65,
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Tabela_De_Distribuicao()));
                                                    },
                                                  ),
                                                  Text(
                                                    "Vendas",
                                                    style: new TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            color: Colors.white,
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Tabela_De_Distribuicao()));
                                            } // ação ,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  DatabaseHelper db = DatabaseHelper();

  List<Contato> contatos = List<Contato>();
  @override
  void initState() {
    super.initState();

    db.getContatos().then((lista) {
      print(lista);
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: 0,
        itemBuilder: (context, index) {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
