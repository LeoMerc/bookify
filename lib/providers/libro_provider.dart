import 'dart:convert';

import 'package:bookify/classes/libro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class LibroProvider extends ChangeNotifier {
  String expositorName = '';
  List<Libro> libroLista = [];

  LibroProvider() {
    print('LibroProvider inicializado');

    this.getTemas();
  }

  getTemas() async {
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
}
