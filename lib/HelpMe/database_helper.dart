import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:core';
import 'package:daniela/models/contato.dart';


class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String contatoTable = 'contato';
  String colId = 'id';
  String colNome = 'nome';
  String colHT = 'HT';
  String colLE = 'LE';
  String colVL = 'VL';
  String colES = 'ES';
  String colVA = 'VA';
  String colTEC = 'TEC';
  String colELA = 'ELA';

  List<Contato> hists = List<Contato>();

  DatabaseHelper._createInstance();

  factory DatabaseHelper(){

    if (_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if (_database == null){
      _database = await initializeDatabase();

    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contatos.db';

    var contatosDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return contatosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $contatoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colNome TEXT,$colHT TEXT, $colLE DOUBLE, $colVL DOUBLE, $colES int, $colVA DOUBLE, $colTEC TEXT, $colELA  TEXT)');
    await db.execute('CREATE TABLE Tabela_De_Distribuicao(id INTEGER PRIMARY KEY AUTOINCREMENT,mes TEXT,caixa DOUBLE, markup DOUBLE, TotVendas DOUBLE, Producao DOUBLE)');
    await db.execute('CREATE TABLE HIST($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colNome TEXT,$colHT TEXT, $colLE DOUBLE, $colVL DOUBLE, $colES int, $colVA DOUBLE, $colTEC TEXT, $colELA  TEXT)');
  }
  Future<int> insertContato(Contato contato) async {

    Database db = await this.database;
    var resul2 = await db.insert('HIST', contato.toMap());
    var resultado = await db.insert(contatoTable, contato.toMap());

    return resultado;
  }

  Future<Contato> getContato(int id) async {
    Database db = await this.database;

    List<Map> maps = await db.query(contatoTable,
        columns: [colId, colNome, colHT, colLE, colVL, colES, colVA, colTEC, colELA],
        where: "$colId = ?",
        whereArgs: [id] );

    if(maps.length > 0){
      return Contato.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<List<Contato>> getContatos() async {
    Database db = await this.database;

    var resultado = await db.query(contatoTable);

    List<Contato> lista = resultado.isNotEmpty ? resultado.map(
            (c) => Contato.fromMap(c)).toList() : [];
    return lista;

  }

  Future<List<Contato>> getContatos2() async {
    Database db = await this.database;

    var resultado = await db.query('HIST');

    List<Contato> lista = resultado.isNotEmpty ? resultado.map(
            (c) => Contato.fromMap(c)).toList() : [];
    return lista;

  }



  Future<int> updateContato(Contato contato) async {
      var db = await this.database;
      Contato d = contato;


      var resultado =
      await db.update(contatoTable, contato.toMap(),
          where: '$colId = ?',
          whereArgs: [contato.id]);


      await getContatos2().then((lista) {

        hists = lista.cast<Contato>();
        debugPrint('kill me');
      });

      d.id = null;
      var test = 0;
      for(var id = (hists.length - 1);test != 1;id--){


        if(hists[id].nome == contato.nome) {
          var dude = contato.ES - hists[id].ES;
          d.ES = dude;
          //d.VL = contato.VL;
          //d.VL = d.VL * d.ES;
          debugPrint('kill me 2v');
          var test = 1;
        }
        if(id == 0){
          test = 1;
        }
      }
      var resul2 = await db.insert('HIST', d.toMap());


    return resultado;
  }



  //Deletar um objeto Contato do banco de dados
  Future<int> deleteContato(int id) async {
    var db = await this.database;

    int resultado =
    await db.delete(contatoTable,
        where: "$colId = ?",
        whereArgs: [id]);

    return resultado;
  }

//Obtem o número de objetos contato no banco de dados
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $contatoTable');

    int resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }

}