import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Preguntas extends StatelessWidget {
  final String label;
  final String? groupValue;
  final bool? error;
  final Function(dynamic valor) onChangedTexto;
  final Function(dynamic valor) onChangedRadio1;
  final Function(dynamic valor) onChangedRadio2;
  const Preguntas({
    Key? key,
    required this.label,
    required this.onChangedTexto,
    this.groupValue,
    required this.onChangedRadio1,
    required this.onChangedRadio2,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: _labelStyle(),
          ),
          Row(
            children: [
              SizedBox(
                height: 35,
                child: Radio(
                  value: 'Si',
                  groupValue: groupValue,
                  onChanged: (valor) {
                    onChangedRadio1(valor);
                  },
                ),
              ),
              const Text('Si', style: TextStyle(color: Color(0xFF75808f))),
              SizedBox(
                height: 35,
                child: Radio(
                  value: 'No',
                  groupValue: groupValue,
                  onChanged: (valor) {
                    onChangedRadio2(valor);
                  },
                ),
              ),
              const Text('No', style: TextStyle(color: Color(0xFF75808f))),
              if (error == true) const MensajeErrorRadioButton(),
            ],
          ),
          CampoTexto(
              maxLength: 150,
              margin: 0,
              onChanged: (valor) {
                onChangedTexto(valor);
              },
              label: 'Observación'),
        ],
      ),
    );
  }

  TextStyle _labelStyle() {
    return TextStyle(fontSize: 13, color: Colors.grey[500]);
  }
}

class MensajeErrorRadioButton extends StatelessWidget {
  const MensajeErrorRadioButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Espaciador(
          ancho: 10,
        ),
        Text('Seleccione una opción',
            style: TextStyle(color: Colors.red[700], fontSize: 12)),
      ],
    );
  }
}
