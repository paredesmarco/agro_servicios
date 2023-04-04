import 'package:flutter/material.dart';

import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

class CuerpoFormularioSinRegistros extends StatelessWidget {
  final String titulo;
  const CuerpoFormularioSinRegistros({Key? key, required this.titulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioIngreso(
      titulo: titulo,
      widgets: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.fileCircleExclamation,
                  color: Colors.grey.shade300,
                  size: 180,
                ),
                const Espaciador(alto: 15),
                const Text(
                  'No existen registros sincronizados',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
