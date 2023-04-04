import 'package:agro_servicios/app/common/colores.dart';
import 'package:flutter/material.dart';

class NombreSeccion extends StatelessWidget {
  final String etiqueta;

  const NombreSeccion({Key? key, required this.etiqueta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      // decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Text(
            etiqueta,
            style:
                const TextStyle(color: Colores.TituloFormulario, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
