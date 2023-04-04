import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CampoDescripcionBorde extends StatelessWidget {
  final String etiqueta;
  final String valor;
  const CampoDescripcionBorde(
      {Key? key, required this.etiqueta, required this.valor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 10),
        Text(etiqueta, style: TextStyle(fontSize: 13, color: Colors.grey[500])),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFDFDFDF)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8, top: 8, bottom: 10, right: 10),
            child: Text(
              valor,
              style: const TextStyle(color: Color(0xFF75808f), fontSize: 16),
            ),
          ),
        ),
        const Espaciador(alto: 8),
      ],
    );
  }
}
