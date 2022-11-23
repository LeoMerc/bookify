import 'dart:convert';

import 'package:bookify/classes/libro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class LibroProvider extends ChangeNotifier {
  String expositorName = '';
  List<Libro> libroLista = [];
  bool isAdmin = false;
  late TextEditingController searchFieldController;
  LibroProvider() {
    print('LibroProvider inicializado');
    searchFieldController = TextEditingController();
    getTemas();
  }

   Future<void> getTemas() async {
    final res = await client.records.getFullList(
      'books',
    );

    libroLista = res.map(
      (e) {
        e.data['id'] = e.id;
        return Libro.fromJson(jsonEncode(e.data));
      },
    ).toList();


    notifyListeners();
  }

  String removeDiacritics(String str) {
    var withDia =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutDia =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }

    return str;
  }

  void searchText() {
    
    if (searchFieldController.text != '') {
      libroLista.removeWhere((element) {
        final nombreEvento = removeDiacritics(element.name).toLowerCase();

        final tempBusqueda =
            removeDiacritics(searchFieldController.text).toLowerCase();
        print('$nombreEvento ....... $tempBusqueda');
        if (nombreEvento.contains(tempBusqueda)) {
          return false;
        }
        return true;
      });
    } else {
      getTemas();
    }
    notifyListeners();
  }
}
