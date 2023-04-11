import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnSaveCallback = Function(dynamic valor);
typedef OnchangeCallback = Function(dynamic valor);
typedef ValidatorCallback = String? Function(dynamic valor);

class CampoFecha extends StatelessWidget {
  final String label;
  final DateTime date;
  final String? errorText;
  final OnSaveCallback? onSaved;
  final OnchangeCallback onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool enable;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final List<TextInputFormatter>? textInputFormatter;
  final int? maxLength;
  final ValidatorCallback? validator;
  final double? margin;
  final TextCapitalization? textCapitalization;
  final String? initialValue;

  const CampoFecha({
    Key? key,
    required this.date,
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
    this.maxLength,
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
            validator: validator ?? null,
            inputFormatters: textInputFormatter,
            readOnly: readOnly,
            keyboardType: keyboardType,
            enabled: enable,
            controller: controller,
            cursorColor: Color(0XFFF39675E),
            textInputAction: TextInputAction.next,
            enableInteractiveSelection: enableInteractiveSelection,
            onSaved: (String? valor) {
              onSaved!(valor);
            },
            onChanged: (String valor) {
              onChanged(valor);
            },
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2122))
                  .then((date) => {onChanged(date)});
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            style: TextStyle(color: Color(0xFF75808f)),
            decoration: _buildDecoracionInput(),
          ),
        ],
      ),
    );
  }

  _buildDecoracionInput() {
    return InputDecoration(
      counter: Offstage(),
      errorText: errorText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFDFDFDF)),
        borderRadius: BorderRadius.circular(5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFDFDFDF)),
        borderRadius: BorderRadius.circular(5.0),
      ),
      labelStyle: new TextStyle(color: Color(0xFFDFDFDF)),
      isDense: true,
      contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 9, right: 9),
    );
  }
}
