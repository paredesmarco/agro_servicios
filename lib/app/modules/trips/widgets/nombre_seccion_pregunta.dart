import 'package:flutter/material.dart';

class NombreSeccionPregunta extends StatelessWidget {
  final String etiqueta;

  const NombreSeccionPregunta({Key? key, required this.etiqueta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      // decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          etiqueta,
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
