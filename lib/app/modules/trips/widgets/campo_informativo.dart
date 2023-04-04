import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CampoInformativo extends StatelessWidget {
  final String etiqueta;
  final String valor;
  final String errorText;

  const CampoInformativo(
      {Key? key,
      required this.etiqueta,
      required this.valor,
      required this.errorText})
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
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 11, bottom: 11, right: 10),
            child: Text(
              valor,
              style: const TextStyle(color: Color(0xFF75808f)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 10),
          child: Text(errorText.toString(),
              style: const TextStyle(fontSize: 12, color: Colors.red)),
        ),
      ],
    );
  }
}
