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
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamed(context, LoginPage);
        },
        child: Icon(Icons.close),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Container(
          //this is the problem
          //padding: new EdgeInsets.all(105.0),
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("Image/bibiimagem.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.green.withOpacity(1.0), BlendMode.dstATop))),
          child: Center(
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
                            padding: const EdgeInsets.fromLTRB(18, 230, 12, 12),
                            child: Column(
                              children: [
                              Container(

                              width: 240.0,
                              height: 140.0,
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.grey)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 18),
                                      child: Column( // Replace with a Row for horizontal icon + text
                                        children: <Widget>[
                                          Icon(Icons.history, size: 70.0, color: Colors.lightGreen),
                                          Text("Histórico",
                                            style: new TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black54,
                                            ),),
                                        ],
                                      ),
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => Historico_De_Venda()));
                                    } // ação ,
                                    ),
                              ),
                              ],
                            ),
                          ),
                    ),
                    Flexible(

                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 230, 18, 12),
                          child: Column(

                            children: [

                              Container(
                                width: 240.0,
                                height: 140.0,
                              //Image/bibiimagem.jpeg
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.grey)
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 25),
                                    child: Column( // Replace with a Row for horizontal icon + text
                                      children: <Widget>[
                                        Icon(Icons.inbox, size: 58.0, color: Colors.lightGreen),
                                        Text("Produto",
                                          style: new TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black54,
                                          ),)
                                      ],
                                    ),
                                  ),


                                  textColor: Colors.black,
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => prodhome.HomePage()));
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
                /*Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new SizedBox(
                    width: 360.0,
                    height: 120.0,
                    child: RaisedButton(
                      child: new Text("Produtos"),
                      textColor: Colors.black45,
                      color: Colors.lightBlueAccent,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => prodhome.HomePage()));
                      },
                    ),

                  ),
                ),*/
                /*Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new SizedBox(
                    width: 360.0,
                    height: 120.0,
                    child: RaisedButton(
                        child: new Text("Tabela de distribuição"),
                        textColor: Colors.purple,
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => distrihome.HomePage()));
                        }),
                  ),
                ),*/
                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new SizedBox(
                    width: 360.0,
                    height: 120.0,
                    // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: RaisedButton(
                        padding: new EdgeInsets.all(4.0),
                        child: new Text("Historico de Venda"),
                        textColor: Colors.white,
                        color: Colors.blueAccent,

                        onPressed: () {
                          //FirebaseAuth.instance.signOut();
                          //Navigator.pushNamed(context, LoginPage);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Historico_De_Venda()));
                        } // ação ,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
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
