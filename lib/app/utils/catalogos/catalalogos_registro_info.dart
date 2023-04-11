import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:flutter/material.dart';

class CatalogoRegistroInfo {
  final _provincia = [
    LocalizacionModelo(idGuia: 1, nombre: 'AZUAY'),
    LocalizacionModelo(idGuia: 2, nombre: 'BOLIVAR'),
    LocalizacionModelo(idGuia: 2, nombre: 'CAÑAR'),
  ];

  final _canton = [
    LocalizacionModelo(idGuia: 1, nombre: 'CUENCA'),
    LocalizacionModelo(idGuia: 2, nombre: 'GUALACEO'),
    LocalizacionModelo(idGuia: 2, nombre: 'PAUTE'),
  ];

  final _parroquia = [
    LocalizacionModelo(idGuia: 1, nombre: 'BELLAVISTA'),
    LocalizacionModelo(idGuia: 2, nombre: 'EL VECINO'),
    LocalizacionModelo(idGuia: 2, nombre: 'MONAY'),
  ];

  final _origenMuestra = [
    'NO APLICA',
    'FINCAS/UPAS',
    'MEDIOS DE TRANSPORTE',
    'CENTROS DE ACOPIO ',
    'INDUSTRIA LÁCTEA (SILOS DE RECEPCIÓN)',
    'CENTRO DE FAENAMIENTO ',
  ];

  final _producto = [
    'NO APLICA',
    'LECHUGA',
    'CILANTRO',
    'AJO',
    'CEBOLLA',
  ];

  final _programa = [
    'NO APLICA',
    'C.- PROGRAMA NACIONAL DE VIGILANCIA Y CONTROL DE RESIDUOS DE MEDICAMENTOS VETERINARIOS.'
  ];

  final _tipoMuestra = [
    'NO APLICA',
    'VIGILANCIA',
    'CONTROL',
    'CONTROL REDUCIDO',
    'CONTROL ESTRICTO'
  ];

  List<DropdownMenuItem<String>> getProducto() {
    // Utilizado en el Combo
    List<DropdownMenuItem<String>> items = [];
    for (String item in _producto) {
      items.add(new DropdownMenuItem(value: item, child: new Text(item)));
    }
    return items;
  }

  List<String> getProductoLista() {
    // Utilizado en el ComboBusqueda
    return _producto;
  }

  List getProvinciaLista() {
    return _provincia;
  }

  List getCantonLista() {
    return _canton;
  }

  List getParroquiaLista() {
    return _parroquia;
  }

  List<DropdownMenuItem<String>> getPrograma() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _programa) {
      items.add(new DropdownMenuItem(value: item, child: new Text(item)));
    }
    return items;
  }

  List<String> getProgramaLista() {
    return _programa;
  }

  List<DropdownMenuItem<String>> getOrigenMuestra() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _origenMuestra) {
      items.add(new DropdownMenuItem(value: item, child: new Text(item)));
    }
    return items;
  }

  List<String> getOrigenMuestraLista() {
    return _origenMuestra;
  }

  List<String> getTipoMuestraLista() {
    return _tipoMuestra;
  }

  List<DropdownMenuItem<String>> getTipoMuestra() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _tipoMuestra) {
      items.add(new DropdownMenuItem(value: item, child: new Text(item)));
    }
    return items;
  }
}
