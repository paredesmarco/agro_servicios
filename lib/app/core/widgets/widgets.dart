import 'package:flutter/material.dart';

class Espaciador extends StatelessWidget {
  final double? alto;
  final double? ancho;

  const Espaciador({Key? key, this.alto, this.ancho}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: alto ?? 0, width: ancho ?? 0);
  }
}

class IconoFlechaCombos extends StatelessWidget {
  const IconoFlechaCombos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.keyboard_arrow_down,
      color: Color(0xFF75808f),
    );
  }
}
