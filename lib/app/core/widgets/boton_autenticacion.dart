import 'package:flutter/material.dart';

class BotonTipoAutenticacion extends StatelessWidget {
  final Icon? icono;
  final Function? funcion;
  final double? alto;
  final double? ancho;
  final Color? color;
  final double? sizeIcon;

  const BotonTipoAutenticacion(
      {Key? key,
      this.icono,
      this.funcion,
      this.alto,
      this.ancho,
      this.color,
      this.sizeIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ancho,
      height: alto,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.transparent,
            shape: CircleBorder(),
          ),
          child: IconButton(
            splashRadius: 25.0,
            icon: Icon(
              icono!.icon,
              color: color,
              size: sizeIcon,
            ),
            onPressed: funcion as void Function()?,
          ),
        ),
      ),
    );
  }
}
