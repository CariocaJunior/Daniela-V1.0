import 'dart:ffi';
import 'package:flutter/material.dart';
class Contato{
  int id;
  String nome;
  String HT;
  double LE;
  double VL;
  int ES;
  double VA;
  String TEC;
  String ELA;



  Contato(this.id, this.nome, this.HT, this.LE, this.VL, this.ES, this.VA, this.TEC, this.ELA);

  Map<String,dynamic> toMap () {

    var map = <String,dynamic> {
      'id': id,
      'nome': nome,
      'HT': HT,
      'LE': LE,
      'VL': VL,
      'ES': ES,
      'VA': VA,
      'TEC': TEC,
      'ELA': ELA

    };
    return map;
  }

  Contato.fromMap(Map<String,dynamic> map){
    id = map['id'];
    nome = map['nome'];
    HT = map['HT'];
    LE = map['LE'];
    VL = map['VL'];
    ES = map['ES'];
    VA = map['VA'];
    TEC = map['TEC'];
    ELA = map['ELA'];
  }
}