import 'package:flutter/material.dart';

class CatalogosProductosImportados {
  final _criterioDivisionEspecies = [
    'Por especie',
    'Por variedad',
    'Por bodegas (granos)',
    'Por unidad de transporte',
  ];

  final _categoriaRiesgo = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  final _tipoCliente = ['Interno', 'Externo'];

  final _activdadOrigen = ['Vigilancia fitosanitaria', 'Cuarentena'];

  List<DropdownMenuItem<String>> getCriterioDivisionEspecie() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _criterioDivisionEspecies) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getCategoriaRiesgo() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _categoriaRiesgo) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getTipoCliente() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _tipoCliente) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getActividadOrigen() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _activdadOrigen) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }
}
