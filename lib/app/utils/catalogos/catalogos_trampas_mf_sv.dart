import 'package:flutter/material.dart';

class CatalogoTrampasMfSv {
  final _condicion = [
    'Bueno',
    'Dañado',
    'Extraviado',
  ];

  final _especie = [
    'NO APLICA',
    'ABRIDOR',
    'ALBARICOQUE',
    'ACHOTILLO',
    'AGUACATE',
    'AJÍ',
    'ALMEDRO',
    'ARAZÁ',
    'ARROZ',
    'ARÁNDANO',
    'ARVEJA',
    'AVENA',
    'BABACO',
    'BANANO',
    'BADEA',
    'BERENJENA',
    'BOROJÓ',
    'BOSQUE',
    'BOSQUE SECUNDARIO',
    'CACAO',
    'CAFÉ',
    'CAIMITO',
    'CAÑA',
    'CAPULÍ',
    'CARAMBOLA',
    'CAUJE, ABIO, CAIMITO',
    'CEBADA',
    'CEDRO',
    'CENTRO DE ACOPIO',
    'CEREZA',
    'CEREZA CHINA',
    'CHIGUALCAN',
    'CHIRIMOYA',
    'CHIRIMOYUELA',
    'CIRUELA',
    'CIRUELO',
    'CIRUELO CHINO',
    'CLAUDIA',
    'COCO',
    'DURAZNO',
    'FEIJOA',
    'FRÉJOL',
    'FRUTERIA',
    'FRUTILLA',
    'GRANADA',
    'GRANADINA',
    'GRANADILLA',
    'GROCELLA',
    'GUABA',
    'GUABA MACHETÓN',
    'GUABA SERRANA',
    'GUANÁBANA',
    'GUAYABA',
    'GUAYTAMBO',
    'HIGO',
    'KIWI',
    'LIMA',
    'LIMÓN',
    'LUCMA O LÚCUMA',
    'MAÍZ',
    'MAMEY COLORADO',
    'MANDARINA',
    'MANDARINA CLEOPATRA',
    'MANGO',
    'MANZANA',
    'MAQUEÑO',
    'MARACUYÁ',
    'MELÓN',
    'MERCADOS',
    'MIRTO',
    'MORA',
    'NARANJA',
    'NARANJA AGRIA',
    'NARANJA DULCE',
    'NARANJA TRIFOLIA',
    'NARANJILLA',
    'NÍSPERO',
    'NÍSPERO TROPICAL',
    'NOGAL Ó TOCTE',
    'ORITO',
    'OVO',
    'PALMA AFRICANA',
    'PAPAYA',
    'PASTO',
    'PECHICHE',
    'PEPINILLO',
    'PEPINO DULCE',
    'PERA',
    'PERA DE AGUA',
    'PIMIENTO',
    'PIÑA',
    'PITAHAYA AMARILLA',
    'PITAHAYA ROJA',
    'PLÁTANO ARTÓN',
    'PLÁTANO BARRAGANETE',
    'PLÁTANO DOMINICO',
    'PLÁTANO SEDA',
    'POMARROSA',
    'POMELO',
    'POSTE',
    'QUINUA',
    'REINA CLAUDIA',
    'SANDÍA',
    'SHAWI',
    'SOYA',
    'SWINGLE',
    'TAMARINDO',
    'TANGELO',
    'TAXO',
    'TE',
    'TOCTE',
    'TOMATE DE ÁRBOL',
    'TORONJA',
    'TRIGO',
    'TUNA',
    'UVA',
    'UVA DE MONTE',
    'UVILLA',
    'YUCA',
    'ZAPALLO',
    'ZAPOTE',
    'ZAPOTILLO',
  ];

  final _estadoFenologicoPrincipal = [
    'No aplica',
    'Desarrollo vegetativo',
    'Floración',
    'Fructificación',
  ];

  final _tipoMuestra = [
    'Laminilla',
    'Insectos en alcohol',
  ];

  List<DropdownMenuItem<String>> getCondicion() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _condicion) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getEspecie() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _especie) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<String> getEspecieLista() {
    return _especie;
  }

  List<DropdownMenuItem<String>> getEstadoFenologico() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _estadoFenologicoPrincipal) {
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
}
