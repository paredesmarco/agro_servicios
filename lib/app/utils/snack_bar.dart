import 'package:flutter/material.dart';

/// Permite mostrar un [SnackBar] en cualquier nodo del árbol de widgets
///
/// El parámetro context es utilizaco para saber en que nodo se debe mostrar el [SnackBar]
void snackBarExterno({
  required String mensaje,
  required BuildContext context,
  SnackBarBehavior? snackBarBehavior,
  double? elevation,
  EdgeInsets? margin,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: snackBarBehavior,
      elevation: elevation,
      margin: margin,
      content: Text(mensaje),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    ),
  );
}
