import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child}); 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),

          IconPerson(),

          child,
        ],
      ),
    );
  }
}

class IconPerson extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top:30),
        width: double.infinity,
        child: Icon(Icons.person_pin, color: Colors.white, size: 100,),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * .4,
      decoration: _buildPurpleBackground(),
      child: Stack(children: [
        Positioned(child: _Bubble(),
        top: 90,
        left: 30,),
          Positioned(child: _Bubble(),
        top: 10,
        left: 280,),
          Positioned(child: _Bubble(),
        top: 100,
        left: 170,),
          Positioned(child: _Bubble(),
        top: -40,
        left: 30,),
          Positioned(child: _Bubble(),
        bottom: -50,
        left: 120,),

              Positioned(child: _Bubble(),
        bottom: 0,
        right: 0,),
      ],
      ),
    );
  }

  BoxDecoration _buildPurpleBackground() => BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromRGBO(63, 63, 156, 1),
          Color.fromRGBO(90, 70, 178, 1)
        ],
      ));
}

class _Bubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
      color: Color.fromRGBO(255, 255, 255, 0.05)),
    ); 
  }
}