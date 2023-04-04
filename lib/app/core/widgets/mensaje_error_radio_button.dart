import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MensajeErrorRadioButton extends StatelessWidget {
  const MensajeErrorRadioButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Espaciador(ancho: 10),
        Text('Seleccione una opción',
            style: TextStyle(color: Colors.red[700], fontSize: 12)),
      ],
    );
  }
}
