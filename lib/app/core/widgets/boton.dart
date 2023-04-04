import 'package:flutter/material.dart';

import 'package:agro_servicios/app/utils/medidas.dart';

class Boton extends StatelessWidget {
  final String texto;
  final Color color;
  final Color? colorTexto;
  final VoidCallback funcion;
  final Icon? icono;
  final double? alto;
  final double? ancho;

  const Boton(
      {Key? key,
      required this.texto,
      required this.color,
      required this.funcion,
      this.icono,
      this.colorTexto,
      this.alto,
      this.ancho})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return SizedBox(
      height: alto ?? 32,
      width: ancho ?? anchoPantalla * 0.9,
      child: boton(),
    );
  }

  Widget boton() {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
      onPressed: funcion,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            texto,
            style: TextStyle(fontSize: 14, color: colorTexto ?? Colors.white),
          ),
          if (icono != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  width: 20,
                ),
                icono ?? Container(),
              ],
            )
        ],
      ),
    );
  }
}
