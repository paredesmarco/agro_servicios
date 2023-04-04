import 'package:flutter/material.dart';

class CatalogosLaboratorios {
  final _tipoMuestra = [
    'Raíz',
    'Ramas',
    'Tubérculos',
    'Bulbos',
    'Flores',
    'Cormos',
    'Frutas',
    'Tallos',
    'Granos',
    'Hojas',
    'Brotes',
    'Semilla',
    'Planta',
    'Suelo',
    'Trampa insectos en alcohol',
    'Varios',
  ];

  final _aplicacionQuimico = [
    'Si',
    'No',
    'No aplica',
  ];

  final _conservacionMuestra = [
    'Natural',
    'Refrigerada',
    'Envase',
    'Etiquetado',
  ];

  List<DropdownMenuItem<String>> getTipoMuestra() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _tipoMuestra) {
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

  List<DropdownMenuItem<String>> getConservacionMuestraDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _conservacionMuestra) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }
}
