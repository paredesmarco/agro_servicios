import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnSaveCallback = Function(dynamic valor);
typedef OnchangeCallback = Function(dynamic valor);
typedef ValidatorCallback = String? Function(dynamic valor);

class CampoTexto extends StatelessWidget {
  final String label;
  final String? errorText;
  final OnSaveCallback? onSaved;
  final OnchangeCallback onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool enable;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final List<TextInputFormatter>? textInputFormatter;
  final int maxLength;
  final ValidatorCallback? validator;
  final double? margin;
  final TextCapitalization? textCapitalization;
  final String? initialValue;

  const CampoTexto({
    Key? key,
    required this.onChanged,
    this.onSaved,
    required this.label,
    this.errorText,
    this.controller,
    this.keyboardType,
    this.enable = true,
    this.readOnly = false,
    this.enableInteractiveSelection = true,
    this.textInputFormatter,
    required this.maxLength,
    this.validator,
    this.margin,
    this.initialValue,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: margin ?? 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[500], fontSize: 13),
          ),
          TextFormField(
            initialValue: initialValue,
            textCapitalization: textCapitalization!,
            maxLength: maxLength,
            validator: validator,
            inputFormatters: textInputFormatter,
            readOnly: readOnly,
            keyboardType: keyboardType,
            enabled: enable,
            controller: controller,
            cursorColor: const Color(0xff39675e),
            textInputAction: TextInputAction.next,
            enableInteractiveSelection: enableInteractiveSelection,
            onSaved: (String? valor) {
              onSaved!(valor);
            },
            onChanged: (String valor) {
              onChanged(valor);
            },
            style: const TextStyle(color: Color(0xFF75808f)),
            decoration: _buildDecoracionInput(),
          ),
        ],
      ),
    );
  }

  _buildDecoracionInput() {
    return InputDecoration(
      counter: const Offstage(),
      errorText: errorText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFDFDFDF)),
        borderRadius: BorderRadius.circular(5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFDFDFDF)),
        borderRadius: BorderRadius.circular(5.0),
      ),
      labelStyle: const TextStyle(color: Color(0xFFDFDFDF)),
      isDense: true,
      contentPadding:
          const EdgeInsets.only(top: 10, bottom: 10, left: 9, right: 9),
    );
  }
}
