import 'package:flutter/material.dart';

import 'package:agro_servicios/app/core/widgets/widgets.dart';

class CampoDescripcion extends StatelessWidget {
  final String etiqueta;
  final String? valor;
  final Espaciador? separacion;
  const CampoDescripcion(
      {Key? key, required this.etiqueta, this.valor, this.separacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              etiqueta,
              style: TextStyle(fontSize: 13, color: Colors.grey[500]),
            ),
          ),
          if (separacion != null) separacion!,
          Visibility(
            visible: (valor != null),
            child: Text(
              '$valor',
              style: const TextStyle(
                color: Color(0xFF75808f),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
