import 'package:bookify/providers/libro_provider.dart';
import 'package:bookify/screens/details_screen.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final libroProvider = Provider.of<LibroProvider>(context);

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      // color: Colors.red,
      child: Swiper(
        itemCount: libroProvider.libroLista.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.60,
        itemHeight: size.height * 0.45,
        itemBuilder: (_, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(libro: libroProvider.libroLista[index],),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'),
                  image: NetworkImage(
                    'https://wild-paper-5941.fly.dev/api/files/books/${libroProvider.libroLista[index].id}/${libroProvider.libroLista[index].img}',
                  ),
                  fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
