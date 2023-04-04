import 'package:flutter/material.dart';

class CatalogosMuestreoMfSv {
  final _sitioMuestreo = [
    'Suelo',
    'Árbol',
  ];

  final _aplicacionQuimico = ['Si', 'No', 'No aplica'];

  List<String> getSitioMuestreo() {
    return _sitioMuestreo;
  }

  List<DropdownMenuItem<String>> getSitioMuestreoDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _sitioMuestreo) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getProductoQuimicoDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _aplicacionQuimico) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }
}
