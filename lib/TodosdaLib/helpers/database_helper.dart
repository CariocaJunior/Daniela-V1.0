import 'dart:async';
import 'dart:io';
import 'package:daniela/TodosdaLib/models/contato.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:core';



class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String contatoTable = 'Tabela_De_Distribuicao';
  String colId = 'id';
  String colMes = 'mes';
  String colCaixa = 'caixa';
  String colMarkup = 'markup';
  String colTotVendas= 'TotVendas';
  String colProducao = 'Producao';

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
      await db.execute('CREATE TABLE $contatoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colMes TEXT,$colCaixa DOUBLE, $colMarkup DOUBLE, $colTotVendas DOUBLE, $colProducao DOUBLE)');
      await db.execute('CREATE TABLE contato(id INTEGER PRIMARY KEY AUTOINCREMENT,nome TEXT,HT TEXT, LE DOUBLE, VL DOUBLE, ES int, VA DOUBLE, TEC TEXT, ELA  TEXT)');
      await db.execute('CREATE TABLE HIST(id INTEGER PRIMARY KEY AUTOINCREMENT,nome TEXT,HT TEXT, LE DOUBLE, VL DOUBLE, ES int, VA DOUBLE, TEC TEXT, ELA  TEXT)');
    }
    Future<int> insertContato(Contato contato) async {

      Database db = await this.database;

      var resultado = await db.insert(contatoTable, contato.toMap());

      return resultado;
    }

    Future<Contato> getContato(int id) async {
      Database db = await this.database;

      List<Map> maps = await db.query(contatoTable,
      columns: [colId, colMes, colCaixa, colMarkup, colTotVendas, colProducao],
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


  Future<int> updateContato(Contato contato) async {
    var db = await this.database;

    var resultado =
    await db.update(contatoTable, contato.toMap(),
        where: '$colId = ?',
        whereArgs: [contato.id]);

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