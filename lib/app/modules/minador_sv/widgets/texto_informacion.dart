import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TextoInformacion extends StatelessWidget {
  final String etiqueta;
  final String? contenido;
  const TextoInformacion({Key? key, required this.etiqueta, this.contenido})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Text.rich(
            TextSpan(
              text: '$etiqueta ',
              style: EstilosTextos.textoEtiquetasInfo,
              children: <InlineSpan>[
                TextSpan(
                  text: '$contenido',
                  style: EstilosTextos.textoDescripcionInfo,
                )
              ],
            ),
          ),
        ),
        const Espaciador(
          alto: 5,
        )
      ],
    );
  }
}
