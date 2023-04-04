import 'package:flutter/material.dart';

class CatalogosSeguimientoControlSv {
  final _nombreScpe = [
    'Sitio de cuarentena pos entrada',
    'Centro de cuarentena (exposición)',
  ];

  final _tipoCuarentena = [
    'Cuarentena abierta',
    'Cuarentena cerrada',
  ];

  final _faseSeguimiento = [
    'Instalación cuarentena pos entrada',
    'Seguimiento cuarentena pos entrada',
  ];

  final _actividad = [
    'Monitoreo de malezas',
    'Monitoreo de plagas cuarentenarias',
    'Monitoreo de plagas Transitorias',
    'Monitoreo de plagas en principales cultivos',
    'Notificación Fitosanitaria',
  ];

  final _etapaCultivo = [
    'Rastrojo/barbecho',
    'Macollamiento / brotación',
    'Desarrollo vegetativo',
    'Floración',
    'Fructificación',
    'Pre-cosecha',
    'Cosecha',
    'Post-cosecha',
  ];

  final _fasePlaga = [
    'Planta',
    'Desarrollo vegetativo',
    'Huevo',
    'Larva/ninfa',
    'Pupa',
    'Imago/adulto',
    'N/A',
  ];

  final _organoAfectado = [
    'Brote',
    'Grano',
    'Semillas',
    'Bulbo/tubérculo/rizoma',
    'Cormo',
    'Foliolo',
    'Hoja',
    'Flor',
    'Fruto/grano/semilla/vaina',
    'Inflorescencia',
    'Raíz',
    'Rama/ramilla',
    'Tallo/tronco',
    'Plántula',
    'Toda la planta',
  ];

  final _distribucionPlaga = [
    'Brote',
    'Distribución generalizada',
  ];

  List<String> getSitioMuestreo() {
    return _nombreScpe;
  }

  List<DropdownMenuItem<String>> getTipoOperacionDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _nombreScpe) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getTipoCuarentenaDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _tipoCuarentena) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getFaseSeguimientoDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _faseSeguimiento) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getActvidadDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _actividad) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getEtapaCultivoDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _etapaCultivo) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getFasePlagaDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _fasePlaga) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getOrganoAfectadoDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _organoAfectado) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDistribucionPlagaDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _distribucionPlaga) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<String> getFasePlagaListString() {
    List<String> items = [];
    for (String item in _fasePlaga) {
      items.add(item);
    }
    return items;
  }

  List<String> getOrganoAfectadoListString() {
    List<String> items = [];
    for (String item in _organoAfectado) {
      items.add(item);
    }
    return items;
  }

  List<String> getDistribucionPlagaListString() {
    List<String> items = [];
    for (String item in _distribucionPlaga) {
      items.add(item);
    }
    return items;
  }
}
