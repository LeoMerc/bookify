import 'package:bookify/screens/add_book_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libros'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(),
            BookSliderProgramming(),
            BookSliderProgramming(),
            BookSliderProgramming(),
            BookSliderProgramming(),
            BookSliderProgramming(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  AddBookScreen(),
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 136, 88, 218),
        elevation: 8,
        child: Icon( 
          Icons.add,
          color: Colors.white,
          size: 45,
        ),
      ),
    );
  }
}
