library danielaVendas;

import 'package:daniela/models/contato.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:daniela/contato.dart' as d2;
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// VARIÁVEL DE CONTROLE (EDITAR/ADICIONAR PRODUTO)
bool varLibrary = true;
bool editarLibrary = false;

// VARIÁVEL DE CONTROLE PARA
bool boleano = false;

// VARIÁVEIS QUE RECEBERÃO OS DADOS DO FIREBASE
var mesLibrary;

var valorLibrary;

var nomeLibrary;

var idLibrary;

// DELETA O DOCUMENTO DO FIREBASE
void Vendadeletar(indice) {
  FirebaseFirestore.instance
      .collection("venda")
      .where("id", isEqualTo: indice)
      .get()
      .then((value) {
    value.docs.forEach((element) {
      FirebaseFirestore.instance
          .collection("venda")
          .doc(element.id)
          .delete()
          .then((value) {});
    });
  });
}

void Vendacriar(idLibrary) {
  FirebaseFirestore.instance.collection("venda").doc(nomeLibrary).set({
    'mes': mesLibrary,
    'valor': valorLibrary,
    'id': idLibrary,
    'nome': nomeLibrary,
    'mesFiltro': converteData(mesLibrary)
  });
}

void addVenda() {
  FirebaseFirestore.instance.collection("venda").doc(nomeLibrary).set({
    'mes': mesLibrary,
    'valor': valorLibrary,
    'id': idRandom(),
    'nome': nomeLibrary,
    'mesFiltro': converteData(mesLibrary)
  });
}

conditionalName(bool variable) {
  if (variable == true) {
    return 'Nova Venda';
  } else {
    return 'Editar Venda';
  }
}

idRandom() {
  // ID RANDÔMICO
  var uuid = Uuid();
  return uuid.v4();
}

external DateTime subtract(Duration duration);

dataFormat() {
  // DATA ATUAL
  var dtAtual = new DateTime.now();
  var dtFormat = new DateFormat('dd/MM/yyyy');
  String dataFormatada = dtFormat.format(dtAtual.toLocal());
  print(DateTime.now());
  return dataFormatada;
}

converteData (String variavel) {
  var converte1 = variavel.split("/");
  var converte2 = [converte1[2], converte1[1], converte1[0]];
  var converte3 = converte2.join("/");
  return converte3;
}
