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
      
      body: SingleChildScrollView(
        child: Column(

          children:  [
            
              TextFormField(
                          controller: libroProvider.searchFieldController,
                          onChanged: (_) {
                            libroProvider.searchText();
                          },
                          obscureText: false,
                          
                        ),
            
            CardSwiper(),
            BookSliderProgramming(),
            BookSliderMatematicas(),
            BookSliderFisica(),

          ],
        ),
      ),
    floatingActionButton:   libroProvider.isAdmin ? FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const AddBookScreen(),
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
      ) : Container(),
    );
  }
}
