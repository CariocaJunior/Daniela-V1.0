import 'dart:ffi';
import 'package:flutter/material.dart';

//Ver se ainda é util

class Contato {
  int id;
  String nome;
  double VA;
  int ES;

  //variable for time

  Contato(this.id, this.nome, this.VA, this.ES);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'id': id, 'nome': nome, 'VA': VA, 'ES': ES};
    return map;
  }

  Contato.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    VA = map['VA'];
    ES = map['ES'];
  }
}
