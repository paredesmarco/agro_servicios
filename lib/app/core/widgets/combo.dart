import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

typedef OnchangeCallback = Function(dynamic valor);
typedef OnsaveCallback = Function(dynamic valor);
typedef ValidatorCallback = String? Function(dynamic valor);

class Combo extends StatelessWidget {
  final Object? value;
  final List<DropdownMenuItem<Object>>? items;
  final String label;
  final String? errorText;
  final bool enabled;
  final OnchangeCallback onChanged;
  final OnsaveCallback? onSaved;
  final ValidatorCallback? validator;

  const Combo(
      {Key? key,
      this.value,
      required this.items,
      required this.label,
      required this.onChanged,
      this.onSaved,
      this.errorText,
      this.enabled = true,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Espaciador(alto: 8),
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[500])),
        DropdownButtonFormField(
          isExpanded: true,
          key: key,
          value: value,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF75808f),
          ),
          hint: const Text('--'),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          items: items,
          onChanged: enabled ? onChanged : null,
          onSaved: (valor) {
            onSaved!(valor);
          },
          validator: validator,
          decoration: _buildDecoracionCombo(),
          style: const TextStyle(color: Color(0xFF75808f)),
        ),
      ],
    );
  }

  _buildDecoracionCombo() {
    return InputDecoration(
      errorText: errorText,
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFDFDFDF)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: const EdgeInsets.all(10),
    );
  }
}
