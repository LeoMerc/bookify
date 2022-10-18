import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {

final Widget child;

  const CardContainer({super.key, required this.child}); 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: _createCardShape(),
        child: this.child,
      ),
    );
  }

  BoxDecoration _createCardShape() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
        color: Colors.black12,
        blurRadius: 15,  
        offset: Offset(0,5)
        )
      ]
    );
  }
}