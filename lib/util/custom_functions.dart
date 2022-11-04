
import 'package:flutter/material.dart';




Future<void> showAlertDialog({
  required BuildContext context,
  required void Function() onPressedContinue,
  String? alertMessage,
}) async {
  //Buttons
  Widget cancelButton = TextButton(
    child:
      Text('Cancelar')/* Cancelar */,
    
    onPressed: () => Navigator.pop(context),
  );
  Widget continueButton = TextButton(
    child:  Text('Continuar'),
    onPressed: () async {
      onPressedContinue();
                              Navigator.pop(context);

    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title:  Text('Alerta'),
    content:  Text('Seguro que desea continuar?'),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
