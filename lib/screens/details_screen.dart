import 'package:bookify/classes/libro.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key, required this.libro}) : super(key: key);
  final Libro libro;
  @override
  Widget build(BuildContext context) {
    //ToDo: Get the book instance from the arguments

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            libro: libro,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _BookAndTitle(
                  libro: libro,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({ required this.libro});
  final Libro libro;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          child: Text(
            libro.name,
            style: TextStyle(fontSize: 20),
          ),
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(
              'http://10.0.2.2:8090/api/files/books/${libro.id}/${libro.img}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _BookAndTitle extends StatelessWidget {
  final Libro libro;

  const _BookAndTitle({ required this.libro});
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'),
                image: NetworkImage(
                    'http://10.0.2.2:8090/api/files/books/${libro.id}/${libro.img}'),
                height: 150,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              libro.name,
              style: TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              libro.author,
              style: TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              libro.genre,
              style: TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              libro.link.toString(),
              style: TextStyle(fontSize: 15),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
