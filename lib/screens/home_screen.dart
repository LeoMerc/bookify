import 'package:bookify/screens/add_book_screen.dart';
import 'package:bookify/widgets/book_slider_fisica.dart';
import 'package:bookify/widgets/book_slider_matematicas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/libro_provider.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LibroProvider libroProvider =
        Provider.of<LibroProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libros'),
        elevation: 0,
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Busqueda(libroProvider: libroProvider),
            CardSwiper(),
            BookSliderProgramming(),
            BookSliderMatematicas(),
            BookSliderFisica(),
          ],
        ),
      ),
      floatingActionButton: libroProvider.isAdmin
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddBookScreen(),
                  ),
                );
              },
              backgroundColor: const Color.fromARGB(255, 136, 88, 218),
              elevation: 8,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 45,
              ),
            )
          : Container(),
    );
  }
}

class Busqueda extends StatelessWidget {
  const Busqueda({
    Key? key,
    required this.libroProvider,
  }) : super(key: key);

  final LibroProvider libroProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
      child: TextFormField(
        controller: libroProvider.searchFieldController,
        onChanged: (_) {
          libroProvider.searchText();
        },
        obscureText: false,
      ),
    );
  }
}
