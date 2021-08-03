import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:core';
import 'package:daniela/models/contato.dart';

class DatabaseHelper {
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
  String colTECQTD = 'TECQTD';
  String colTECCUS = 'TECCUS';
  String colELAQTD = 'ELAQTD';
  String colELACUS = 'ELACUS';
  String colDT = 'DT';

  List<Contato> hists = List<Contato>();

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contatos.db';

    var contatosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return contatosDatabase;
  }

  //Provael que ira ser apagado
  void _createDb(Database db, int newVersion) async {}

  //Usando
  Future<int> insertContato(Contato contato) async {
    //Database db = await this.database;
    FirebaseFirestore.instance.collection('pedido').doc(contato.nome).set({
      colId: contato.id,
      colNome: contato.nome,
      colHT: contato.HT,
      colLE: contato.LE,
      colVL: contato.VL,
      colES: contato.ES,
      colTECQTD: contato.TECQTD,
      colTECCUS: contato.TECCUS,
      colELAQTD: contato.ELAQTD,
      colELACUS: contato.ELACUS,
      colDT: contato.DT
    });
  }

  //Inutil?
  Future<Contato> getContato(int id) async {
    Database db = await this.database;

    List<Map> maps = await db.query(contatoTable,
        columns: [
          colId,
          colNome,
          colHT,
          colLE,
          colVL,
          colES,
          colVA,
          colTECQTD,
          colTECCUS,
          colELAQTD,
          colELACUS,
          colDT
        ],
        where: "$colId = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Contato.fromMap(maps.first);
    } else {
      return null;
    }
  }

  //Este é usado no home_page
  Future<List<Contato>> getContatos() async {
    Database db = await this.database;

    var resultado = await db.query(contatoTable);

    List<Contato> lista = resultado.isNotEmpty
        ? resultado.map((c) => Contato.fromMap(c)).toList()
        : [];
    return lista;
  }

  Future<List<Contato>> getContatos2() async {
    //List<Contato> lista = resultado.toObject(UserDocument).users;

    // List<Contato> lista = resultado.isNotEmpty ? resultado.map(
    //         (c) => Contato.fromMap(c)).toList() : [];
    // print(lista);
    // return lista;
    return null;
  }

//Atualizar o contato
  Future<int> updateContato(Contato contato) async {
    var db = await this.database;
    Contato d = contato;

    var resultado = await db.update(contatoTable, contato.toMap(),
        where: '$colId = ?', whereArgs: [contato.id]);

    await getContatos2().then((lista) {
      hists = lista.cast<Contato>();
      debugPrint('kill me');
    });

    d.id = null;
    var test = 0;
    for (var id = (hists.length - 1); test != 1; id--) {
      if (hists[id].nome == contato.nome) {
        var dude = contato.ES - hists[id].ES;
        d.ES = dude;
        debugPrint('kill me 2v');
      }
      if (id == 0) {
        test = 1;
      }
    }

    return resultado;
  }

  //Deletar um objeto Contato do banco de dados
  Future<int> deleteContato(int id) async {
    var db = await this.database;

    int resultado =
        await db.delete(contatoTable, where: "$colId = ?", whereArgs: [id]);

    return resultado;
  }

//Obtem o número de objetos contato no banco de dados
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $contatoTable');

    int resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

//Fechar a conecção com o banco
  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
