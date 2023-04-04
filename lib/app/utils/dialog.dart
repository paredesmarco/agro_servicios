import 'package:flutter/material.dart';

void dialogExterno(
    {required String mensaje,
    required context,
    String titulo = 'No se puede obtener tu ubicación actual'}) {
  // if (Theme.of(context).platform == TargetPlatform.android) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(mensaje),
        actions: <Widget>[
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      );
    },
  );
  // }
}
