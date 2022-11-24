import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../providers/libro_provider.dart';
import '../screens/details_screen.dart';

class BookSliderProgramming extends StatefulWidget {
  const BookSliderProgramming({Key? key}) : super(key: key);

  @override
  State<BookSliderProgramming> createState() => _BookSliderProgrammingState();
}

class _BookSliderProgrammingState extends State<BookSliderProgramming> {
  @override
  Widget build(BuildContext context) {
    final libroProvider = Provider.of<LibroProvider>(context);

    return Container(
      width: double.infinity,
      height: 275,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Programacion',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: libroProvider.libroLista.length,
              itemBuilder: (_, int index) => libroProvider.libroLista[index].genre == 'Programacion' ? _BookPoster(index: index,) : Container(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookPoster extends StatelessWidget {
  final index;

  const _BookPoster({required this.index});
  @override
  Widget build(BuildContext context) {
    final libroProvider = Provider.of<LibroProvider>(context);

    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(libro: libroProvider.libroLista[index],),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                // height: 185,
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(
                  'https://wild-paper-5941.fly.dev/api/files/books/${libroProvider.libroLista[index].id}/${libroProvider.libroLista[index].img}',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            libroProvider.libroLista[index].name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
