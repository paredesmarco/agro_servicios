import 'package:flutter/material.dart';

class BotonIcon extends StatelessWidget {
  final ancho;
  final String? texto;
  final Color? backgraund;
  final Color? color;
  final Icon? icono;
  final Function? onPressedd;

  const BotonIcon(
      {Key? key,
      this.ancho,
      this.texto,
      this.backgraund,
      this.color,
      this.onPressedd,
      this.icono})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      // decoration: const ShapeDecoration(
      //   gradient: LinearGradient(
      //     colors: [Color(0xFFF0099393), Color(0xFFF1f5971)],
      //   ),
      //   shape: CircleBorder(),
      // ),
      child: IconButton(
        icon: Icon(icono!.icon),
        color: Colors.white,
        onPressed: () {
          onPressedd!();
        },
      ),
    );
  }
}
