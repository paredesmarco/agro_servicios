import 'package:flutter/material.dart';

class CatalogosEmbalajeControlSv {
  final _identidadEmbalaje = [
    'Palets',
    'Caja',
    'Madera de estiba',
    'Jaula',
    'Bobina',
    'Otro',
  ];

  final _tipoCliente = [
    'Interno',
    'Externo',
  ];

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
    'Trampa',
    'Varios',
  ];

  final _conservacion = [
    'Natural',
    'Refrigerada',
    'Envase apropiado',
    'Etiquetado',
    'Colocar en alcohol',
  ];

  final _actividad = [
    'Vigilancia fitosanitaria',
    'Cuarentena',
    'Inspección en Punto de Control – Importaciones',
  ];

  // final _aplicacionQuimico = ['Si', 'No', 'No aplica'];

  // List<String> getIdentidadEmbalaje() {
  //   return _identidadEmbalaje;
  // }

  List<DropdownMenuItem<String>> getIdentidadEmbalaje() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _identidadEmbalaje) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getTipocliente() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _tipoCliente) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getTipoMuestra() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _tipoMuestra) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getConservacion() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _conservacion) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getActividad() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _actividad) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }
}
